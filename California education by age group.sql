/* This script consist of SQL code to determine the education level based on age group usign california education data */
USE california_edu;
CREATE TABLE Cali_edu(
      year TEXT, age TEXT, gender VARCHAR(6),
      edu_attainment TEXT, income TEXT, population INT);
      
/*Load Data*/     
LOAD DATA LOCAL INFILE 'C:\\Users\\User\\sarahsamarasekara/Desktop/California\ education.csv '
INTO TABLE California_education
FIELDS TERMINATED BY ','
ENCLOSED BY "" 
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

/* Percentage of education attainment for each category across age groups */
SELECT 
	cali_edu.age, 
	cali_edu.edu_attainment, 
    SUM(cali_edu.population) / total_pop_by_age.total_population AS cofficient
FROM cali_edu
JOIN 
	(SELECT age, SUM(population) as total_population
	FROM cali_edu
	GROUP BY age) AS total_pop_by_age
ON cali_edu.age = total_pop_by_age.age
GROUP BY cali_edu.age, cali_edu.edu_attainment;

/* create new table from the result */
CREATE TABLE demographics AS
SELECT 
	cali_edu.age, 
	cali_edu.edu_attainment, 
    SUM(cali_edu.population) / total_pop_by_age.total_population AS coefficient
FROM cali_edu
JOIN 
	(SELECT age, SUM(population) as total_population
	FROM cali_edu
	GROUP BY age) AS total_pop_by_age
ON cali_edu.age = total_pop_by_age.age
GROUP BY cali_edu.age, cali_edu.edu_attainment;
 
/*Using Population Projection data: the projection of education demand for each age group */
SELECT 
	temp_pop.date_year AS 'Year',
    demographics.edu_attainment AS 'Education',
    ROUND(SUM(temp_pop.total_pop * demographics.coefficient)) AS 'Demand'
FROM
(SELECT date_year, age, SUM(population) AS total_pop
FROM pop_proj
GROUP BY age, date_year) AS temp_pop
JOIN demographics
ON demographics.age = CASE
	WHEN temp_pop.age < 18 THEN '00 to 17'
    WHEN temp_pop.age < 64 THEN '65 to 80+'
    ELSE '18 to 64'
    END
GROUP BY 1, 2;

