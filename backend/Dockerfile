FROM almalinux:10

RUN dnf install -y python3
RUN dnf install -y python3-pip

RUN mkdir -p /opt/backend

COPY requirements.txt /opt/backend/
RUN pip3 install -r /opt/backend/requirements.txt

COPY src/ /opt/backend/src

CMD ["python3", "/opt/backend/src/main.py"]

EXPOSE 5000
