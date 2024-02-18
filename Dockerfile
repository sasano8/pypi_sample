FROM python:3.8.18-slim-bullseye

RUN apt-get update && \
    apt-get install -y git && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /app
RUN mkdir -p dist
RUN mkdir -p packages

COPY requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt
COPY scripts/ ./scripts/
