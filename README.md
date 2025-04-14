# 💧 Water Pollution & Disease Impact Analysis – Snowflake + Power BI Project

This project analyzes the relationship between **water quality indicators** and **public health outcomes** such as diarrheal diseases, cholera, typhoid, and infant mortality. The data is ingested in **JSON format into Snowflake**, and a rich interactive dashboard is built using **Power BI**.

---

## 📊 Project Overview

This project aims to:
- Import and transform environmental + health data from JSON into Snowflake.
- Analyze correlations between water contamination and disease rates.
- Visualize key metrics and trends in Power BI to support decision-making.

Technologies used:
- **Snowflake** (cloud data warehouse)
- **SQL** for data transformation and querying
- **Power BI** for dashboard development
- **JSON** as the source data format

---

## 🧾 Data Source

The dataset is provided in a JSON format file:  
`/data/csvjson.json`

Each record contains:
- **Water Quality Indicators**  
  (pH, turbidity, nitrate, lead, bacteria count, oxygen levels)
- **Health Impact**  
  (cases of diarrhea, cholera, typhoid per 100,000; infant mortality)
- **Demographics & Environment**  
  (country, region, population density, GDP, urbanization, rainfall)

**--Click here to download SQL Scripts : https://github.com/Prakhyat3108/Snowflake_Project/blob/main/SQL%20Scripts.zip**
**#SQL Scripts**
**--Create Database, Schema, and Stage**

CREATE OR REPLACE DATABASE WATER_POLLUTION_DB;
USE DATABASE WATER_POLLUTION_DB;

CREATE OR REPLACE SCHEMA WATER_DATA;
USE SCHEMA WATER_DATA;

-- Create an internal stage to hold the JSON file

CREATE OR REPLACE STAGE WATER_STAGE;

**-- Create table**

CREATE OR REPLACE TABLE WATER_POLLUTION_RAW (
    json_data VARIANT
);

**-- Load JSON Data into Raw Table**

COPY INTO WATER_POLLUTION_RAW
FROM @WATER_STAGE/csvjson.json
FILE_FORMAT = (TYPE = 'JSON');


**---Create Table to push data**

CREATE OR REPLACE TABLE WATER_POLLUTION_STATS AS

SELECT
    value:"Country"::STRING AS Country,
    value:"Region"::STRING AS Region,
    value:"Year"::INT AS Year,
    value:"Water Source Type"::STRING AS Water_Source_Type,
    value:"Contaminant Level (ppm)"::FLOAT AS Contaminant_Level_ppm,
    value:"pH Level"::FLOAT AS pH_Level,
    value:"Turbidity (NTU)"::FLOAT AS Turbidity_NTU,
    value:"Dissolved Oxygen (mg/L)"::FLOAT AS Dissolved_Oxygen_mg_L,
    value:"Nitrate Level (mg/L)"::FLOAT AS Nitrate_Level_mg_L,
    value:"Lead Concentration (µg/L)"::FLOAT AS Lead_Concentration_ug_L,
    value:"Bacteria Count (CFU/mL)"::INT AS Bacteria_Count_CFU_mL,
    value:"Water Treatment Method"::STRING AS Water_Treatment_Method,
    value:"Access to Clean Water (% of Population)"::FLOAT AS Access_to_Clean_Water_Percent,
    value:"Diarrheal Cases per 100,000 people"::INT AS Diarrheal_Cases_per_100k,
    value:"Cholera Cases per 100,000 people"::INT AS Cholera_Cases_per_100k,
    value:"Typhoid Cases per 100,000 people"::INT AS Typhoid_Cases_per_100k,
    value:"Infant Mortality Rate (per 1,000 live births)"::FLOAT AS Infant_Mortality_Rate,
    value:"GDP per Capita (USD)"::INT AS GDP_per_Capita_USD,
    value:"Healthcare Access Index (0-100)"::FLOAT AS Healthcare_Access_Index,
    value:"Urbanization Rate (%)"::FLOAT AS Urbanization_Rate_Percent,
    value:"Sanitation Coverage (% of Population)"::FLOAT AS Sanitation_Coverage_Percent,
    value:"Rainfall (mm per year)"::INT AS Rainfall_mm_per_year,
    value:"Temperature (°C)"::FLOAT AS Temperature_C,
    value:"Population Density (people per km²)"::INT AS Population_Density_per_km2
FROM WATER_POLLUTION_RAW,
     LATERAL FLATTEN(input => json_data);

**--Copy json data into table**

COPY INTO WATER_DATA.WATER_POLLUTION_STATS
FROM @WATER_DATA.WATER_STAGE/cvjson.csv
FILE_FORMAT = (TYPE = 'CSV' FIELD_OPTIONALLY_ENCLOSED_BY = '"' SKIP_HEADER = 1);

**--check**

SELECT * FROM WATER_DATA.WATER_POLLUTION_STATS LIMIT 10;


**--SQL Queries for Insights
--Average Water Quality Indicators by Country**

SELECT 
    Country,
    AVG(Contaminant_Level_ppm) AS Avg_Contaminant,
    AVG(pH_Level) AS Avg_pH,
    AVG(Turbidity_NTU) AS Avg_Turbidity,
    AVG(Dissolved_Oxygen_mg_L) AS Avg_DO
FROM WATER_DATA.WATER_POLLUTION_STATS
GROUP BY Country;

**-- Disease Cases vs. Water Quality**

SELECT 
    Region,
    AVG(Contaminant_Level_ppm) AS Avg_Contaminant,
    AVG(Diarrheal_Cases_per_100k) AS Avg_Diarrhea,
    AVG(Cholera_Cases_per_100k) AS Avg_Cholera,
    AVG(Typhoid_Cases_per_100k) AS Avg_Typhoid
FROM WATER_DATA.WATER_POLLUTION_STATS
GROUP BY Region;

**--Correlation of Access to Clean Water and Health**

SELECT 
    Country,
    AVG(Access_to_Clean_Water_Percent) AS Access_Clean_Water,
    AVG(Diarrheal_Cases_per_100k) AS Diarrheal_Cases,
    AVG(Infant_Mortality_Rate) AS Infant_Mortality
FROM WATER_DATA.WATER_POLLUTION_STATS
GROUP BY Country;

