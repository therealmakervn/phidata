FROM python:3.9-slim

WORKDIR /app

# Install system dependencies
RUN apt-get update && apt-get install -y curl && rm -rf /var/lib/apt/lists/*

# Copy requirements first to leverage Docker cache
COPY requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt

# Copy all application files
COPY . .

# Expose port
EXPOSE 7777

# Healthcheck
HEALTHCHECK --interval=30s --timeout=30s --start-period=5s --retries=3 \
    CMD curl -f http://localhost:7777/health || exit 1

# Sửa đường dẫn để trỏ đến file app.py trong cookbook
CMD ["uvicorn", "cookbook.assistants.tools.app:app", "--host", "0.0.0.0", "--port", "7777", "--log-level", "debug"]