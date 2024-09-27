# Set up database for QGIS-dekstop in Windows system
1. Make .pg_service.conf file in "C:\Users\your_user\\.pg_service.conf"
   ```ini
   [gis_server]
   host=
   port=
   dbname=
   user=
   password=
2. Make a system variable with name is PGSERVICEFILE, and variable value is .pg_service.conf path
3. Create a scheme with name 'qgis' for saving qgis project file

# Set up QGIS-server in debian based system
1. Clone github source
   ```bash
   git clone https://github.com/izzuddinfa/qgis-server.git
2. Go to qgis-server directory
   ```bash
   cd qgis-server
4. Create pg_service inside configs
   ```bash
   nano ./qgis/configs/.pg_service.conf
5. Fill it with your database credential. The name of the service is same as the name of the service when you connect to Postgresql database in QGIS Desktop
   ```ini
   [gis_server]
   host=
   port=
   dbname=
   user=
   password=

6. Edit qgis-server.conf
   ```bash
   nano ./apache/qgis-server.conf
7. Change "gis_server" to match a database service used in .pg_service.conf
   ```ini
   SetEnv PGSERVICE "gis_server"
8. Run this
   ```bash
   chmod +x ./qgis/projects/append_project.sh &&
   chmod +x ./qgis/projects/delete_project.sh
9. Build your docker-compose
   ```bash
   docker-compose build
10. Run your docker-compose
    ```bash
    docker-compose up -d

# Append and delete a project
1. For appending a project run this, then insert the project name and the service name
   ```bash
   docker exec -it qgis-server_qgis-server_1 bash "/usr/lib/cgi-bin/projects/append_project.sh"
2. Check for the project
   ```
   http://localhost:8082/gis/projects/terminal_pt/ows?SERVICE=WMS&VERSION=1.3.0&REQUEST=GetCapabilities
4. For deleting a project, then insert the project name
   ```bash
   docker exec -it qgis-server_qgis-server_1 bash "/usr/lib/cgi-bin/projects/delete_project.sh"
