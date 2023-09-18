CREATE TABLE FATALITIES (
    iso_code VARCHAR(255),    continent VARCHAR(255),    location VARCHAR(255),    date DATE,    population BIGINT,    total_cases NUMERIC(16, 3),    new_cases NUMERIC(16, 3),    new_cases_smoothed NUMERIC(16, 3),    total_deaths NUMERIC(16, 3),    new_deaths NUMERIC(16, 3),    new_deaths_smoothed NUMERIC(16, 3),    total_cases_per_million NUMERIC(16, 3),    new_cases_per_million NUMERIC(16, 3),    new_cases_smoothed_per_million NUMERIC(16, 3),    total_deaths_per_million NUMERIC(16, 3),    new_deaths_per_million NUMERIC(16, 3),    new_deaths_smoothed_per_million NUMERIC(16, 3),    reproduction_rate NUMERIC(16, 3),    icu_patients NUMERIC(16, 3),    icu_patients_per_million NUMERIC(16, 3),    hosp_patients NUMERIC(16, 3),    hosp_patients_per_million NUMERIC(16, 3),    weekly_icu_admissions NUMERIC(16, 3),    weekly_icu_admissions_per_million NUMERIC(16, 3),    weekly_hosp_admissions NUMERIC(16, 3),    weekly_hosp_admissions_per_million NUMERIC(16, 3),    total_tests NUMERIC(16, 3)
);

-- Import data into FATALITIES via csv - "C:\1Projects\1_Covid_Deaths.csv" - with headers --

CREATE TABLE VACCINATIONS (
    iso_code VARCHAR(255),    continent VARCHAR(255),    location VARCHAR(255),    date DATE,    total_tests NUMERIC(16, 3),    new_tests NUMERIC(16, 3),    total_tests_per_thousand NUMERIC(16, 3),    new_tests_per_thousand NUMERIC(16, 3),    new_tests_smoothed NUMERIC(16, 3),    new_tests_smoothed_per_thousand NUMERIC(16, 3),    positive_rate NUMERIC(16, 3),    tests_per_case NUMERIC(16, 3),    tests_units VARCHAR(255),    total_vaccinations NUMERIC(16, 3),    people_vaccinated NUMERIC(16, 3),    people_fully_vaccinated NUMERIC(16, 3),    total_boosters NUMERIC(16, 3),    new_vaccinations NUMERIC(16, 3),    new_vaccinations_smoothed NUMERIC(16, 3),    total_vaccinations_per_hundred NUMERIC(16, 3),    people_vaccinated_per_hundred NUMERIC(16, 3),    people_fully_vaccinated_per_hundred NUMERIC(16, 3),    total_boosters_per_hundred NUMERIC(16, 3),    new_vaccinations_smoothed_per_million NUMERIC(16, 3),    new_people_vaccinated_smoothed NUMERIC(16, 3),    new_people_vaccinated_smoothed_per_hundred NUMERIC(16, 3),    stringency_index NUMERIC(16, 3),    population_density NUMERIC(16, 3),    median_age NUMERIC(16, 3),    aged_65_older NUMERIC(16, 3),    aged_70_older NUMERIC(16, 3),    gdp_per_capita NUMERIC(16, 3),    extreme_poverty NUMERIC(16, 3),    cardiovasc_death_rate NUMERIC(16, 3),    diabetes_prevalence NUMERIC(16, 3),    female_smokers NUMERIC(16, 3),    male_smokers NUMERIC(16, 3),    handwashing_facilities NUMERIC(16, 3),    hospital_beds_per_thousand NUMERIC(16, 3),    life_expectancy NUMERIC(16, 3),    human_development_index NUMERIC(16, 3),    excess_mortality_cumulative_absolute NUMERIC(16, 3),    excess_mortality_cumulative NUMERIC(16, 3),    excess_mortality NUMERIC(16, 3),    excess_mortality_cumulative_per_million NUMERIC(16, 3)
);
-- Import data into VACCINATIONS via csv - "C:\1Projects\1_Covid_Vaccinations.csv" - with headers --

SELECT *
FROM FATALITIES;

SELECT *
FROM VACCINATIONS;










