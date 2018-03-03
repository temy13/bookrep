# Set nginx base image
FROM nginx

# File Author / Maintainer
MAINTAINER temy13

# Copy custom configuration file from the current directory
COPY nginx.conf /etc/nginx/nginx.conf
#COPY bookrep.crt /etc/nginx/bookrep.crt
#COPY bookrep.key /etc/nginx/bookrep.key
#COPY /etc/letsencrypt /etc/letsencrypt

RUN mkdir /root/logs
RUN chmod 755 -R /root
#RUN chmod 400 /etc/nginx/bookrep.key
