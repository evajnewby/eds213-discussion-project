# Asthma and PM2.5 Concentration Analysis with DuckDB

Author: [Eva Newby](evajnewby.github.io) for Databases and Data Mangagement (EDS213) at the [Bren School of Environmental Sciences and Management](https://bren.ucsb.edu/).

Date: Last updated by author in May 2025

## Purpose
This project explores the relationship between air quality (specifically PM2.5 concentration) and asthma rates across U.S. counties in the year 2020. DuckDB is used as an in-process SQL database engine to ingest, clean, and analyze two real-world datasets: one on daily PM2.5 air quality metrics, and another on annual asthma prevalence in the United States.

![image](https://github.com/user-attachments/assets/7a583d86-c965-477d-99f7-b6970cc4a24f)
source: (One Earth, Cell Press)[https://www.cell.com/action/showPdf?pii=S2590-3322%2824%2900487-1]

## Objectives
- Clean and ingest environmental and health-related datasets into DuckDB
- Define a relational schema suitable for querying and analysis
- Perform SQL-based analysis to investigate geographic patterns in pollution and asthma
- Answer which counties had the highest average PM2.5 levels and their corresponding asthma rates

## The Data
- Asthma Dataset: Contains annual asthma prevalence estimates by county. Can be found at the [National Environmental Public Health Tracking Network](https://ephtracking.cdc.gov/DataExplorer/) by the United States Centers for Disease Control website.
- Air Quality Dataset (PM2.5): Includes daily mean PM2.5 concentrations and AQI values by monitoring site. Can be found at the United States [Environmental Protection Agency](https://www.epa.gov/outdoor-air-quality-data/download-daily-data) website.

## Repository Structure
```
eds213-discussion-project/
│── data-cleaning.ipynb
|
│── database-query.sql
|
│── gitignore
|    ├── data/
|       ├── asthma_2020.csv
|       ├──aqi_pm25_data.csv
│       ├── cleaned_asthma.csv
│       └── cleaned_aqi_pm25.csv
|
└── README.md
```
## Notebook and Scripts
- The "data-cleaning.ipynb" python notebook details all the data cleaning and download, prior to ingesting into a database using DuckDB.
- The "database-query.sql" file details ingesting into a database using DuckDB and the query needed to answer our question. 

## DuckDB Tables Generated
-asthma1: Cleaned table containing county-level asthma rates and confidence intervals for 2020.
- aqi_pm25: Cleaned table containing daily PM2.5 air quality data for 2020.

