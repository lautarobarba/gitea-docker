#!/usr/bin/env bash

LOG_DIR=./backup.log
FECHA=`date +%Y%m%d`

echo [`date`] ========== Comenzando script Backup - GITEA ========== >> $LOG_DIR

echo [`date`] ::Comprimiendo $(pwd)/data a $(pwd)/backups/backupGitea${FECHA}.zip >> $LOG_DIR
sudo zip -r ./backups/backupGitea${FECHA}.zip data
echo [`date`] ___ OK >> $LOG_DIR
echo ------------------------------------ >> $LOG_DIR
echo [`date`] ::Copiando de $(pwd)/backupGitea${FECHA}.gzip a lautaro@192.168.150.50:/home/lautaro/Backups_150/gitea/gitea_2022 >> $LOG_DIR
sudo scp ./backups/backupGitea${FECHA}.zip lautaro@192.168.150.50:/home/lautaro/Backups_150/gitea/gitea_2022
echo [`date`] ___ OK >> $LOG_DIR
echo ------------------------------------ >> $LOG_DIR
echo [`date`] ::Eliminando ./backups/backupGitea${FECHA}.zip >> $LOG_DIR
sudo rm ./backups/backupGitea${FECHA}.zip
echo [`date`] ___ OK >> $LOG_DIR
echo ------------------------------------ >> $LOG_DIR
exit 0
