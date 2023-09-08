FROM python:3.11
RUN apt update && \
    apt install -y wget && \
    wget -qO- https://micromamba.snakepit.net/api/micromamba/linux-64/latest | tar xvj bin/micromamba

CMD ["tail", "-f", "/dev/null"] # This will keep the container alive
