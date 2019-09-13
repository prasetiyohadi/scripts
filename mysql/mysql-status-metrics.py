#!/usr/bin/python

import _mysql
import sys
import argparse
import logging
import os
import socket

#logging.basicConfig(level=logging.NOTSET)
logging.basicConfig(level=logging.ERROR)
keystats = {
  'Key_read_requests'          : 'a0',
  'Key_reads'                  : 'a1',
  'Key_write_requests'         : 'a2',
  'Key_writes'                 : 'a3',
  'history_list'               : 'a4',
  'innodb_transactions'        : 'a5',
  'Com_execute_sql'            : 'a6'
}

execfile(sys.path[0]+'/mysql-status-metrics-var.py')
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
  listitems = []
  if args.items.upper() == 'ALL':
    if args.encoded:
      for i in keystats.iteritems():
        listitems.append(i[1])
    else:
      for i in keystats.iteritems():
        listitems.append(i[0])
      listitems.sort()
  else:
    listitems = args.items.split(',')
  qstatus='SHOW GLOBAL STATUS'
  qvar='SHOW VARIABLES' 
  db.query(qstatus)
  sqlresult = db.store_result().fetch_row(0)
  logging.debug(sqlresult)
  db.close()
  status = {}
  for row in sqlresult:
    try:
      if args.encoded:
        status[keystats[row[0]]]=row[1]
      else:
        status[row[0]]=row[1]        
    except Exception, err:
      logging.info('No key '+str(err)+' in keystats list')
  #print 'STATUS - ',status
  #print 'SQLRESULT - ',sqlresult
  result=[]
  for k in listitems:
    if args.encoded:
      kout = k
    else:
      kout = socket.gethostname()+'.'+k
    try:
      result.append(kout+' '+status[k])
    except Exception, err:
      result.append(kout+' 0')
      logging.info('Mapping variable '+str(err)+' not available in global status of target host')
  #print (' '.join(result), end='')
  sys.stdout.write('\n'.join(result))

  

