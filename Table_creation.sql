
---Create Table to push data
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

--Copy json data into table
COPY INTO WATER_DATA.WATER_POLLUTION_STATS
FROM @WATER_DATA.WATER_STAGE/cvjson.csv
FILE_FORMAT = (TYPE = 'CSV' FIELD_OPTIONALLY_ENCLOSED_BY = '"' SKIP_HEADER = 1);

--check
SELECT * FROM WATER_DATA.WATER_POLLUTION_STATS LIMIT 10;