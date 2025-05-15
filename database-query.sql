-- create asthma table in DuckDB
CREATE TABLE asthma AS
SELECT * FROM read_csv_auto('discussion/eds213-discussion-project/data/cleaned_asthma.csv', HEADER=TRUE);

-- Check table value and county column to prepare for future join
Select value FROM asthma;
SELECT county from asthma;

-- check to make sure column types are correct 
PRAGMA table_info(asthma);

-- Create AQI table in DuckDB using COPY method
CREATE TABLE aqi_pm25 (
    date DATE,
    source TEXT,
    site_id TEXT,
    poc INTEGER,
    daily_mean_pm25_concentration FLOAT,
    units TEXT,
    daily_aqi_value INTEGER,
    local_site_name TEXT,
    daily_obs_count INTEGER,
    percent_complete FLOAT,
    aqs_parameter_code TEXT,
    aqs_parameter_description TEXT,
    method_code TEXT,
    method_description TEXT,
    cbsa_code TEXT,
    cbsa_name TEXT,
    state_fips_code INTEGER,
    state TEXT,
    countyfips INTEGER,
    county TEXT,
    site_latitude FLOAT,
    site_longitude FLOAT);

    COPY aqi_pm25 FROM 'discussion/eds213-discussion-project/data/cleaned_aqi_pm25.csv' (HEADER TRUE);

-- check table
Select * FROM aqi_pm25;
SELECT county FROM aqi_pm25;

-- confirm tables in duckdb
SHOW TABLES;

-- My Question: Which counties had the highest average PM2.5 concentration in 2020, and what were their corresponding asthma rates?
-- Create new table in database for top 10 counties by average PM2.5 with asthma rates
CREATE TABLE top10_pm25_asthma AS
SELECT 
    aqi.countyfips,
    aqi.county,
    aqi.state,
    ROUND(AVG(aqi.daily_mean_pm25_concentration), 2) AS avg_pm25,
    ast.value AS asthma_rate 
FROM aqi_pm25 AS aqi
LEFT JOIN asthma AS ast
    ON TRIM(LOWER(aqi.county)) = TRIM(LOWER(ast.county))
    AND TRIM(LOWER(aqi.state)) = TRIM(LOWER(ast.state))
    AND ast.year = 2020
WHERE aqi.daily_mean_pm25_concentration IS NOT NULL
GROUP BY aqi.countyfips, aqi.county, aqi.state, ast.value
ORDER BY avg_pm25 DESC
LIMIT 10;

-- Export to a CSV
COPY top10_pm25_asthma 
TO 'discussion/eds213-discussion-project/data/top10_pm25_asthma.csv' 
(HEADER, DELIMITER ',');

-- show tables to make sure new table is in the database
SHOW TABLES;

-- check the table to make sure there are values
SELECT * FROM top10_pm25_asthma;






