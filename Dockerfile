FROM python:3.14-slim

WORKDIR /app

# Sirf Chromium browser install karo (driver nahi chahiye)
RUN apt-get update && apt-get install -y chromium && rm -rf /var/lib/apt/lists/*

# Python packages
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Bot files
COPY bot.py database.py README.md .

EXPOSE 5000

CMD ["python", "bot.py"]
