FROM nvidia/cuda:10.2-base
# FROM python:3.8
RUN apt-get update && apt-get install --no-install-recommends --no-install-suggests -y curl
RUN apt-get install unzip
RUN apt-get -y install python3.8
RUN apt-get -y install python3-pip
RUN apt-get -y install git


COPY ./requirements.txt ./requirements.txt
COPY ./parlai ./parlai
COPY ./parlai.egg-info ./parlai.egg-info
COPY ./projects ./projects
COPY ./tmp/1Bdistill_model ./tmp/1Bdistill_model

RUN python3.8 -m pip install --upgrade pip
RUN python3.8 -m pip install -r requirements.txt

EXPOSE 8888

CMD ["python3.8", "parlai/chat_service/services/browser_chat/run.py", "--config-path", "parlai/chat_service/tasks/chatbot/therapy_config.yml", "--port", "8888"]