FROM selenium/standalone-chrome:latest

# Install Python and pip
USER root
RUN apt-get update && \
    apt-get install -y python3 python3-pip

# FIXME: --break-system-packages is not ideal. To get around it we need to setup and use a python venv which is a bit pointless for a shortlived docker image
RUN pip3 install selenium --break-system-packages

COPY hello.py /home/seluser/hello.py

WORKDIR /home/seluser

RUN chown seluser:seluser hello.py

USER seluser

CMD ["python3", "hello.py"]