FROM ubuntu:trusty
MAINTAINER Ramesh Sankar <ramesh.sankar@gmail.com>

# Prevent dkpg errors
ENV TERM=xterm-256color

# Set mirrors to NZ
RUN sed -i "s/http:\/\/archive./http:\/\/nz.archive./g" /etc/apt/sources.list

# Install Python runtime
RUN apt-get update -qy && \
	apt-get install -qy software-properties-common && \
	apt-add-repository -y ppa:ansible/ansible && \
	apt-get update -qy && \
	apt-get install -qy ansible

# Copy baked in playbooks
COPY ansible /ansible

# Add volume for Ansilbe playbooks
VOLUME /ansible
WORKDIR /ansible

# Entrypoint
ENTRYPOINT ["ansible-playbook"]
CMD ["site.yml"]
