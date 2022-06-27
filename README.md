# Gitea Docker Compose

Docker compose para correr una instancia de gitea

## Dependencias

- Docker

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
