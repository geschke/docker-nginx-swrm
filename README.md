# geschke/nginx-swrm

Minimal **Nginx Docker image** based on **Ubuntu LTS distributions**.

The image provides a predictable Nginx environment using the **official Ubuntu Nginx packages**. This ensures long-term stability, security updates, and behavior similar to a standard Ubuntu server installation.

The repository name still contains `swrm` for historical reasons. The image was originally created for Docker Swarm deployments but is today mainly used as a **general-purpose Nginx container for standard Docker setups**.

## Why this image exists

Many Nginx Docker images are based on Alpine Linux or custom builds.

This image follows a different approach:

* Ubuntu **LTS base images**
* Nginx from the **official Ubuntu repositories**
* predictable package versions
* long-term **security updates via Ubuntu**

The goal is to provide a **stable and low-maintenance container** that behaves similarly to a typical Ubuntu server installation.

## Supported Versions

| Nginx | Ubuntu Base      | Tag Pattern        |
| ----- | ---------------- | ------------------ |
| 1.24  | Ubuntu 24.04 LTS | `latest`, `1.24-*` |
| 1.18  | Ubuntu 22.04 LTS | `1.18-*`           |

The Nginx version corresponds to the version shipped with the respective Ubuntu LTS release.

## Image Tags

Image tags follow the Nginx version plus an internal image revision number.

Examples:

```
latest
1.24-6
1.24-4
1.18-6
...
```

`latest` always refers to the **current Ubuntu LTS based image maintained in this repository**.

## Pulling the Image

```
docker pull geschke/nginx-swrm
```

## Running the Container

Example:

```
docker run -d \
  --name nginx \
  --restart unless-stopped \
  -p 80:80 \
  -v /srv/docker/nginx/html:/var/www/html \
  -v /srv/docker/nginx/sites-enabled:/etc/nginx/sites-enabled \
  -v /srv/docker/nginx/conf.d:/etc/nginx/conf.d \
  geschke/nginx-swrm:latest
```

In this example:

* website content from the host directory `/srv/docker/nginx/html` is mounted to `/var/www/html` inside the container
* virtual host configuration from `/srv/docker/nginx/sites-enabled` is mounted to `/etc/nginx/sites-enabled`
* additional Nginx configuration snippets from `/srv/docker/nginx/conf.d` are mounted to `/etc/nginx/conf.d`

This keeps the container image itself unchanged while configuration and website data remain on the host system.

## Docker Compose Example

A simple `docker compose` setup may look like this `compose.yaml`:

```yaml
services:
  nginx:
    image: geschke/nginx-swrm:latest
    restart: unless-stopped
    ports:
      - "80:80"
    volumes:
      - ./html:/var/www/html
      - ./nginx/sites-enabled:/etc/nginx/sites-enabled
      - ./nginx/conf.d:/etc/nginx/conf.d
```

Start it with:

```
docker compose up -d
```

In this example:

* the local directory `./html` contains the website content
* the local directory `./nginx/sites-enabled` contains the virtual host configuration
* the local directory `./nginx/conf.d` contains additional Nginx configuration snippets


## Example Directory Layout

A simple project structure could look like this:

```
project-directory/
├── compose.yaml
├── html/
│   └── index.html
└── nginx/
    ├── sites-enabled/
    │   └── default
    └── conf.d/
        └── compression.conf
```

* `html/` contains the website content
* `nginx/sites-enabled/` contains virtual host configurations
* `nginx/conf.d/` contains additional Nginx configuration snippets

The names of the host directories are completely arbitrary. They are simply mounted to the appropriate locations inside the container.

## Configuration

The container follows the **standard Ubuntu Nginx configuration layout**.

Typical locations inside the container include:

* `/etc/nginx/sites-enabled` for virtual host configuration
* `/etc/nginx/conf.d` for additional configuration snippets
* `/var/www/html` for website content

These directories can be populated through **bind mounts or similar Docker mechanisms** from the host system. This allows you to manage configuration and content outside the container while keeping the container image itself immutable.

## Typical Use Cases

The container can be used for example as:

* reverse proxy
* frontend for containerized services
* static web hosting
* simple load balancing

## License

MIT License
