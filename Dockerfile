FROM ubuntu:xenial

RUN apt-get update --fix-missing

RUN apt-get -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" -y install postfix

RUN useradd carlosap256

ADD bin /home/carlosap256/bin
ADD dependencies /home/carlosap256/dependencies
ADD misc_scripts /home/carlosap256/misc_scripts
ADD tests /home/carlosap256/bin/tests

# Install dependencies/libraries/packages
RUN /home/carlosap256/dependencies/apt.sh
