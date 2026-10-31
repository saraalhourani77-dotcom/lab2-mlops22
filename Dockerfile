# Stage 1: Build & Dependencies
FROM python:3.11-slim AS builder

WORKDIR /app

# Install dependencies in a virtual environment to keep the image clean
RUN python -m venv /opt/venv
ENV PATH="/opt/venv/bin:$PATH"

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Stage 2: Final Runtime Image (Multi-stage + Non-root + HEALTHCHECK)
FROM python:3.11-slim AS runner

WORKDIR /app

# Copy the installed virtualenv from the builder stage
COPY --from=builder /opt/venv /opt/venv
ENV PATH="/opt/venv/bin:$PATH"

# Create a non-root user and set permissions
RUN useradd -m appuser && chown -R appuser:appuser /app
USER appuser

# Copy application source code
COPY --chown=appuser:appuser src/ /app/src/

# Expose port
EXPOSE 8000

# Add HEALTHCHECK endpoint probe
HEALTHCHECK --interval=30s --timeout=5s --start-period=5s --retries=3 \
  CMD python -c "import urllib.request; urllib.request.urlopen('http://localhost:8000/health')" || exit 1

# Run the FastAPI server
CMD ["uvicorn", "src.app.main:app", "--host", "0.0.0.0", "--port", "8000"]