FROM python:3.9-slim

WORKDIR /app

# Tạo và kích hoạt môi trường ảo
RUN python -m venv /opt/venv
ENV PATH="/opt/venv/bin:$PATH"

# Cài đặt dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt \
    && pip install "fastapi[all]" uvicorn

# Copy code vào container
COPY . .

# Expose port
EXPOSE 7777

# Sửa command để chạy với uvicorn
CMD ["uvicorn", "cookbook.playground.demo:app", "--host", "0.0.0.0", "--port", "7777"]