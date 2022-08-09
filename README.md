# Gitea Docker Compose

Docker compose para correr una instancia de gitea

## Dependencias

- Docker (Apéndice)

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

## Instalación

La primera vez que accedemos nos va a pedir datos para configurar la instalación.

Lo único que hay que cambiar de este formulario es el campo: __Título del sitio__.

Nota: NO CAMBIAR _Puerto de escucha HTTP de Gitea_ ni _URL base de Gitea_
porque el contenedor esta armado para mapear esos puertos al que está definido en __.env__.

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

# Apéndice

## Instalación de docker en ubuntu 18.04/20.04

Fuente: [Instalación docker ubuntu](https://docs.docker.com/engine/install/ubuntu).

```bash
$ sudo apt-get update
$ sudo apt-get install \
    ca-certificates \
    curl \
    gnupg \
    lsb-release

$ curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

$ echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

$ sudo apt-get update
$ sudo apt-get install docker-ce docker-ce-cli containerd.io docker-compose-plugin
```
