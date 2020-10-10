# Postgresql

## Getting started

Postgresql client

  # connect to postgresql
  psql -h HOST -U USER -d DATABASE

Postgresql client commands

  # list roles
  \du
  # list all the databases
  \l
  # list tables in connected database
  \dt
  # list schemas
  \dn
  # list columns in the table
  \d table
  # list functions
  \df
  # quit
  \q

Postgresql administration using psql

  # Create role
  CREATE ROLE role1 WITH LOGIN PASSWORD 'password1' CREATEDB;
  # Alter role
  ALTER ROLE role1 CREATEROLE CREATEDB REPLICATION SUPERUSER;
  # Drop role
  DROP ROLE role1;
  # Create user
  CREATE USER user1 WITH PASSWORD 'password1';
  # Create database
  CREATE DATABASE db1 OWNER user1;

Postgresql cluster management

  # Check installed clusters and obtain basic info
  pg\_lsclusters
  # Start/stop/start/reload a cluster
  pg\_ctlcluster
  # Completely delete a cluster
  pg\_dropcluster
  # Create a cluster
  pg\_createcluster

## Backup and restore

Backup database with default options

  pg\_dump mydb > mydb.bak.sql

Backup database with customised options

  pg\_dump -c -C -F p -f mydb.bak.sql mydb
  # -c : output commands to clean(drop) database objects prior to writing
  # commands to create them
  # -C : begin output with "CREATE DATABASE" command itself and reconnect to
  # created database
  # -F : format of the output (value p means plain SQL output and value c means
  # custom archive format suitable for pg\_restore)
  # -f : backup output file name

Remote backup

  pg\_dump -h HOST -p PORT -U USER -f mydb.bak mydb

Backup all databases

  pg\_dumpall alldb.bak.sql

Restore from backup file (.sql)

  psql -U USER -f FILENAME.sql

Restore from custom archive backup file (.bak)

  pg\_restore -d mydb /path/to/backup/file/FILENAME.bak -c -U USER

## References

* https://wiki.debian.org/PostgreSql
* https://postgrescheatsheet.com
