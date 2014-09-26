# Dockerfile for Db2 on Ununtu

FROM ubuntu

# --- Add Canonical Partner repo ---
RUN echo 'deb http://mirrors.sohu.com/ubuntu/ trusty main restricted universe multiverse' >> /etc/apt/sources.list
RUN echo 'deb http://mirrors.sohu.com/ubuntu/ trusty-security main restricted universe multiverse' >> /etc/apt/sources.list
RUN echo 'deb http://mirrors.sohu.com/ubuntu/ trusty-updates main restricted universe multiverse' >> /etc/apt/sources.list
RUN echo 'deb http://mirrors.sohu.com/ubuntu/ trusty-proposed main restricted universe multiverse' >> /etc/apt/sources.list
RUN echo 'deb http://mirrors.sohu.com/ubuntu/ trusty-backports main restricted universe multiverse' >> /etc/apt/sources.list
RUN echo 'deb-src http://mirrors.sohu.com/ubuntu/ trusty main restricted universe multiverse' >> /etc/apt/sources.list
RUN echo 'deb-src http://mirrors.sohu.com/ubuntu/ trusty-security main restricted universe multiverse' >> /etc/apt/sources.list
RUN echo 'deb-src http://mirrors.sohu.com/ubuntu/ trusty-updates main restricted universe multiverse' >> /etc/apt/sources.list
RUN echo 'deb-src http://mirrors.sohu.com/ubuntu/ trusty-proposed main restricted universe multiverse' >> /etc/apt/sources.list
RUN echo 'deb-src http://mirrors.sohu.com/ubuntu/ trusty-backports main restricted universe multiverse' >> /etc/apt/sources.list

# --- Updating packages list ---
RUN apt-get -qq update --fix-missing

# --- Install packages ---
RUN apt-get install -y -qq build-essential vim tree mc tmux git-core cvs db2exc

# --- Upgrade packages ---
RUN apt-get upgrade -y -qq
RUN apt-get clean -y -qq

# --- change database user db2inst1 password to db2inst1 ---
RUN echo -e "db2inst1\ndb2inst1" | passwd db2inst1 -q

# --- Install sample database ---
RUN su db2inst1 -c db2start
RUN su db2inst1 -c db2sampl
RUN su db2inst1 -c db2 -p 'attach to db2inst1'
RUN su db2inst1 -c db2 -p 'get dbm cfg show detail'

# --- cleanup ---
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*


EXPOSE 50000
CMD db2start;bash - db2inst1