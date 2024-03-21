USE master;
GO

DROP DATABASE IF EXISTS GrafanaDemo;
GO

CREATE DATABASE GrafanaDemo;
GO

USE GrafanaDemo;
GO

-- Create the Devices table (capitalized)
CREATE TABLE Devices (
  id INT PRIMARY KEY IDENTITY(1,1),  -- Auto-incrementing integer ID
  name VARCHAR(255) NOT NULL         -- Device name with max length 255
);

-- Create the TimeseriesData table with foreign key (updated)
CREATE TABLE TimeseriesData (
  id INT PRIMARY KEY IDENTITY(1,1),  -- Auto-incrementing integer ID
  Date DATETIME,        -- Date and time of the data point
  Value FLOAT,                      -- Value of the data point
  DeviceId INT FOREIGN KEY REFERENCES Devices(id)  -- Device ID foreign key
);

-- Add 5 devices to the Devices table (unchanged)
INSERT INTO Devices (name)
VALUES ('Device 1'),
       ('Device 2'),
       ('Device 3'),
       ('Device 4'),
       ('Device 5');

GO