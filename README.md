# Cyclistic Bikeshare: Converting Casual Riders to Members (A Capstone Project)

This project is a case study I did using both Microsoft SQL Server and Power BI.
I carried out analysis on this case study to improve my skills as a data analyst and also as part of the requirements to obtain my Google Data Analytics Professional Certification.

## Introduction
The purpose of this report is to analyze and provide insights into the usage patterns and behaviors of Cyclistic bike riders, with specific focus on the differences between annual members and casual riders.
The analysis utilizes data from Cyclistic's bike sharing program and employs **Microsoft SQL Server (SSMS)** and **Power BI.**
The report seeks to address the following research questions:
1. How do annual members and casual riders use Cyclistic bikes differently?
2. Why would casual riders buy Cyclistic annual memberships?
3. How can Cyclistic use digital media to influence casual riders to become members?

## The Data
The analysis relies on a comprehensive dataset obtained from the Cyclistic bike sharing program and encompasses various data points after data cleaning which include membership type, rideable type, start day, start month, and ride duration.
Spanning from January 2022 to December 2022, this dataset consists of 5,596,408 rides and offers a substantial timeframe for examining riders' behaviors and preferences.
The dataset can be downloaded [here](https://divvy-tripdata.s3.amazonaws.com/index.html)

Remember to adhere to the [Data License Agreement](https://ride.divvybikes.com/data-license-agreement) when working with the data in this project or any data associated with it.
The dataset forms the foundation of this report and is crucial to understanding the usage patterns and behaviors of Cyclistic bike riders.

## Data Preparation, Cleaning and Transformation Process
Prior to analysis, the dataset was carefully curated and cleaned to ensure that the analysis is based on accurate and reliable data.
The downloaded dataset was imported into my local SSMS to enable me use SQL queries to carry out further inspection, cleaning and transformation.
After importing all the data, I utilized an SQL query to create a new table.
The dataset from the 12 separate files was inserted into this table, preserving the original raw dataset for future reference.
Additionally, I conducted further data exploration, cleaning, and transformation by running additional queries. To review this step-by-step process, please refer to the files available in the GitHub Project provided in the following order:
1. Cyclistics create table and insert data
2. Cyclistic data cleaning
3. Cyclistic descriptive statistics

To effectively execute the queries yourself, ensure you modify the "FROM" clause in the queries to correspond with the specific location in your locally created database. This adjustment is crucial to successfully execute the query.
After the data was properly cleaned and transformed, it was ready for analysis and visualization using Power BI to reveal key insights about the data and to draw inference.

## Executive Summary
This report provides an analysis of Cyclistic bike usage based on membership types and other factors.
The analysis of the Cyclistic bike sharing program data reveals a preference among the majority of riders for the convenience and benefits of annual membership.

Further analysis shows that there are differences in the rideable types preferred by annual members and casual riders.
However, casual riders also show a preference for electric bikes, while docked bikes are predominantly used by annual members.

Additionally, the analysis of total rides and average ride durations by day of the week, month and start time provides insights into the riding habits of different membership types.
While annual members had more rides on weekdays and casual riders on weekends, both groups exhibit higher average ride durations on weekends than  weekdays. There are variations across different days of the week and months for total number of rides for both groups.

Based on the findings, recommendations are provided to Cyclistic to optimize their services and attract more casual riders to become annual members.
Digital media can be effectively utilized to target casual riders and showcase the benefits of annual membership.

The final visuals and the dashboard I created can be viewed on my [Power BI Dashboard](https://app.powerbi.com/groups/me/reports/8eb4152e-d64b-40a9-bbd0-5cb4c00a890f/ReportSection).

## Key Insights
-**Annual members vs. casual riders:** The dataset consists of 5,596,408 rides, with 3,302,300 (59.01%) of rides taken by annual members and 2,294,108 (40.99%) by casual riders.
The significant majority of rides are attributed to annual members, suggesting a preference for the convenience and benefits associated with being annual members.


