# Gitea Docker Compose

Docker compose para correr una instancia de gitea

## Dependencias

- Docker

## Configuración

```bash
$ cp .env.example .env
$ nano .env
```

## Iniciar

```bash
$ docker compose up -d prod
```

_Quitando la opción *-d* se ven los logs del contenedor._

## Detener

```bash
$ # Si estan corriendo con logs visibles
$ #     detener con Ctr+C
$ docker compose down
```

## Documentación

General: [Link](https://docs.gitea.io/en-us/)

Instalación: [Link](https://docs.gitea.io/en-us/install-with-docker/)

## Backups

Se creó un volumen para guardar los _backups_ en **/backups**.
Se creó un script para ejecutar con cron.

### Realizar backup manual

```bash
$ sudo zip -r backupGitea${FECHA}.zip data
```

### Restaurar backup

1. Hay que asegurarse de tener el backup en la carpeta **/backups**.

```bash
$ sudo rm -rf data
$ sudo unzip backups/NOMBRE_BACKUP.zip
```

## Programar backups automáticos (CRON)

### Prerrequisitos

En el servidor de destino tiene que estar configurado ssh para aceptar autenticación con Public Keys.

```bash
$ # En el servidor de destino
$ sudo nano /etc/ssh/sshd_config
$ # Descomentar la linea que tiene: PubkeyAuthentication yes
$ sudo systemctl restart sshd.service
$ #------------------------------------------------------------------------------
$ # En el servidor de origen del backup (USUARIO ROOT)
root$ # Generar las claves del usuario que va a ejecutar el script en este equipo
root$ ssh-keygen
root$ ssh-copy-id USUARIO@SERVIDOR_DESTINO
```

### Programar tarea

```bash
$ # En el servidor de origen del backup
$ cp backup_cron.sh.example backup_cron.sh
$ # Configurar el destino. Editar la linea #DEST=usuaro@host:/path
$ nano backup_cron.sh
$ # Programar la tarea con cron (USUARIO ROOT)
root$ crontab -e
root$ # En cron:
			# Para probar un backup cada 5 minutos
			*/5 * * * * /ruta_al_script/backup_cron.sh

			# Para dejar el backup 1 vez por dia
			0 0 * * * /ruta_al_script/backup_cron.sh
```
