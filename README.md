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
