--Query for some descriptive statistics
SELECT 
    COUNT(*) AS num_trips,
    AVG(ride_duration) AS avg_duration,
    MIN(ride_duration) AS min_duration,
    MAX(ride_duration) AS max_duration,
    (
        SELECT TOP 1 start_day
        FROM (
            SELECT start_day, COUNT(*) AS cnt
            FROM bikeshare_data
            GROUP BY start_day
        ) t
        ORDER BY cnt DESC
    ) AS mode_start_day
FROM bikeshare_data;


--Query for some descriptive statistics and grouping by membership type
SELECT 
	membership_type,
    COUNT(*) AS num_trips,
    AVG(ride_duration) AS avg_duration,
    MIN(ride_duration) AS min_duration,
    MAX(ride_duration) AS max_duration,
    (
        SELECT TOP 1 start_day
        FROM (
            SELECT start_day, COUNT(*) AS cnt
            FROM bikeshare_data
            GROUP BY start_day
        ) t
        ORDER BY cnt DESC
    ) AS mode_start_day
FROM bikeshare_data
GROUP BY membership_type;