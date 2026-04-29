# =============================================================================
# Stage 1 : build CSS (Tailwind)
# =============================================================================
FROM node:20-alpine AS css-builder

WORKDIR /app

COPY package.json package-lock.json ./
RUN npm ci

COPY tailwind.config.js ./
COPY static ./static
COPY home/templates ./home/templates
COPY jobs/templates ./jobs/templates

RUN npm run build:css

# =============================================================================
# Stage 2 : Django + Gunicorn
# =============================================================================
FROM python:3.11-slim AS app

ENV PYTHONUNBUFFERED=1 \
    PYTHONDONTWRITEBYTECODE=1

WORKDIR /app

RUN pip install --upgrade pip

COPY requirements.txt .
RUN pip install -r requirements.txt

COPY . .

# Récupère le CSS compilé depuis le stage 1
COPY --from=css-builder /app/static/dist ./static/dist

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

EXPOSE 8000

CMD ["/entrypoint.sh"]
