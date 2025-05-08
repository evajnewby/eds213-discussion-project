-- create asthma table in DuckDB
CREATE TABLE asthma (
    statefips INTEGER,
    state TEXT,
    countyfips INTEGER,
    county TEXT,
    year INTEGER,
    value FLOAT,
    data_comment TEXT,
    confidence_interval TEXT,
    confidence_interval_low FLOAT,
    confidence_interval_high FLOAT);

    COPY asthma FROM 'discussion/eds213-discussion-project/data/cleaned_asthma.csv' (HEADER TRUE, AUTO_DETECT TRUE);

-- Check table
Select * FROM asthma;

-- why do I have no rows? ugh
-- other ways?

CREATE TABLE asthma1 AS
SELECT * FROM read_csv_auto('discussion/eds213-discussion-project/data/cleaned_asthma.csv', HEADER=TRUE);

-- Check table
Select * FROM asthma1;

-- that's working, but I'm not sure why there's a period column? 
-- drop the period column in duckdb
ALTER TABLE asthma1 DROP COLUMN ".";

-- Create AQI table in DuckDB
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

-- confirm tables in duckdb
SHOW TABLES;

-- DROP TABLE IF EXISTS asthma;

-- My Question: Which counties had the highest average PM2.5 concentration in 2020 (data is already filtered for 2020), and what were their corresponding asthma rates?
-- Export to .csv
COPY (
    SELECT 
        aqi.countyfips,
        aqi.county,
        aqi.state,
        ROUND(AVG(aqi.daily_mean_pm25_concentration), 2) AS avg_pm25,
        ast.value AS asthma_rate
    FROM aqi_pm25 AS aqi
    LEFT JOIN asthma1 AS ast
        ON aqi.countyfips = ast.countyfips
        AND aqi.state = ast.state
        AND ast.year = 2020
    WHERE aqi.daily_mean_pm25_concentration IS NOT NULL
    GROUP BY aqi.countyfips, aqi.county, aqi.state, ast.value
    ORDER BY avg_pm25 DESC
    LIMIT 10
) TO 'discussion/eds213-discussion-project/data/top10_pm25_asthma.csv' (HEADER, DELIMITER ',');

