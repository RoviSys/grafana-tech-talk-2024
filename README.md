# Grafana Demo

This is a simple demo to show how to use Grafana with a SQL Server database to visualize data.

## Prerequisites

- Docker
- Docker Compose

## Database Setup

1. Drop the provided files in whatever directory is mapped to the MSSQL container on the host machine
   - By default this is the `/mnt/c/grafanademo` directory from the second volume definition on that container in the `docker-compose.yml` file
2. Connect to your MSSQL container with `docker exec -it <container_name> /bin/bash` to enter an interactive shell
3. Run `/opt/mssql-tools/bin/sqlcmd -S localhost -U SA -P Secret1234 -i /demo/01_create_database_and_tables.sql` to create the database and tables
4. Run `/opt/mssql-tools/bin/sqlcmd -S localhost -U SA -P Secret1234 -i /demo/02_add_data_sproc.sql` to insert the sproc that will generate our random data
5. Run `/opt/mssql-tools/bin/sqlcmd -S localhost -U SA -P Secret1234 -i /demo/03_add_device_data.sql` to insert some data for our devices

## Grafana Setup

1. Clone this repository
2. Run `docker-compose up -d` to start the containers
   - If you are going to change where the database files are stored you can add a `.env` file to the root of the repository with the following contents:
     ```bash
     MSSQL_SCRIPT_DIR=/path/to/your/mssql/files
     ```
     - This will override the default value of `/mnt/c/grafanademo` in the `docker-compose.yml` file
   - Run `docker compose --env-file .env up -d` again after adding the `.env` file
3. Navigate to `http://localhost:3000` in your browser
4. Log in with the default credentials (admin/admin)
5. Add a new data source
   - Type: Microsoft SQL Server
   - Host: mssql
   - Database: demo
   - User: sa
   - Password: Secret1234
6. Import the dashboard from the `dashboard.json` file in this repository
   - Click the "+" in the left sidebar
   - Click "Import"
   - Click "Upload .json file"
   - Select the `dashboard.json` file
   - Click "Import"

## Notes

- If you want to add more devices you can update the insert statements in the initial script
- If you want to adjust the date range of data that gets generated you can update the @StartDate and @EndDate variables that get passed to the sproc in the third script
