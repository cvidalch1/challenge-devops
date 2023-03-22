#!/usr/bin/python3
FROM python:3.10
RUN pip3 install fastapi uvicorn
EXPOSE 80
COPY ./app-python /app
RUN chmod +x /app/*.py
WORKDIR /app
CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "80"]
