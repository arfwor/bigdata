FROM ubuntu

RUN sed 's/archive.ubuntu.com/cn.archive.ubuntu.com/g' /etc/apt/sources.list > /etc/apt/sources.list.temp
RUN mv /etc/apt/sources.list.temp /etc/apt/sources.list
RUN apt update
RUN apt -y upgrade
