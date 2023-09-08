# template-project

To set up a development environment for Python projects using docker-compose and mamba without any pre-existing Anaconda, Conda, or Miniconda, follow these steps:

### Prerequisites
1. **Install Docker**: If you haven't installed Docker, download and install it from the [official website](https://www.docker.com/products/docker-desktop).

### Project Setup
1. **Create Project Folders**: For each project, create a dedicated folder.
    ```bash
    mkdir Project_1 Project_2
    ```
  
2. **Initialize Docker-Compose File**: In each project folder, create a `docker-compose.yml` file.
    ```bash
    cd Project_1
    touch docker-compose.yml
    ```

### Docker-Compose Configuration
3. **Define Services**: Inside the `docker-compose.yml` file, define the services you need. For example, for the backend, specify a Python image and mount the source code. Also, specify installing mamba as part of the build process.
    ```yaml
    version: '3'
    services:
      backend:
        image: python:3.8
        volumes:
          - ./Backend:/app
        build: 
          context: ./Backend
          Dockerfile: Dockerfile
    ```

4. **Dockerfile for Mamba**: In the same folder where your backend code resides, create a `Dockerfile` to install mamba.
    ```Dockerfile
    FROM python:3.8
    RUN apt-get update && \
        apt-get install -y wget && \
        wget -qO- https://micromamba.snakepit.net/api/micromamba/linux-64/latest | tar xvj bin/micromamba
    CMD ["tail", "-f", "/dev/null"] # This will keep the container alive
    ```

5. **Mamba Environment File**: Create a `mamba_environment.yml` file in the Backend folder to specify Python packages.
    ```yaml
    name: myenv
    channels:
      - defaults
    dependencies:
      - numpy
      - pandas
    ```

### Initialization and Usage
6. **Build and Start Containers**: In the terminal, navigate to the project folder and run:
    ```bash
    docker-compose up --build
    ```

7. **Access the Mamba Environment**: Once the container is running, you can exec into it to manage your Python environment using mamba.
    ```bash
    docker exec -it [CONTAINER_ID] /bin/bash
    micromamba activate myenv
    ```

8. **Repeat for Other Projects**: For each new project, repeat steps 1-7.

By following these steps, you can efficiently manage multiple Python projects using docker-compose and mamba without the need for Anaconda, Conda, or Miniconda.
