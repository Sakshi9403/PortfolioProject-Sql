## COVID-19 Data Exploration and Visualization in SQL Server and Tableau

## Project Description:

This project dives into the Our World in Data COVID-19 dataset, leveraging SQL Server for initial exploration and analysis. Key insights discovered in SQL Server are then brought to life through an interactive Tableau dashboard, providing a clear and comprehensive understanding of the pandemic and vaccination efforts across various regions and countries.

## Data Source:

Our World in Data: https://ourworldindata.org/coronavirus

## Tables Used:

- CovidDeaths: Stores daily data on new cases, total cases, new deaths, and total deaths by location and date.
- CovidVaccinations: Stores daily data on new vaccinations by location and date.

##  Skills Used:

## Data exploration and analysis:
- Joins (INNER, LEFT, RIGHT)
- Common Table Expressions (CTEs)
- Temporary Tables
- Window Functions (OVER, PARTITION BY)
- Aggregate Functions (SUM, MAX, MIN, AVG, COUNT)
- Creating Views
- Converting Data Types
- Data visualization:
- Tableau desktop

  ## SQL Server Exploration:

1. Filtering and Ordering Data:
~~~
- select location, date, population,total_cases, new_cases, total_deaths from covidDeaths1 order by 1,2;
~~~
  

