FROM python:3.10.7-bullseye
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED 1

RUN apt-get update && apt-get install -y \
    # Required by python packages build
    build-essential \
    # Required by postgres
    libpq-dev

COPY requirements.txt /requirements.txt
COPY requirements-dev.txt /requirements-dev.txt

RUN pip install -r requirements.txt
RUN pip install -r requirements-dev.txt

# Install Node LTS
RUN curl -fsSL https://deb.nodesource.com/setup_lts.x | bash -
RUN apt-get install -y nodejs

WORKDIR /app

