# Faster Qwen3-TTS Demo

[![GitHub Repo](https://img.shields.io/badge/GitHub-jimlee2048%2Ffaster--qwen3--tts--demo-blue?logo=github)](https://github.com/jimlee2048/faster-qwen3-tts-demo)
[![Docker Hub](https://img.shields.io/badge/Docker%20Hub-jimlee2048%2Ffaster--qwen3--tts--demo-blue?logo=docker)](https://hub.docker.com/r/jimlee2048/faster-qwen3-tts-demo)

Forked from the original Hugging Face Space: [HuggingFaceM4/faster-qwen3-tts-demo](https://huggingface.co/spaces/HuggingFaceM4/faster-qwen3-tts-demo), with the following modifications:

- Uses `torch==2.10` with CUDA 13 (`cu130`) for newer GPU support, including Blackwell-class cards such as RTX 5090
- Removes Hugging Face Space-specific packaging and runtime leftovers
- Downloads preset reference audio and transcripts during Docker build instead of storing them in the repo
- Adds GitHub Actions workflow for automatic Docker Hub publishing

## Prerequisites

- NVIDIA GPU with a recent driver
- NVIDIA Container Toolkit for `--gpus all`

## Quick Start

### Docker Run

```bash
docker run --gpus all \
  -p 7860:7860 \
  jimlee2048/faster-qwen3-tts-demo:latest
```

Open `http://localhost:7860` in your browser.

### Docker Compose

Prepare your compose configuration by referencing [compose.yaml](https://raw.githubusercontent.com/jimlee2048/faster-qwen3-tts-demo/refs/heads/main/compose.yaml), then run:

```bash
docker compose up -d
```

Open `http://localhost:7860` in your browser.

## Environment Variables

| Variable | Required | Default | Description |
| --- | --- | --- | --- |
| `MODEL_CACHE_SIZE` | No | `5` | Maximum number of TTS models kept in the in-process LRU cache when running the container image. |
| `ACTIVE_MODELS` | No | All built-in models | Comma-separated allowlist of [HuggingFace model IDs](https://huggingface.co/collections/Qwen/qwen3-tts) exposed by the UI and `/load` endpoint. |
| `PORT` | No | `7860` | Server port used by `server.py` inside the container. |
