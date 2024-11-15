FROM python:3.9-slim

WORKDIR /app

# Install system dependencies
RUN apt-get update && apt-get install -y curl && rm -rf /var/lib/apt/lists/*

# Set PYTHONPATH
ENV PYTHONPATH=/app

# Copy requirements first
COPY requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt \
    && pip install "uvicorn[standard]"

# Copy all application files
COPY . .

# Expose port
EXPOSE 7777

# Healthcheck
HEALTHCHECK --interval=30s --timeout=30s --start-period=5s --retries=3 \
    CMD curl -f http://localhost:7777/health || exit 1

# Make start.sh executable
RUN chmod +x start.sh

# Run start script
CMD ["./start.sh"]