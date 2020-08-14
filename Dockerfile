FROM python:3.7-stretch
RUN export DEBIAN_FRONTEND=noninteractive
RUN apt-get update \
  && apt-get install -y tzdata \
  && ln -fs /usr/share/zoneinfo/Europe/Paris /etc/localtime \
  && dpkg-reconfigure --frontend noninteractive tzdata \
  && apt-get install -y python3-dev libxml2-dev libxslt1-dev zlib1g-dev \
  && pip3 install --upgrade pip \
  && pip3 install factur-x
RUN mkdir -p /var/www/app/
#RUN mkdir -p /var/www/app/bin
#RUN mkdir -p /var/www/app/facturx
WORKDIR /var/www/app/
COPY ./requirement.txt .
COPY ./setup.py .
COPY ./requirement.txt .
COPY ./README.rst .
COPY ./LICENSE .
COPY ./bin ./bin
COPY ./facturx ./facturx
RUN ls -rRtla
RUN pip install -r requirement.txt
RUN python setup.py install
CMD ["python3", "./bin/facturx-webservice", "--host", "0.0.0.0"]
