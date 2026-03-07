FROM nvidia/cuda:13.0.2-cudnn-runtime-ubuntu24.04

ENV DEBIAN_FRONTEND=noninteractive \
    PIP_NO_CACHE_DIR=1 \
    PYTHONUNBUFFERED=1 \
    MODEL_CACHE_SIZE=5 \
    TORCHINDUCTOR_CACHE_DIR=/tmp/torch_inductor

RUN apt-get update && apt-get install -y --no-install-recommends \
    ca-certificates \
    curl \
    ffmpeg \
    libsndfile1 \
    python3 \
    python3-pip \
    python3-venv \
    sox \
    && rm -rf /var/lib/apt/lists/*

RUN python3 -m venv /opt/venv
ENV PATH="/opt/venv/bin:$PATH"

WORKDIR /app
COPY . /app

RUN mkdir -p /app/assets/presets /app/assets/samples/parity \
    && curl -L "https://raw.githubusercontent.com/andimarafioti/faster-qwen3-tts/main/ref_audio.wav" -o /app/assets/presets/ref_audio.wav \
    && curl -L "https://raw.githubusercontent.com/andimarafioti/faster-qwen3-tts/main/ref_audio_2.wav" -o /app/assets/presets/ref_audio_2.wav \
    && curl -L "https://raw.githubusercontent.com/andimarafioti/faster-qwen3-tts/main/ref_audio_3.wav" -o /app/assets/presets/ref_audio_3.wav \
    && curl -L "https://raw.githubusercontent.com/andimarafioti/faster-qwen3-tts/main/samples/parity/icl_transcripts.txt" -o /app/assets/samples/parity/icl_transcripts.txt

RUN python3 -m pip install --upgrade pip \
    && python3 -m pip install --index-url https://download.pytorch.org/whl/cu130 torch==2.10 torchaudio \
    && python3 -m pip install -r requirements.txt

EXPOSE 7860
CMD ["python3", "server.py", "--host", "0.0.0.0"]
