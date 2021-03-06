set interfaces ethernet eth0 address '2.1.1.2/30'
set interfaces ethernet eth0 description 'WAN2'
set interfaces ethernet eth0 duplex 'auto'
set interfaces ethernet eth0 hw-id '52:54:00:61:7d:43'
set interfaces ethernet eth0 smp_affinity 'auto'
set interfaces ethernet eth0 speed 'auto'
set interfaces ethernet eth1 address '172.25.0.1/24'
set interfaces ethernet eth1 description 'LAN3'
set interfaces ethernet eth1 duplex 'auto'
set interfaces ethernet eth1 hw-id '52:54:00:7e:3e:1a'
set interfaces ethernet eth1 smp_affinity 'auto'
set interfaces ethernet eth1 speed 'auto'
set interfaces loopback 'lo'
set protocols bgp 64513 neighbor 2.1.1.1 ebgp-multihop '2'
set protocols bgp 64513 neighbor 2.1.1.1 remote-as '64511'
set protocols bgp 64513 neighbor 2.1.1.1 update-source '2.1.1.2'
set protocols bgp 64513 network '172.25.0.0/24'
set protocols bgp 64513 parameters router-id '2.1.1.2'
set service dhcp-relay interface 'eth1'
set service dhcp-relay relay-options hop-count '10'
set service dhcp-relay relay-options max-size '576'
set service dhcp-relay relay-options relay-agents-packets 'forward'
set service dhcp-relay server '172.24.0.2'
set service dhcp-server disabled 'true'
set service dhcp-server shared-network-name LAN3 authoritative 'disable'
set service dhcp-server shared-network-name LAN3 subnet 172.25.0.0/24 default-router '172.25.0.1'
set service dhcp-server shared-network-name LAN3 subnet 172.25.0.0/24 dns-server '172.25.0.1'
set service dhcp-server shared-network-name LAN3 subnet 172.25.0.0/24 lease '86400'
set service dhcp-server shared-network-name LAN3 subnet 172.25.0.0/24 start 172.25.0.200 stop '172.25.0.254'
set service dns forwarding cache-size '0'
set service dns forwarding listen-on 'eth1'
set service dns forwarding name-server '192.168.114.14'
set service dns forwarding name-server '192.168.114.15'
set service ssh port '22'
set system config-management commit-revisions '20'
set system console device ttyS0 speed '9600'
set system host-name 'dc-3-aggr-sw-1'
set system login user vyos authentication encrypted-password '$1$E1cByOvC$9qR8Oscv09smG5c20dqYn0'
set system login user vyos authentication plaintext-password ''
set system login user vyos level 'admin'
set system ntp server '0.pool.ntp.org'
set system ntp server '1.pool.ntp.org'
set system ntp server '2.pool.ntp.org'
set system package auto-sync '1'
set system package repository community components 'main'
set system package repository community distribution 'helium'
set system package repository community password ''
set system package repository community url 'http://packages.vyos.net/vyos'
set system package repository community username ''
set system syslog global facility all level 'notice'
set system syslog global facility protocols level 'debug'
set system time-zone 'UTC'
