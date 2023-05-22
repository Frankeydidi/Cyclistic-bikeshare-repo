--Create a new table to combine the data

CREATE TABLE bikeshare_data (
    ride_id VARCHAR(50),
    rideable_type VARCHAR(50),
    started_at DATETIME,
    ended_at DATETIME,
    start_station_name VARCHAR(MAX),
    start_station_id VARCHAR(50),
    end_station_name VARCHAR(MAX),
    end_station_id VARCHAR(50),
    start_lat FLOAT,
    start_lng FLOAT,
    end_lat FLOAT,
    end_lng FLOAT,
    member_casual VARCHAR(50)
)

--Insert the data from the 12 seperate tables into the new one

INSERT INTO bikeshare_data
SELECT * FROM divvy01
UNION ALL
SELECT * FROM divvy02
UNION ALL
SELECT * FROM divvy03
UNION ALL
SELECT * FROM divvy04
UNION ALL
SELECT * FROM divvy05
UNION ALL
SELECT * FROM divvy06
UNION ALL
SELECT * FROM divvy07
UNION ALL
SELECT * FROM divvy08
UNION ALL
SELECT * FROM divvy09
UNION ALL
SELECT * FROM divvy10
UNION ALL
SELECT * FROM divvy11
UNION ALL
SELECT * FROM divvy12
