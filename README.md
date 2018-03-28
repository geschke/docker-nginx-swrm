# geschke/nginx-swrm

This is a minimal Nginx Docker image based on Ubuntu Bionic.

## Usage

This image is intended for running as webserver component in a Docker swarm mode 
environment. 

To download the container run

    docker pull geschke/nginx-swrm
    
To start, put the Nginx configuration in some directory and let the system run. 

    sudo docker run -d --name nginx --restart=always \
        -v /srv/docker/nginx/sites-enabled:/etc/nginx/sites-enabled \
        -v /srv/docker/nginx/conf.d:/etc/nginx/conf.d \
        --publish <port_on_host>:80 --link whatever:you_like \
        geschke/nginx-swrm

There is an example of a configuration as reverse proxy in the files/sites-enabled/ directory. Please put your configuration files into a similar directory on your server. 

Example of filesystem:

	/srv/docker/nginx/
			  sites-enabled/
			  conf.d/
			  www/

If you start the Nginx container with the above command, put the (virtual) hosts configuration into the sites-enabled directory. This is similar to the Ubuntu approach, only without using symlinks. 

You'll find an initial Nginx configuration in the Github project. 


## Usage example with Docker swarm mode

coming soon...

## More Info

Coming soon...