#!/usr/bin/env bash

SCRIPT_PATH=$(realpath $0)
WORKDIR=$(dirname ${SCRIPT_PATH})
LOG_DIR=${WORKDIR}/backup.log
FECHA=`date +%Y%m%d`

echo [`date`] ========== Comenzando script Backup - GITEA ========== >> $LOG_DIR

echo [`date`] ::Comprimiendo ${WORKDIR}/data a ${WORKDIR}/backups/backupGitea${FECHA}.zip >> $LOG_DIR
zip -r ${WORKDIR}/backups/backupGitea${FECHA}.zip ${WORKDIR}/data
echo [`date`] ___ OK >> $LOG_DIR
echo ------------------------------------ >> $LOG_DIR

echo [`date`] ::Copiando de ${WORKDIR}/backupGitea${FECHA}.gzip a lautaro@192.168.150.50:/home/lautaro/Backups_150/gitea/gitea_2022 >> $LOG_DIR
scp ${WORKDIR}/backups/backupGitea${FECHA}.zip lautaro@192.168.150.50:/home/lautaro/Backups_150/gitea/gitea_2022
echo [`date`] ___ OK >> $LOG_DIR
echo ------------------------------------ >> $LOG_DIR

echo [`date`] ::Eliminando ${WORKDIR}/backups/backupGitea${FECHA}.zip >> $LOG_DIR
rm ${WORKDIR}/backups/backupGitea${FECHA}.zip
echo [`date`] ___ OK >> $LOG_DIR
echo ------------------------------------ >> $LOG_DIR

exit 0

