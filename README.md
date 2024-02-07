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
 select location, date, population,total_cases, new_cases, total_deaths from covidDeaths1 order by 1,2;
~~~

2. Death Percentage vs. Cases:
~~~
select location, date, population,total_cases,total_deaths,cast(total_deaths as float)/total_cases* 100 as Deathpercentage 
from covidDeaths1 
where location = 'India';
~~~

3. Percent Population Infected:
~~~
select location,date, total_cases,population,cast(total_cases as float)/population*100 as DeathPercentage 
from covidDeaths1
where location like '%India%'
order by 1,2;
~~~

4. Highest Infection Rates:
~~~
select location, population, Max(total_cases) as highest_infection_ct,max(cast(total_cases as float)/population*100 )as Percentage_population_infected 
from covidDeaths1 
group by location,population
order by Percentage_population_infected desc;
~~~

5. Highest Death Counts:
~~~
select location, Max(total_deaths) as TotalDeath_ct
from covidDeaths1 
where continent is not null
group by location
order by TotalDeath_ct desc;
~~~

6. Population vs. Vaccinations:
~~~
with PopvsVac (continent, location, date, population,new_vaccinations, RollingVaccinated)
as
(
Select dea.continent, dea.location, dea.date,dea.population, vac.new_vaccinations,
sum(vac.new_vaccinations) over (partition by dea.location order by dea.location,dea.date) as RollingPeopleVaccinated
from covidDeaths1 dea
join CovidVaccinations vac
on dea.location = vac.location
and dea.date = vac.date
where dea.continent is not null
)
select * from PopvsVac;
~~~

## Tableau Dashboard:

## 1. Global Overview (Table):

- This sheet presents a table summarizing key metrics across different regions and countries, including death percentages, total cases, and total deaths.
It provides a quick snapshot of the global COVID-19 situation, allowing users to compare and identify areas of concern.

## 2. Death Count by Continent (Bar Chart):

- This sheet utilizes a bar chart to visually compare the total death counts across continents (Europe, Asia, North America, South America, Africa, India, and Oceania).
It helps users understand the distribution of the pandemic's impact on different regions, highlighting areas with higher death tolls.

## 3. Percent Population Infected by Country:

- This sheet displays the percentage of each country's population infected with COVID-19.
It provides insights into the relative severity of the pandemic's impact on different countries, allowing users to identify areas with higher infection rates.

## 4. Average Percent Population Infected by Year (Line Chart):

- This sheet features a line chart tracking the average percentage population infected with COVID-19 across specific countries (Africa, China, Mexico, India, United Kingdom, and United States) from 2020 to 2023.
It reveals trends in infection rates over time, enabling users to compare the trajectories of different countries and assess the effectiveness of their response measures.
Interactive Features:

- The dashboard incorporates filters to allow users to focus on specific countries or regions.
This interactivity empowers users to explore the data in more detail and gain deeper insights.
Visualizations and Insights:

## Conclusion:

- By combining the power of SQL Server exploration with the visual storytelling capabilities of Tableau, this project offers a comprehensive and interactive understanding of the COVID-19 pandemic's global impact and regional variations. The insights gleaned from this analysis can inform public health strategies and resource allocation, ultimately aiding in mitigating the pandemic's effects.

## Dashboard [data](.image/image1.png)

 

