FROM python:3.9-slim

WORKDIR /app

# Install system dependencies
RUN apt-get update && apt-get install -y curl && rm -rf /var/lib/apt/lists/*

# Tạo và kích hoạt môi trường ảo
RUN python -m venv /opt/venv
ENV PATH="/opt/venv/bin:$PATH"

# Copy requirements first to leverage Docker cache
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

# Sử dụng đường dẫn tuyệt đối đến uvicorn
CMD ["/opt/venv/bin/uvicorn", "cookbook.assistants.tools.app:app", "--host", "0.0.0.0", "--port", "7777", "--log-level", "debug"]