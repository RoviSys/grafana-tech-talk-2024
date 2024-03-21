USE GrafanaDemo;
GO

CREATE PROCEDURE sp_InsertRandomDataForDevice
(
  @DeviceId INT,
  @StartDate DATETIME,
  @EndDate DATETIME
)
AS
BEGIN
  SET NOCOUNT ON;

  WITH DaysTable (Day) AS (
    SELECT @StartDate AS Day
    UNION ALL
    SELECT DATEADD(day, 1, Day) FROM DaysTable
    WHERE Day < @EndDate
  ),
  HoursTable (Hour) AS (
    SELECT 0 AS Hour
    UNION ALL
    SELECT Hour + 1 FROM HoursTable
    WHERE Hour < 23
  )
  INSERT INTO dbo.TimeseriesData (Date, Value, DeviceId)
  SELECT 
    DATEADD(hour, Hour, Day) AS Date,
    CAST(CHECKSUM(NEWID()) % 101 AS FLOAT) AS Value,
    @DeviceId AS DeviceId
  FROM DaysTable
  CROSS JOIN HoursTable;
END;
GO
