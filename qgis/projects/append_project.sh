#!/bin/bash

# Meminta input nama project dan service dari user
read -p "Masukkan nama project: " nama_project
read -p "Masukkan nama service db: " nama_service

# Membuat direktori dengan nama project
mkdir -p /usr/lib/cgi-bin/projects/$nama_project

# Membuat symbolic link ke qgis_mapserv.fcgi
ln -s ../../qgis_mapserv.fcgi /usr/lib/cgi-bin/projects/$nama_project

# Menambahkan konfigurasi ke file /home/qgis/qgis-location.conf
bash -c "echo '<Location /gis/projects/$nama_project/qgis_mapserv.fcgi>' >> /home/qgis/configs/qgis-location.conf"
bash -c "echo '  SetEnv QGIS_PROJECT_FILE \"postgresql:?service=$nama_service&dbname&schema=qgis&project=$nama_project\"' >> /home/qgis/configs/qgis-location.conf"
bash -c "echo '</Location>' >> /home/qgis/configs/qgis-location.conf"

# Restart apache2
#systemctl restart apache2

echo "Project berhasil ditambahkan"
