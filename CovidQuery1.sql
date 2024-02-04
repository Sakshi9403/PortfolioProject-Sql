use PortfolioProject;
SELECT top 3 * from covidDeaths1;

SELECT  * from CovidVaccinations;

select location, date, population,total_cases, new_cases, total_deaths from covidDeaths1 order by 1,2;

-- looking at total cases vs total deaths
select location, date, population,total_cases,total_deaths,cast(total_deaths as float)/total_cases* 100 as Deathpercentage 
from covidDeaths1 
where location = 'India';

-- key learning is that we should be careful while setting the data type of the columns bigint/int = int output


exec sp_columns covidDeaths1;

-- looking at the stats of what percentage of population got covid
select location,date, total_cases,population,cast(total_cases as float)/population*100 as DeathPercentage 
from covidDeaths1
where location like '%India%'
order by 1,2;

--looking at countries with highest infection rate compared to population
select location, population, Max(total_cases) as highest_infection_ct,max(cast(total_cases as float)/population*100 )as Percentage_population_infected 
from covidDeaths1 
group by location,population
order by Percentage_population_infected desc;

-- showing countries with the highest death count per population
select location, Max(total_deaths) as TotalDeath_ct
from covidDeaths1 
where continent is not null
group by location
order by TotalDeath_ct desc;

-- highest death count by continent
select location,Max(total_deaths) as TotalDeathCount
from covidDeaths1
where continent is null
group by location
order by TotalDeathCount desc;

-- global numbers
--select date, sum(new_cases) as total_cases,sum(new_deaths) as total_deaths, sum(new_deaths)/sum(new_cases) * 100 as DeathPercentage--cast(total_deaths as float)/total_cases*100 as DeathPercentage
--from covidDeaths1 
--where continent is not null and new_cases is not null
--group by date
--order by 1,2;

-- total population vs vaccinations

select dea.continent,dea.location,dea.date,dea.population,vac.new_vaccinations,
sum(cast(vac.new_vaccinations as bigint)) over (partition by dea.location order by dea.location,dea.date) as RollingPeopleVaccinated
from covidDeaths1 dea
join CovidVaccinations vac
on dea.location = vac.location and dea.date = vac.date
where dea.continent is not null 
order by 2,3;

--use CTE 
-- leasson learnt that we can't use the column that we have just created using aggregate functions and order by clause is invalid plus number of columns in cte should be equal to the number of columns in select statement

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



WITH PopvsVac (continent, location, date, population, new_vaccinations, RollingPeopleVaccinated)
AS
(
    SELECT
        dea.continent,
        dea.location,
        dea.date,
        dea.population,
        cast(vac.new_vaccinations as bigint),
        SUM(cast(vac.new_vaccinations as bigint)) OVER (PARTITION BY dea.location ORDER BY dea.location, dea.date) AS RollingPeopleVaccinated
    FROM
        covidDeaths1 dea
    JOIN
        CovidVaccinations vac ON dea.location = vac.location AND dea.date = vac.date
    WHERE
        dea.continent IS NOT NULL
)
SELECT
    continent,
    location,
    date,
    population,
    new_vaccinations,
    cast(RollingPeopleVaccinated as float)/population*100
FROM
    PopvsVac;

-- we can also use temp table to draw same results from the above query
create table #PercentPopulationVaccinated
(
continent nvarchar(50),
location nvarchar(50),
date date,
population bigint,
new_vaccination numeric,
RollingPeopleVaccinated numeric
)
insert into #PercentPopulationVaccinated
SELECT
        dea.continent,
        dea.location,
        dea.date,
        dea.population,
        cast(vac.new_vaccinations as bigint),
        SUM(cast(vac.new_vaccinations as bigint)) OVER (PARTITION BY dea.location ORDER BY dea.location, dea.date) AS RollingPeopleVaccinated
    FROM
        covidDeaths1 dea
    JOIN
        CovidVaccinations vac ON dea.location = vac.location AND dea.date = vac.date
    WHERE
        dea.continent IS NOT NULL


select * from #PercentPopulationVaccinated;

-- views 

create view PercentPopulationVaccinated as 
SELECT
        dea.continent,
        dea.location,
        dea.date,
        dea.population,
        cast(vac.new_vaccinations as bigint),
        SUM(cast(vac.new_vaccinations as bigint)) OVER (PARTITION BY dea.location ORDER BY dea.location, dea.date) AS RollingPeopleVaccinated
    FROM
        covidDeaths1 dea
    JOIN
        CovidVaccinations vac ON dea.location = vac.location AND dea.date = vac.date
    WHERE
        dea.continent IS NOT NULL
	




	CREATE VIEW PercentPopulationVaccinated AS
SELECT
    dea.continent,
    dea.location,
    dea.date,
    dea.population,
    CAST(vac.new_vaccinations AS BIGINT) AS new_vaccinations,
    SUM(CAST(vac.new_vaccinations AS BIGINT)) OVER (PARTITION BY dea.location ORDER BY dea.location, dea.date) AS RollingPeopleVaccinated
FROM
    covidDeaths1 dea
JOIN
    CovidVaccinations vac ON dea.location = vac.location AND dea.date = vac.date
WHERE
    dea.continent IS NOT NULL;

select * from PercentPopulationVaccinated;