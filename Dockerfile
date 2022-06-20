FROM ubuntu:20.04

RUN apt update
RUN apt install -y python3 make python3-pip
RUN pip install virtualenvwrapper

WORKDIR /flaskbb/
RUN virtualenv venv
RUN apt install -y git

# clone the repo
COPY . .

ENV PATH="/flaskbb/venv/bin/:${PATH}"

RUN pip install --upgrade pip
RUN pip install -r ./requirements.txt
RUN pip install -r ./requirements-dev.txt
RUN make dependencies

CMD "bash flaskbb --config flaskbb.cfg install -u admin -e admin@localhost.de -p admin && flaskbb --config flaskbb.cfg run -h 0.0.0.0 -p 5001" 

