# Database Setup

1. Drop the provided files in whatever directory is mapped to the MSSQL container on the host machine
   - By default this is the `/opt/demo` directory from the second volume definition on that container in the `docker-compose.yml` file
2. Connect to your MSSQL container with `docker exec -it <container_name> /bin/bash` to enter an interactive shell
3. Run `/opt/mssql-tools/bin/sqlcmd -S localhost -U SA -P Secret1234 -i /demo/01_create_database_and_tables.sql` to create the database and tables
4. Run `/opt/mssql-tools/bin/sqlcmd -S localhost -U SA -P Secret1234 -i /demo/02_add_data_sproc.sql` to insert the sproc that will generate our random data
5. Run `/opt/mssql-tools/bin/sqlcmd -S localhost -U SA -P Secret1234 -i /demo/03_add_device_data.sql` to insert some data for our devices

## Notes

- If you want to add more devices you can update the insert statements in the initial script
- If you want to adjust the date range of data that gets generated you can update the @StartDate and @EndDate variables that get passed to the sproc in the third script
