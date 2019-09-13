#!/usr/bin/python

import _mysql
import sys
import argparse
import logging
import os
import socket

#logging.basicConfig(level=logging.NOTSET)
logging.basicConfig(level=logging.ERROR)

def get_args_parser():
  parser = argparse.ArgumentParser(add_help=False)
  parser.add_argument(
    "-h", "--host",
    default="localhost",
    nargs='?',
    type=str,
    help="Connect to host.")
  parser.add_argument(
    "-P", "--port",
    default=3306,
    nargs='?',
    type=int,
    help="Port number to use for connection.")
  parser.add_argument(
    "-u", "--user",
    default='root',
    nargs='?',
    type=str,
    help="User for login if not current user.")
  parser.add_argument(
    "-p", "--password",
    default='',
    nargs='?',
    type=str,
    help="Password to use when connecting to server.")
  parser.add_argument(
    "-i", "--items",
    default='all',
    nargs='?',
    type=str,
    help="Select variable")
  parser.add_argument(
    "-e", "--encoded",
    default=False,
    action='store_true',
    help="Encoded item variables"
  )
  parser.add_argument(
    "--debug",
    default=False,
    action='store_true',
    help="Port number to use for connection.")
  parser.add_argument(
    "--help",
    default=False,
    action='store_true',
    help="Show this help"
  )
  return parser

#main
if __name__ == '__main__':
  parser = get_args_parser()
  args = parser.parse_args()
  if args.help:
    parser.print_help()
    parser.exit()
  try:
    db = _mysql.connect(
      host=args.host,
      port=args.port,
      user=args.user,
      passwd=args.password
    )
  except Exception, err:
    logging.exception(err)
    print err
    sys.exit()

  qstatus='select User, count(*) from information_schema.processlist group by User;' 
  db.query(qstatus)
  sqlresult = db.store_result().fetch_row(0)
  logging.debug(sqlresult)
  db.close()
 
  for row in sqlresult:
  	user = row[0] 
	user = ''.join(user.split())
	processlist = row[1]
 	print 'host.mysql_user.%s %s' % (user,processlist)
  #print 'processlist ',processlist

  #print 'SQL Result - ',sqlresult
  #print 'SQLRESULT - ',sqlresult
  #print (' '.join(result), end='')
  #sys.stdout.write('\n'.join(result))


