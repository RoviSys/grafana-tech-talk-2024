USE GrafanaDemo;
GO

DECLARE @StartDate DATETIME = '2024-02-01'; -- Adjust as needed
DECLARE @EndDate DATETIME = '2024-08-30'; -- Adjust as needed

-- Loop through all devices and call stored procedure
DECLARE @DeviceId INT;

DECLARE deviceCursor CURSOR FOR
  SELECT id FROM Devices;

OPEN deviceCursor;

FETCH NEXT FROM deviceCursor INTO @DeviceId;

WHILE @@FETCH_STATUS = 0
BEGIN
  -- Call stored procedure for each device ID
  EXEC sp_InsertRandomDataForDevice @DeviceId = @DeviceId, @StartDate = @StartDate, @EndDate = @EndDate;

  FETCH NEXT FROM deviceCursor INTO @DeviceId;
END;

CLOSE deviceCursor;
DEALLOCATE deviceCursor;

GO

-- Optional: Verify data population (unchanged)
SELECT * FROM TimeseriesData;