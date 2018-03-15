FROM python:3

RUN pip install requests
RUN pip install watchdog
RUN mkdir log
COPY log_checker.py .
RUN python log_checker.py
