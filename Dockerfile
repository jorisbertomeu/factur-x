FROM ubuntu:latest
RUN export DEBIAN_FRONTEND=noninteractive
RUN apt-get update \
  && apt-get install -y tzdata \
  && ln -fs /usr/share/zoneinfo/Europe/Paris /etc/localtime \
  && dpkg-reconfigure --frontend noninteractive tzdata \
  && apt-get install -y python3-pip python3-dev libxml2-dev libxslt1-dev zlib1g-dev \
  && cd /usr/local/bin \
  && ln -s /usr/bin/python3 python \
  && pip3 install --upgrade pip
RUN mkdir -p /var/www/app/bin
RUN mkdir -p /var/www/app/facturx
COPY ./requirement.txt /var/www/app/requirement.txt
COPY ./setup.py /var/www/app/setup.py
COPY ./requirement.txt /var/www/app/MANIFEST.in
COPY ./README.rst /var/www/app/README.rst
COPY ./bin/* /var/www/app/bin/
COPY ./facturx/* /var/www/app/facturx/
RUN pip3 install -r /var/www/app/requirement.txt
WORKDIR /var/www/app/
RUN python3 setup.py install
CMD ["python3", "./bin/facturx-webservice", "--host", "0.0.0.0"]
