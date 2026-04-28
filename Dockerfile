FROM python:3.14-slim

WORKDIR /app

# Same packages jo GitHub Actions me install ho rahe hain
RUN apt-get update && apt-get install -y \
    chromium-browser \
    chromium-chromedriver \
    && rm -rf /var/lib/apt/lists/* \
    && if [ -f /usr/bin/chromium-browser ] && [ ! -f /usr/bin/chromium ]; then \
        ln -s /usr/bin/chromium-browser /usr/bin/chromium; \
    fi

# Python dependencies
COPY requirements.txt .
RUN pip install --upgrade pip && pip install -r requirements.txt

# Bot files copy karo
COPY bot.py database.py README.md .

EXPOSE 4000

# Same while loop jo GitHub Actions me hai
CMD while true; do python bot.py; echo "Bot stopped, restarting..."; sleep 5; done
