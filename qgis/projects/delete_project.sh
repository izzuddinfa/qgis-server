#!/bin/bash

# Meminta input nama project dari user
read -p "Masukkan nama project yang ingin dihapus: " nama_project

# Menghapus symbolic link dan direktori di /usr/lib/cgi-bin
rm -rf /usr/lib/cgi-bin/projects/$nama_project

# Menghapus blok <Location> dari /home/qgis/qgis-location.conf
sed -i "/<Location \/gis\/projects\/$nama_project\/qgis_mapserv.fcgi>/,/<\/Location>/d" /home/qgis/configs/qgis-location.conf

# Restart apache2
#systemctl restart apache2

echo "Project $nama_project telah dihapus."

