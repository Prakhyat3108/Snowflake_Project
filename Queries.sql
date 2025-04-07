
--SQL Queries for Insights
--Average Water Quality Indicators by Country
SELECT 
    Country,
    AVG(Contaminant_Level_ppm) AS Avg_Contaminant,
    AVG(pH_Level) AS Avg_pH,
    AVG(Turbidity_NTU) AS Avg_Turbidity,
    AVG(Dissolved_Oxygen_mg_L) AS Avg_DO
FROM WATER_DATA.WATER_POLLUTION_STATS
GROUP BY Country;

-- Disease Cases vs. Water Quality
SELECT 
    Region,
    AVG(Contaminant_Level_ppm) AS Avg_Contaminant,
    AVG(Diarrheal_Cases_per_100k) AS Avg_Diarrhea,
    AVG(Cholera_Cases_per_100k) AS Avg_Cholera,
    AVG(Typhoid_Cases_per_100k) AS Avg_Typhoid
FROM WATER_DATA.WATER_POLLUTION_STATS
GROUP BY Region;


--Correlation of Access to Clean Water and Health
SELECT 
    Country,
    AVG(Access_to_Clean_Water_Percent) AS Access_Clean_Water,
    AVG(Diarrheal_Cases_per_100k) AS Diarrheal_Cases,
    AVG(Infant_Mortality_Rate) AS Infant_Mortality
FROM WATER_DATA.WATER_POLLUTION_STATS
GROUP BY Country;
