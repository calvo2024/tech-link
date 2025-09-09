## Accelerator to deploy on the fly Vault clusters

Steps to reproduce:

1. First we need to package the needed configurations by executing from the parent folder:
    
    ` Make build .`

2. After the make has finished, we should deploy the initial configuration by executing:
   
   `docker compose up -d` if you are using mac or `docker-compose -up`if you are not

3. Once you have executed this command, a two node server will be created called *tech-link*. You should see something similar to this:

![containers created](images/image.png)