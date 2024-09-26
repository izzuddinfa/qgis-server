FROM ubuntu:22.04

# Install dependencies, QGIS Server, and tzdata
RUN apt-get update && \
    apt-get install -y wget gnupg2 tzdata && \
    wget -O /etc/apt/keyrings/qgis-archive-keyring.gpg https://download.qgis.org/downloads/qgis-archive-keyring.gpg && \
    echo "deb [signed-by=/etc/apt/keyrings/qgis-archive-keyring.gpg] https://qgis.org/ubuntu jammy main" | tee /etc/apt/sources.list.d/qgis.list && \
    apt-get update && \
    apt-get install -y nano qgis-server apache2 libapache2-mod-fcgid && \
    apt-get clean

# Configure the timezone to Indonesia/Jakarta
ENV TZ=Asia/Jakarta
RUN ln -fs /usr/share/zoneinfo/$TZ /etc/localtime && \
    dpkg-reconfigure -f noninteractive tzdata
ENV PGSERVICEFILE=/home/qgis/configs/.pg_service.conf
ENV PGSERVICE = gis_server

# Enable modul yang diperlukan untuk QGIS Server di Apache2
RUN a2enmod fcgid && a2enmod rewrite

# Salin konfigurasi Apache2 (misal: virtual host, script qgis-server.fcgi)
COPY ./apache/qgis-server.conf /etc/apache2/sites-available/qgis-server.conf

RUN echo "ServerName localhost" >> /etc/apache2/apache2.conf

# Enable konfigurasi Apache2
RUN a2ensite qgis-server.conf && a2dissite 000-default.conf

# Port untuk Apache2
EXPOSE 80

# Perintah untuk menjalankan Apache2 dan QGIS Server
CMD ["apachectl", "-D", "FOREGROUND"]
