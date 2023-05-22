--Data cleaning
-- Dropping/deleting columns not needed for this analysis

ALTER TABLE
bikeshare_data
DROP COLUMN
ride_id,
start_station_name,
start_station_id,
end_station_name,
end_station_id,
start_lat,
start_lng,
end_lat,
end_lng


--Adding new columns required for this analysis to the table
ALTER TABLE
bikeshare_data
ADD
start_day VARCHAR(50),
start_month VARCHAR(50),
end_day VARCHAR(50),
end_month VARCHAR(50),
start_time TIME,
end_time TIME,
ride_duration INT;


--Update of the newly added columns with their required data
UPDATE bikeshare_data
SET start_day = DATENAME(dw, started_at),
    start_month = DATENAME(mm, started_at),
    end_day = DATENAME(dw, ended_at),
    end_month = DATENAME(mm, ended_at),
	start_time = CONVERT(time, started_at),
    end_time = CONVERT(time, ended_at),
	ride_duration = DATEDIFF(minute,started_at,ended_at);


--Running a query to explore the data in the ride_duration column
SELECT MIN(ride_duration) AS min_trip_duration,
	MAX(ride_duration) AS max_trip_duration
FROM bikeshare_data


--Deleting entries with ride duration less than one minute
DELETE FROM bikeshare_data
WHERE ride_duration < 1;
