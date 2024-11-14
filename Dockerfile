FROM python:3.9-slim

WORKDIR /app

# Tạo và kích hoạt môi trường ảo
RUN python -m venv /opt/venv
ENV PATH="/opt/venv/bin:$PATH"

# Cài đặt dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy code vào container
COPY . .

# Xác thực với phidata
RUN phi auth

# Expose port
EXPOSE 7777

# Khởi chạy ứng dụng
CMD ["python", "cookbook/playground/demo.py"]