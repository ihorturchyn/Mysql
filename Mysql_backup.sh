#!/bin/bash
DATE=$(date +%m-%d-%Y)
BACKUP_DIR="/home/igorturchin"
LOG_FILE="/home/igorturchin/Scripts/NewScripts/Log_file"
#добавил проверку запущенного MysqlD. Если он не запущен - то и бекапировать нечего будет. В будущем добавлю отдельную процедуру для запуска mysql 
#если таковой не будет запущен.
Process=mysqld
Checking=`ps -A | grep $Process`
if [ "${Checking:-null}" = null ]; then
    echo "Process Mysqld is not running at $DATE" >> $LOG_FILE
else
    souce_backup=$(mysqldump --user=root --password=S9DgmH}d --result-file=$BACKUP_DIR/Backup_$DATE.sql --all-databases)
    if [ -f "$BACKUP_DIR/Backup_$DATE.sql" ]; then
        chmod 777 "$BACKUP_DIR/Backup_$DATE.sql"
        tar -zcvpf $BACKUP_DIR/Backup_$DATE.sql.tar.gz $BACKUP_DIR/Backup_$DATE.sql
        echo "At $DATE Backup was created $BACKUP_DIR/Backup_$DATE.sql.tar.gz" >> $LOG_FILE
        echo "OK"
    else
        echo "Backup $BACKUP_DIR/Backup_$DATE.sql.tar.gz was not created" >> $LOG_FILE
    fi
fi
