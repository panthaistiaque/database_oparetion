#!/bin/bash
#----------------------------------------
# OPTIONS
#----------------------------------------
HOSTNAME='192.168.10.122'
PORT='5432'
USERNAME='######'
PASSWORD='######'
DAYS_TO_KEEP=15
DATABASE='eho#_1_3_1'
BACKUP_PATH='/d/DBBackup/fhs'
NOW="$(date +'%Y%m%d_%H%M')"
#----------------------------------------
# Create the backup folder
#----------------------------------------
if [ ! -d $BACKUP_PATH ]; then
  mkdir -p $BACKUP_PATH
fi
#----------------------------------------
# Create the backup folder
#----------------------------------------
if [ "$DAYS_TO_KEEP" -gt 0 ]; then
  echo "Deleting backups older than $DAYS_TO_KEEP days"
  find $BACKUP_PATH/* -mtime +$DAYS_TO_KEEP -exec rm {} \;
fi
#----------------------------------------
# DB backup Start
#----------------------------------------
echo "Pulling Database: This may take a few minutes"
export PGPASSWORD="$PASSWORD"
pg_dump -h $HOSTNAME -p $PORT -U $USERNAME -F c -b -v -f  $BACKUP_PATH/"$NOW"_$DATABASE.backup $DATABASE
unset PGPASSWORD

echo "Pull Complete"
