# Cyclistic Bikeshare: Converting Casual Riders to Members (A Capstone Project)

This project serves as a comprehensive case study that I undertook utilizing Microsoft SQL Server (SSMS) and Power BI.
I carried out this project to enhance my proficiency as a data analyst while fulfilling the requirements to attain the Google Data Analytics Professional Certification. 

### Introduction
The purpose of this report is to analyze and provide insights into the usage patterns and behaviours of Cyclistic bike riders, with specific focus on the differences between annual members and casual riders.
The analysis utilizes data from Cyclistic's bike sharing program and employs **Microsoft SQL Server (SSMS)** and **Power BI** tools.
The report seeks to address the following research questions:
1. How do annual members and casual riders use Cyclistic bikes differently?
2. Why would casual riders buy Cyclistic annual memberships?
3. How can Cyclistic use digital media to influence casual riders to become members?

### The Data
The analysis relies on a comprehensive dataset obtained from the Cyclistic bike sharing program and encompasses various data points which after data cleaning include membership type, rideable type, start day, start month, and ride duration.
Cvering the period from January 2022 to December 2022, this data comprises 12 individual files - each file for a specific month - and offers a substantial timeframe for examining riders' behaviors and preferences.
The dataset can be downloaded [here](https://divvy-tripdata.s3.amazonaws.com/index.html)

Remember to adhere to the [Data License Agreement](https://ride.divvybikes.com/data-license-agreement) when working with the data in this project or any data associated with it.
#### Observations on the data
- In the data files, there are 13 columns namely: ride_id, rideable_type, started_at, ended_at, start_station_name, end_station_name, start_station_id, end_station_id, start_station, start_lat, start_lng, end_lat, end_lng and member_casual.
- The "started_at" and "ended_at" columns contain date-time data in YYYY-MM-DD HH:MM:SS format.
- "start_station_id" and "end_station_id" have discrepancy. Some of the IDs contain alphabets at the beginning (12 char length) and some contain only numbers (variable length 3-8).
- Certain CSV files have considerable amount of missing information in the "start_station_name", "start_station_id", "end_station_name" and "end_station_id" columns.
- "member_casual" column contains 2 types of membership data: "member" or "casual".

The dataset forms the foundation of this report and is crucial to understanding the usage patterns and behaviours of Cyclistic bike riders.

### Data Preparation, Cleaning and Transformation Process
Prior to analysis, the dataset was carefully curated and cleaned to ensure that the analysis is based on accurate and reliable data.
The downloaded dataset was imported into my local SSMS to enable me use SQL queries to carry out further inspection, cleaning and transformation.
- After importing all the data, I utilized an SQL query to create a new table.
```sql
CREATE TABLE bikesharedata (
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
```
- The dataset from the 12 individual files was then inserted into this new table, ensuring the preservation of the initial data for future reference purposes. The table now consisted of 5,667,717 rows of data in total.
```sql
INSERT INTO bikesharedata
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
```
- In an effort to create a more comprehensive and streamlined table, adjustments were made to exclude irrelevant columns and missing row information.
The "ride_id" column, which was not identified as a primary key during evaluation, was dropped from the table.
The columns "start_lat," "start_lng," "end_lat," and "end_lng" were excluded as they were deemed unnecessary for the analysis.
Due to a significant number of missing row information, the "start_station_name," "start_station_id," "end_station_name," and "end_station_id" columns were removed from the table.

These modifications were implemented to ensure a more concise and relevant representation of the data in line with the research questions that needed to be answered.
```sql
-- Dropping/deleting columns not needed for this analysis

ALTER TABLE
bikesharedata
DROP COLUMN ride_id,
            start_station_name,
            start_station_id,
            end_station_name,
            end_station_id,
            start_lat,
            start_lng,
            end_lat,
            end_lng
```
- Additionally,  to facilitate and address the specific research questions that initiated this analysis, several new columns were incorporated into the table, each assigned with its respective required data type.
These additional columns include: "start_day," "start_month," "end_day," "end_month," "start_time," "end_time," and "ride_duration."
By introducing these new columns, we aim to enhance the depth of our analysis and derive meaningful insights from the data.
```sql
--Adding new columns required for this analysis to the table

ALTER TABLE
bikesharedata
ADD start_day VARCHAR(50),
    start_month VARCHAR(50),
    end_day VARCHAR(50),
    end_month VARCHAR(50),
    start_time TIME,
    end_time TIME,
    ride_duration INT;
```
- The required data for the new columns was derived from the existing information within the remaining columns of the table.
By leveraging the available data, we were able to extract and calculate the necessary information to populate the new columns effectively. This approach allowed us to avoid any potential data discrepancies that may have arisen from external sources and ensured the accuracy and consistency of the new data.
```sql
--Update of the newly added columns with their required data

UPDATE bikesharedata
SET start_day = DATENAME(dw, started_at),
    start_month = DATENAME(mm, started_at),
    end_day = DATENAME(dw, ended_at),
    end_month = DATENAME(mm, ended_at),
    start_time = CONVERT(time, started_at),
    end_time = CONVERT(time, ended_at),
    ride_duration = DATEDIFF(minute,started_at,ended_at);
```
- After obtaining the refined and consolidated table essential for our analysis, I executed a query to examine the data within the "ride_duration" column. Notably, I observed that the minimum ride duration displayed a negative value, while the maximum ride duration exceeded 24 hours (1440 minutes).
This observation suggests the presence of both negative ride durations and durations surpassing 24 hours in the data.
```sql
--Running a query to explore the data in the ride_duration column

SELECT MIN(ride_duration) AS min_trip_duration,
	MAX(ride_duration) AS max_trip_duration
FROM bikesharedata
```

- To maintain accuracy of the data, I executed a query to delete the rows having ride durations with negative values. However, considering that riders may have availed themselves of full-day passes, ride durations exceeding 24 hours were retained in the final processed dataset.
```sql
--Deleting entries with ride duration less than one minute

DELETE FROM bikesharedata
WHERE ride_duration < 1;
```
This approach ensures the dataset remains consistent and aligns with the specific considerations related to ride durations.

- After completing the data cleaning and transformation process while also maintaining data accuracy and integrity, I proceeded to execute a query to generate some descriptive statistics for the dataset based on the membership categories. This step allowed for a comprehensive overview and analysis of key statistical measures within the dataset and provides valuable insights into the distribution and characteristics of the dataset, allowing for a deeper understanding of the membership dynamics.
```sql
--Query for some descriptive statistics and grouping by membership type

SELECT 
	member_casual,
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
FROM bikesharedata
GROUP BY member_casual;
```

To review this step-by-step process, please refer to the SQL files available in this GitHub repository provided in the following order:
1. Cyclistics create table and insert data
2. Cyclistic data cleaning
3. Cyclistic descriptive statistics

To effectively execute the queries yourself, ensure you modify the "FROM" clause in the queries to correspond with the specific location in your locally created database. This adjustment is crucial to successfully execute the query.

After the data was properly cleaned and transformed, it was ready for analysis and visualization using Power BI to reveal key insights about the data and to draw inference.

### Executive Summary
This report provides an analysis of Cyclistic bike usage based on membership types and other factors.
The analysis of the Cyclistic bike sharing program data reveals a preference among the majority of riders for the convenience and benefits of annual membership.

Further analysis shows that there are differences in the rideable types preferred by annual members and casual riders.
However, casual riders also show a preference for electric bikes, while docked bikes are predominantly used by annual members.

Additionally, the analysis of total rides and average ride durations by day of the week, month and start time provides insights into the riding habits of different membership types.
While annual members had more rides on weekdays and casual riders on weekends, both groups exhibit higher average ride durations on weekends than  weekdays. There are variations across different days of the week and months for total number of rides for both groups.

Based on the findings, recommendations are provided to Cyclistic to optimize their services and attract more casual riders to become annual members.
Digital media can be effectively utilized to target casual riders and showcase the benefits of annual membership.

The final visuals and the dashboard I created can be viewed on my [Power BI Dashboard](https://app.powerbi.com/groups/me/reports/8eb4152e-d64b-40a9-bbd0-5cb4c00a890f/ReportSection).

### Key Insights
1. **Annual members vs. casual riders:**
- The dataset consists of 5,596,408 rides, with 3,302,300 (59.01%) of rides taken by annual members and 2,294,108 (40.99%) by casual riders.
- The significant majority of rides are attributed to annual members, suggesting a preference for the convenience and benefits associated with being annual members.

2. **Bike rideable types:**
- The majority of classic bike rides are taken by both casual riders and members making it the most popular among both rider classes.
- On the other hand, the docked bike rideable type is primarily used by casual riders. 
- Electric bikes, however, are utilized by both casual riders and members, but there is a higher proportion of casual riders using electric bikes.
- This indicates that annual members may have a preference for a more traditional and stable bike option, while casual riders are more open to trying newer and more innovative rideable types.

3. **Daily rides and average ride duration:**
- Annual members generally had higher number of rides on weekdays while casual riders had more rides on weekend days.
- In terms of average ride duration, rides taken by casual riders tend to be significantly longer, more than double the duration of annual members.
- Weekend days (Saturday and Sunday) generally have higher ride durations for both casual riders and annual members.
- These variations across different days of the week suggest potential factors influencing daily rides and ride duration for both annual members and casual riders.

4. **Start time trend:**
- Analysis of the bike sharing data reveals that more rides are start between 8 AM to 7 PM and reaches a peak number of rides at 5 PM for both annual members and casual riders, indicating a common pattern of high demand during the evening hours.
- This finding suggests that many riders utilize the Cyclistic bikes for commuting or recreational purposes after work.

5. **Monthly rides:**
- The months with the highest ride counts for both casual riders and annual members are May, June, July, and August.
- Annual members consistently have higher ride counts than casual riders across all months.

### Recommendations
1. Encourage casual riders to become annual members:
- Highlight the benefits of annual memberships, such as cost savings, unlimited access to bikes, and priority availability during peak hours.
- Offer promotional discounts or incentives to encourage casual riders to try out annual memberships especially for the weekends.

2. Improve ride experience for casual riders:
- Ensure a sufficient number of rideable types, particularly electric bikes, to meet the demand of casual riders.
- Enhance customer support and communication channels to address any concerns or queries from casual riders.
 
3. Targeted digital media campaigns:
- Utilize digital marketing channels to promote the advantages of annual memberships, targeting casual riders through social media, email marketing, and online advertisements.
- Share success stories or testimonials from satisfied annual members to create a sense of community and inspire casual riders to become members.
