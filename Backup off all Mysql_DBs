#!/bin/bash
DATE=$(date +%d-%m-%Y-%H-%M-%S)
BACKUP_DIR="path to directory"
LOG_FILE="path to log file"
Process=mysqld
Checking=`ps -A | grep $Process`
function backuping() {
    souce_backup=$(mysqldump --user=root --password=[password] --result-file=$BACKUP_DIR/Backup_$DATE.sql --all-databases)
    if [ -f "$BACKUP_DIR/Backup_$DATE.sql" ]; then
        chmod +x "$BACKUP_DIR/Backup_$DATE.sql"
        tar -zcvpf $BACKUP_DIR/Backup_$DATE.sql.tar.gz $BACKUP_DIR/Backup_$DATE.sql
        echo "At $DATE Backup was created $BACKUP_DIR/Backup_$DATE.sql.tar.gz" >> $LOG_FILE
    else
        echo "Backup $BACKUP_DIR/Backup_$DATE.sql.tar.gz was not created" >> $LOG_FILE
    fi
}
if [ "${Checking:-null}" = null ]; then
    echo "Process Mysqld is not running at $DATE" >> $LOG_FILE
    Running=`service mysql restart`                               #starting service mysql when it was not runned before
        if [ $? -eq 0 ]; then
            backuping
        else
            echo "Process mysql can not be runned at $DATE"
        fi
else
    backuping
fi

