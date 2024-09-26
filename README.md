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

# Set up QGIS-server in debian based system
1. Clone github source
   ```bash
   git clone https://github.com/izzuddinfa/qgis-server.git
2. Go to qgis-server directory
   ```bash
   cd qgis-server
4. Create pg_service inside configs
   ```bash
   sudo nano ./configs/.pg_service.conf
5. Fill it with your database credential. The name of the service is same as the name of the service when you connect to Postgresql database in QGIS Desktop
   ```ini
   [gis_server]
   host=
   port=
   dbname=
   user=
   password=
  
6. Open qgis-server.conf
   ```bash
   nano ./apache/qgis-server.conf
8. Change "gis_server" to match a database service used in .pg_service.conf
   ```apache
   SetEnv PGSERVICE "gis_server"
9. Build your docker-compose
   ```bash
   docker-compose build --no-cache

