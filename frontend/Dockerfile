FROM almalinux:8

RUN dnf install -y python3
RUN dnf install -y python3-pip

RUN mkdir -p /opt/frontend

COPY requirements.txt /opt/frontend/
RUN pip3 install -r /opt/frontend/requirements.txt

COPY src/ /opt/frontend/src

CMD ["python3", "/opt/frontend/src/main.py"]

EXPOSE 5000
