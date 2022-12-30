FROM python:3.8
LABEL MAINTAINER="Aditya Gupta <guptaaditya008@gmail.com>"

WORKDIR /usr/src/app
COPY requirements.txt ./

RUN pip install --upgrade pip \
    && pip install --no-cache-dir -r requirements.txt

COPY . .

CMD ["python", "./main.py"]