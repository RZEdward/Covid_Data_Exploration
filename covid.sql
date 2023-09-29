-- CREATED TABLE FATALITIES
-- CREATED TABLE VACCINATIONS

select *
from fatalities
order by location, date;

select *
from vaccinations
order by location, date;

-- What do we want to see?

-- Today's death rate (one row - total cases - total deaths - death rate)
-- Global total cases on each day
-- Global rolling total of cases
-- Global total deaths on each day
-- Global rolling total of deaths
-- Global total vaccinations on each day
-- Global rolling total of vaccinations
-- Countries with highest total infection rate (total_country_cases/population) (column chart) (map)
-- Countries with highest total death rate (total_country_deaths/population) (column chart) (map)
-- Countries with highest total vaccination rate (total_country_deaths/population) (column chart) (map)

-- global death rate since first case
create view global_death_rate as
SELECT sum(new_cases) as global_cases, sum(new_deaths) as global_deaths, (sum(new_deaths)/sum(new_cases))*100 as death_rate
FROM FATALITIES
where continent is not null
order by 1,2;

-- combined daily cases & rolling cases
create view global_daily_cases as
SELECT date, 
       SUM(new_cases) AS daily_cases, 
       SUM(SUM(new_cases)) OVER (ORDER BY date) AS rolling_total_cases
FROM fatalities
WHERE continent IS NOT NULL
GROUP BY date
ORDER BY date;

-- combined daily deaths & rolling deaths
create view global_daily_deaths as
SELECT date, 
       SUM(new_deaths) AS daily_deaths, 
       SUM(SUM(new_deaths)) OVER (ORDER BY date) AS rolling_total_deaths
FROM fatalities
WHERE continent IS NOT NULL
GROUP BY date
ORDER BY date;

-- combined daily vaccinations & rolling vaccinations
create view global_daily_vaccinations as
SELECT date, 
       SUM(new_vaccinations) AS daily_vaccinations, 
       SUM(SUM(new_vaccinations)) OVER (ORDER BY date) AS rolling_total_vaccinations
FROM vaccinations
WHERE continent IS NOT NULL
GROUP BY date
ORDER BY date;

-- Countries with highest total infection rate (total_country_cases/population) (column chart) (map)
create view infection_rate as
SELECT location, population, max(total_cases) as HighestInfectionCount, max((total_cases/Population))*100 as PercentPopulationInfected
FROM FATALITIES
Group by location, population
order by 4 desc;

-- Countries with highest total death rate (total_country_deaths/population) (column chart) (map)
create view death_rate as
SELECT location, population, max(total_deaths) as Total_Death_Count, max((total_deaths/Population))*100 as PercentPopulationDead
FROM FATALITIES
Group by location, population
order by 4 desc;

-- Countries with highest total vaccination rate (total_country_deaths/population) (column chart) (map)
create view vaccination_rate as
With Pop_Vac (continent, location, date, population, new_vaccinations, rolling_vaccinations)
as
(
SELECT FATALITIES.continent, FATALITIES.location, FATALITIES.date, FATALITIES.population, VACCINATIONS.new_vaccinations
,sum(VACCINATIONS.new_vaccinations) OVER (Partition by FATALITIES.location Order by FATALITIES.location, FATALITIES.date) as rolling_vaccinations
FROM FATALITIES
JOIN VACCINATIONS
ON FATALITIES.location = VACCINATIONS.location
and FATALITIES.date = VACCINATIONS.date
where FATALITIES.continent is not null
)
SELECT *,
       (CAST(rolling_vaccinations AS NUMERIC(16, 3)) / population) * 100 AS percent_vaccinated
FROM Pop_Vac;


-- number of vaccinations adjusted for population (some people have multiple vaccinations)
create view adjusted_vaccination_rate as
With Pop_Vac (continent, location, date, population, new_vaccinations, rolling_vaccinations)
as
(
SELECT FATALITIES.continent, FATALITIES.location, FATALITIES.date, FATALITIES.population, VACCINATIONS.new_vaccinations
,sum(VACCINATIONS.new_vaccinations) OVER (Partition by FATALITIES.location Order by FATALITIES.location, FATALITIES.date) as rolling_vaccinations
FROM FATALITIES
JOIN VACCINATIONS
ON FATALITIES.location = VACCINATIONS.location
and FATALITIES.date = VACCINATIONS.date
where FATALITIES.continent is not null
)
SELECT location, population, max(rolling_vaccinations) as total_vaccinations, max((CAST(rolling_vaccinations AS NUMERIC(16, 3)) / population) * 100) as percent_vaccinated
FROM Pop_Vac
group by location, population
order by percent_vaccinated desc;

------------------------------------------------------------------------------------------

CREATE USER rzedward WITH PASSWORD 'private' SUPERUSER;

select * 
from global_daily_cases
order by date desc;
