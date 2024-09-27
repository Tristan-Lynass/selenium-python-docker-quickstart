# Use an official Linux base image
FROM ubuntu:20.04

# Set environment variable for non-interactive installs
ENV DEBIAN_FRONTEND=noninteractive

# Install chrome dependencies
RUN apt-get update && apt-get install -y \
    libx11-xcb1 \
    libxcomposite1 \
    libxcursor1 \
    libxdamage1 \
    libxrandr2 \
    libgbm1 \
    libasound2 \
    libatk1.0-0 \
    libatk-bridge2.0-0 \
    libcups2 \
    libdrm2 \
    libxss1 \
    fonts-liberation \
    libappindicator3-1 \
    xdg-utils \
    libnss3 \
    libnspr4 \
    libgconf-2-4 \
    libxshmfence1 \
    libgtk-3-0 \
    libu2f-udev \
    libvulkan1 \
    --no-install-recommends

RUN apt-get install -y wget jq unzip
WORKDIR /chrome
RUN wget -O known-good-versions.json "https://googlechromelabs.github.io/chrome-for-testing/known-good-versions-with-downloads.json"

RUN chrome_url=$(cat known-good-versions.json | jq -r '.versions[-1].downloads.chrome[] | select(.platform=="linux64") | .url') && wget -O chrome-linux64.zip "$chrome_url"
RUN unzip chrome-linux64.zip && rm chrome-linux64.zip
ENV CHROME_BIN=/chrome/chrome-linux64/chrome
RUN ln -s $CHROME_BIN /usr/local/bin/chrome
RUN chmod +x $CHROME_BIN

RUN chromedriver_url=$(cat known-good-versions.json | jq -r '.versions[-1].downloads.chromedriver[] | select(.platform=="linux64") | .url') && wget -O chromedriver-linux64.zip "$chromedriver_url"
RUN unzip chromedriver-linux64.zip && rm chromedriver-linux64.zip
RUN chmod +x /chrome/chromedriver-linux64/chromedriver
ENV CHROMEDRIVER_BIN=/chrome/chromedriver-linux64/chromedriver
RUN ln -s $CHROMEDRIVER_BIN /usr/local/bin/chromedriver
RUN chmod +x $CHROMEDRIVER_BIN

WORKDIR /app

RUN apt-get install -y \
    python3 \
    python3-venv \
    python3-pip \
    && apt-get clean

# Create and activate a virtual environment
RUN python3 -m venv /app/venv
RUN /app/venv/bin/pip install selenium


# Delete this line, or replace with your own python entrypoint
CMD ["/app/venv/bin/python", "/app/src/hello.py"]