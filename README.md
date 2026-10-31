# Lab 2: Bring Your Own Model - Container + CI

[![CI Pipeline](https://github.com/saraalhourani77-dotcom/lab2-mlops/actions/workflows/ci.yml/badge.svg)](https://github.com/saraalhourani77-dotcom/lab2-mlops/actions/workflows/ci.yml)

## Overview
This project packages our machine learning model into a robust, secure FastAPI service running inside a container, fully integrated with automated CI/CD checks, security scanning (Trivy), and container registry publishing.

## Prerequisites
- Docker & Docker Compose
- Python 3.11+

## Running the Service with One Command
To build and run the Docker container locally:

```bash
docker build -t lab2-mlops . && docker run -p 8000:8000 lab2-mlops