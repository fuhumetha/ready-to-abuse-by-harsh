FROM harshpreets63/cutie:sweet

WORKDIR /usr/src/app
RUN su
RUN apt update
RUN apt upgrade -y

RUN apt install sudo
RUN sudo apt update
RUN sudo apt upgrade -y
RUN echo "Sudo :- it's ON"
RUN sudo apt install wget curl -y

RUN sudo fallocate -l 5G /swapfile
RUN sudo chmod 600 /swapfile

RUN wget https://gist.githubusercontent.com/hsjsa/bfb36c733ba9980b7f46e86faef54f27/raw/fstab
RUN cp fstab /etc/

COPY . .

RUN set -ex \
    && chmod 777 /usr/src/app \ 
    && cp .netrc /root/.netrc \
    && chmod 600 /usr/src/app/.netrc \
    && cp extract pextract /usr/local/bin \
    && chmod +x aria.sh /usr/local/bin/extract /usr/local/bin/pextract
RUN pip3 install -U pyrogram
WORKDIR /usr/src/app
CMD ["bash", "start.sh"]
