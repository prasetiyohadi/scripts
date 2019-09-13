#!/usr/bin/perl

use strict;
use Getopt::Long;
use vars qw (%Config);
use Time::Local;
use POSIX 'strftime';
use Sys::Hostname;

unless(GetOptions(
    "debug" => \$Config{debug},
    "prefix=s" => \$Config{prefix},
    "graphite-server=s" => \$Config{graphite},
       )) {
    print STDERR "Invalid usage\n";
    exit 1;
}


&main;

sub main {
 #  open(my $sensors, "sensors|") || die("Failed to run sensors: $!");

    my $now = strftime("%s", localtime);

 #  unless(defined $Config{prefix}) {
 #  $Config{prefix} = "system." . hostname;
 #   }

 #   my $graphite;
 #   if($Config{graphite}) {
 #       open($graphite, "|nc -q 2 $Config{graphite} 2003") || die("Failed to netcat to $Config{graphite}: $!");
 #  select $graphite; 
 #   }

    opendir(my $dir, "/dev") || die("Can't read /dev: $!");

    my @devices = readdir($dir);

    closedir $dir;

    my @drives = grep { /^sd[a-z]$/ } @devices;

    &write("drive.count", scalar(@drives), $now);


    foreach my $drive (@drives) {
  &smartmon("$drive", $now);
    }

 #   close $graphite if $graphite;
}

sub smartmon {
    my $drive = shift;
    my $now = shift;
    my $device = "/dev/$drive";

    my $smon;


#    my $SN = "smartctl -a $device";
#    my @arrSN = <$SN>;
#    my @grepSN = grep /Serial/i, @arrSN;
    my $cmd = "smartctl -a $device";
    unless(open($smon, "$cmd|")) {
  print STDERR "$cmd failed: $!\n";
  return 0;
    }

    # skip to the good stuff
    my $sn;
    while(<$smon>) {
  if(/serial/i) {
    /(\S+$)/;
    $sn = $1;
  }
  last if  /^ID/;
    }

    while(<$smon>) {  
  s/^\s*//;
#        print;
        if(/smart/i) {
#   print "asd $_";
    last;
  } elsif(/^$/) {
#   print "emptystring";
    next;
  }

  my ($id, $name, $flag, $val, $worst, $thresh, $type, $updated, $whenfailed, $rawvalue) = split(/\s+/);
  &write("$sn.value_$name.$drive", $val, $now);
  &write("$sn.thresholds_$name.$drive", $thresh, $now);
        &write("$sn.rawvalue_$name.$drive", $rawvalue, $now);

# if(/Temperature|Pending_Sector|Uncorrectable/) {
#     &write("drive.$drive.$name", $rawvalue, $now);
# }
    }

    close $smon;
}


sub write {
    my $key = shift;
    my $value = shift;
    my $date = shift;

    my $metric = "$key";

    $metric =~ s/[^a-zA-Z0-9_\.]/_/g;

    print "$metric $value $date\n";
}

