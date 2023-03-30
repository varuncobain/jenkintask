FROM ubuntu
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update
RUN apt-get -y install apache2
RUN apt-get install apache2-utils
RUN apt-get update
RUN apt-get install software-properties-common -y
RUN apt-get update
RUN add-apt-repository ppa:ondrej/php -y
RUN apt-get install php7.4 -y
RUN apt-get install php7.4 php7.4-cli php7.4-fpm php7.4-json php7.4-common php7.4-mysql php7.4-zip php7.4-gd php7.4-mbstring php7.4-curl php7.4-xml php7.4-bcmath -y
RUN apt-get -y install php7.4-mysql
RUN apt-get -y install libapache2-mod-php7.4
RUN apt-get update
COPY . /var/www/html/
RUN sed -i '/<Directory \/var\/www\/>/,/<\/Directory>/ s/Options Indexes FollowSymLinks/Options FollowSymLinks/' /etc/apache2/apache2.conf
RUN echo "<IfModule dir_module>\n    DirectoryIndex login.php\n</IfModule>" >> /etc/apache2/apache2.conf
RUN rm -frv /var/www/html/index.html
EXPOSE 80
CMD /usr/sbin/apachectl -DFOREGROUND
