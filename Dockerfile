# Slim Python base — small image, official, security-patched.
FROM python:3.12-slim

WORKDIR /app

# Install dependencies first so the layer is cached when only app code changes.
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# App code.
COPY . .

# DB lives in /data so it persists when mounted as a volume.
RUN mkdir -p /data
ENV DB_PATH=/data/form_d.sqlite
VOLUME /data

# Web UI port.
EXPOSE 8000

# Default: serve the web UI. Override with `docker run ... python main.py <cmd>`
# for backfill, run, list, etc.
CMD ["python", "main.py", "serve", "--host", "0.0.0.0", "--port", "8000"]
