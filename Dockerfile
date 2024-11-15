FROM python:3.9-slim

WORKDIR /app

# Install system dependencies
RUN apt-get update && apt-get install -y curl && rm -rf /var/lib/apt/lists/*

# Tạo và kích hoạt môi trường ảo
RUN python -m venv /opt/venv
ENV PATH="/opt/venv/bin:$PATH"

# Set PYTHONPATH
ENV PYTHONPATH=/app

# Copy requirements first
COPY requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt \
    && pip install "uvicorn[standard]"

# Copy all application files
COPY . .

# Tạo các file __init__.py cần thiết
RUN mkdir -p cookbook/assistants/tools \
    && touch cookbook/__init__.py \
    && touch cookbook/assistants/__init__.py \
    && touch cookbook/assistants/tools/__init__.py

# Expose port
EXPOSE 7777

# Healthcheck
HEALTHCHECK --interval=30s --timeout=30s --start-period=5s --retries=3 \
    CMD curl -f http://localhost:7777/health || exit 1

# Thêm script khởi động
COPY start.sh /start.sh
RUN chmod +x /start.sh

CMD ["/start.sh"]