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

Example JSON snippet:
```json
{
  "Country": "Mexico",
  "Year": 2015,
  "Water Source Type": "Lake",
  "Contaminant Level (ppm)": 0.34,
  "pH Level": 7.1,
  "Diarrheal Cases per 100,000 people": 2600,
  ...
}

