To start, run `docker-compose up --build`.

This will execute the `hello.py` script once and write STDOUT to the host console. The virtual directory `./output` is mapped to the `./output` directory in the host.

The official image from selenium comes with Python, Chrome and Chromedriver (a version compatible with the installed Chrome) already. We modify it so that it has the python selenium package, and execute our python script inside the container.