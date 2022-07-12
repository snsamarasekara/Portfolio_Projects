/*CREATE DATABASE Database1;*/
/* create tables and insert data*/
-- Table: city
USE Database1;
CREATE TABLE city (
    id int  NOT NULL AUTO_INCREMENT,
    city_name char(128)  NOT NULL,
    lat decimal(9,6)  NOT NULL,
    lon decimal(9,6)  NOT NULL,
    country_id int  NOT NULL,
    CONSTRAINT city_pk PRIMARY KEY  (id)
);
-- Table: country
CREATE TABLE country (
    id int  NOT NULL AUTO_INCREMENT,
    country_name char(128)  NOT NULL,
    country_name_eng char(128)  NOT NULL,
    country_code char(8)  NOT NULL,
    CONSTRAINT country_ak_1 UNIQUE (country_name),
    CONSTRAINT country_ak_2 UNIQUE (country_name_eng),
    CONSTRAINT country_ak_3 UNIQUE (country_code),
    CONSTRAINT country_pk PRIMARY KEY  (id)
);
-- Creating foreign keys
-- Reference: city_country (table: city)
ALTER TABLE city ADD CONSTRAINT city_country
    FOREIGN KEY (country_id)
    REFERENCES country (id);
    
INSERT INTO country (country_name, country_name_eng, country_code) VALUES ('Deutschland', 'Germany', 'DEU');
INSERT INTO country (country_name, country_name_eng, country_code) VALUES ('Srbija', 'Serbia', 'SRB');
INSERT INTO country (country_name, country_name_eng, country_code) VALUES ('Hrvatska', 'Croatia', 'HRV');
INSERT INTO country (country_name, country_name_eng, country_code) VALUES ('United Stated of America', 'United Stated of America', 'USA');
INSERT INTO country (country_name, country_name_eng, country_code) VALUES ('Polska', 'Poland', 'POL');    
INSERT INTO country (country_name, country_name_eng, country_code) VALUES ('España', 'Spain', 'ESP');
INSERT INTO country (country_name, country_name_eng, country_code) VALUES ('Rossiya', 'Russia', 'RUS');

INSERT INTO city (city_name, lat, lon, country_id) VALUES ('Berlin', 52.520008, 13.404954, 1);
INSERT INTO city (city_name, lat, lon, country_id) VALUES ('Belgrade', 44.787197, 20.457273, 2);
INSERT INTO city (city_name, lat, lon, country_id) VALUES ('Zagreb', 45.815399, 15.966568, 3);
INSERT INTO city (city_name, lat, lon, country_id) VALUES ('New York', 40.73061, -73.935242, 4);
INSERT INTO city (city_name, lat, lon, country_id) VALUES ('Los Angeles', 34.052235, -118.243683, 4);
INSERT INTO city (city_name, lat, lon, country_id) VALUES ('Warsaw', 52.237049, 21.017532, 5);

/* creating table with 6 columns city_id,city_name,country_id,country_name_eng and country_code by joining tables using INNER JOIN*/
SELECT city.id AS city_id, city.city_name, country.id AS country_id, country.country_name, country.country_name_eng, country.country_code
FROM city
INNER JOIN country ON city.country_id = country.id
WHERE country.id IN (1,4,5,6,7);

/* Using LEFT JOIN to get a table with all values including NULL*/
SELECT city.id AS city_id, city.city_name, country.id AS country_id, country.country_name, country.country_name_eng, country.country_code
FROM country
LEFT JOIN city ON city.country_id = country.id
WHERE country.id IN (1,4,5,6,7);

/* Adding more tables to database*/
-- tables
-- Table: call
CREATE TABLE calls (
    id int  NOT NULL AUTO_INCREMENT,
    employee_id int  NOT NULL,
    customer_id int  NOT NULL,
    start_time datetime  NOT NULL,
    end_time datetime  NULL,
    call_outcome_id int  NULL,
    CONSTRAINT call_ak_1 UNIQUE (employee_id, start_time),
    CONSTRAINT call_pk PRIMARY KEY  (id)
);
    
-- Table: call_outcome
CREATE TABLE call_outcome (
    id int  NOT NULL AUTO_INCREMENT,
    outcome_text char(128)  NOT NULL,
    CONSTRAINT call_outcome_ak_1 UNIQUE (outcome_text),
    CONSTRAINT call_outcome_pk PRIMARY KEY  (id)
);
    
-- Table: customer
CREATE TABLE customer (
    id int  NOT NULL AUTO_INCREMENT,
    customer_name varchar(255)  NOT NULL,
    city_id int  NOT NULL,
    customer_address varchar(255)  NOT NULL,
    next_call_date date  NULL,
    ts_inserted datetime  NOT NULL,
    CONSTRAINT customer_pk PRIMARY KEY  (id)
);
    
-- Table: employee
CREATE TABLE employee (
    id int  NOT NULL AUTO_INCREMENT,
    first_name varchar(255)  NOT NULL,
    last_name varchar(255)  NOT NULL,
    CONSTRAINT employee_pk PRIMARY KEY  (id)
);
-- creating relationships using foreign keys
-- Reference: call_call_outcome (table: call)
ALTER TABLE calls ADD CONSTRAINT call_call_outcome
    FOREIGN KEY (call_outcome_id)
    REFERENCES call_outcome (id);
    
-- Reference: call_customer (table: call)
ALTER TABLE calls ADD CONSTRAINT call_customer
    FOREIGN KEY (customer_id)
    REFERENCES customer (id);
 
-- Reference: call_employee (table: call)
ALTER TABLE calls ADD CONSTRAINT call_employee
    FOREIGN KEY (employee_id)
    REFERENCES employee (id);
 
-- Reference: customer_city (table: customer)
ALTER TABLE customer ADD CONSTRAINT customer_city
    FOREIGN KEY (city_id)
    REFERENCES city (id);
    
-- insert values
INSERT INTO call_outcome (outcome_text) VALUES ('call started');
INSERT INTO call_outcome (outcome_text) VALUES ('finished - successfully');
INSERT INTO call_outcome (outcome_text) VALUES ('finished - unsuccessfully');
    
INSERT INTO employee (first_name, last_name) VALUES ('Thomas (Neo)', 'Anderson');
INSERT INTO employee (first_name, last_name) VALUES ('Agent', 'Smith');
    
INSERT INTO customer (customer_name, city_id, customer_address, next_call_date, ts_inserted) VALUES ('Jewelry Store', 4, 'Long Street 120', '2020/1/21', '2020/1/9 14:1:20');
INSERT INTO customer (customer_name, city_id, customer_address, next_call_date, ts_inserted) VALUES ('Bakery', 1, 'Kurfürstendamm 25', '2020/2/21', '2020/1/9 17:52:15');
INSERT INTO customer (customer_name, city_id, customer_address, next_call_date, ts_inserted) VALUES ('Café', 1, 'Tauentzienstraße 44', '2020/1/21', '2020/1/10 8:2:49');
INSERT INTO customer (customer_name, city_id, customer_address, next_call_date, ts_inserted) VALUES ('Restaurant', 3, 'Ulica lipa 15', '2020/1/21', '2020/1/10 9:20:21');
    
INSERT INTO calls (employee_id, customer_id, start_time, end_time, call_outcome_id) VALUES (1, 4, '2020/1/11 9:0:15', '2020/1/11 9:12:22', 2);
INSERT INTO calls (employee_id, customer_id, start_time, end_time, call_outcome_id) VALUES (1, 2, '2020/1/11 9:14:50', '2020/1/11 9:20:1', 2);
INSERT INTO calls (employee_id, customer_id, start_time, end_time, call_outcome_id) VALUES (2, 3, '2020/1/11 9:2:20', '2020/1/11 9:18:5', 3);
INSERT INTO calls (employee_id, customer_id, start_time, end_time, call_outcome_id) VALUES (1, 1, '2020/1/11 9:24:15', '2020/1/11 9:25:5', 3);
INSERT INTO calls (employee_id, customer_id, start_time, end_time, call_outcome_id) VALUES (1, 3, '2020/1/11 9:26:23', '2020/1/11 9:33:45', 2);
INSERT INTO calls (employee_id, customer_id, start_time, end_time, call_outcome_id) VALUES (1, 2, '2020/1/11 9:40:31', '2020/1/11 9:42:32', 2);
INSERT INTO calls (employee_id, customer_id, start_time, end_time, call_outcome_id) VALUES (2, 4, '2020/1/11 9:41:17', '2020/1/11 9:45:21', 2);
INSERT INTO calls (employee_id, customer_id, start_time, end_time, call_outcome_id) VALUES (1, 1, '2020/1/11 9:42:32', '2020/1/11 9:46:53', 3);
INSERT INTO calls (employee_id, customer_id, start_time, end_time, call_outcome_id) VALUES (2,1, '2020/1/11 9:46:0', '2020/1/11 9:48:2', 2);
INSERT INTO calls (employee_id, customer_id, start_time, end_time, call_outcome_id) VALUES (2, 2, '2020/1/11 9:50:12', '2020/1/11 9:55:35', 2);

/* using order by to sort tables in desc*/
SELECT employee.first_name, employee.last_name, calls.start_time, calls.end_time, call_outcome.outcome_text
FROM employee
INNER JOIN calls ON calls.employee_id = employee.id
INNER JOIN call_outcome ON calls.call_outcome_id = call_outcome.id
ORDER BY calls.start_time DESC;

/* Using aggregate fucntions*/
 -- use COUNT to count number of rows without NULLs
SELECT *
FROM country
INNER JOIN city ON city.country_id =  country.id;
    
SELECT COUNT(*) AS number_of_rows
FROM country
INNER JOIN city ON city.country_id =  country.id;

/* Query to return aggregated values of all countries*/
SELECT 
	country.country_name_eng,
	SUM(CASE WHEN calls.id IS NOT NULL THEN 1 ELSE 0 END) AS calls,
	AVG(ISNULL(DATEDIFF(SECOND, calls.start_time, calls.end_time),0)) AS avg_difference
FROM country 
LEFT JOIN city ON city.country_id = country.id
LEFT JOIN customer ON city.id = customer.city_id
LEFT JOIN calls ON calls.customer_id = customer.id
GROUP BY 
	country.id,
	country.country_name_eng
ORDER BY calls DESC, country.id ASC;

-- the query returns a call summary for countries having average call duration > average call duration of all calls
SELECT 
    country.country_name_eng,
    SUM(CASE WHEN calls.id IS NOT NULL THEN 1 ELSE 0 END) AS calls,
    AVG(ISNULL(DATEDIFF(SECOND, calls.start_time, calls.end_time),0)) AS avg_difference
FROM country 
-- Used a left join to include also countries without any call
LEFT JOIN city ON city.country_id = country.id
LEFT JOIN customer ON city.id = customer.city_id
LEFT JOIN calls ON calls.customer_id = customer.id
GROUP BY 
    country.id,
    country.country_name_eng
-- filter out only countries having an average call duration > average call duration of all calls
HAVING AVG(ISNULL(DATEDIFF(SECOND, calls.start_time, calls.end_time),0)) > (SELECT AVG(DATEDIFF(SECOND, calls.start_time, calls.end_time)) FROM calls)
ORDER BY calls DESC, country.id ASC;
 
-- SET OPERATIONS : UNION, contains sub-queries
-- list all customers with exactly 3 calls
SELECT customer.*
FROM customer 
WHERE id IN (
    select customer.id
    from customer
    inner join calls on customer.id = calls.customer_id
    group by customer.id
    having count(*) = 3
)
    
UNION
    
-- list all customers from Berlin
select customer.*
from customer
inner join city on customer.city_id = city.id
where city.city_name = 'Berlin';
    
-- UNION ALL
-- list all customers with exactly 3 calls
select customer.*
from customer 
where id in (
    select customer.id
    from customer
    inner join calls on customer.id = calls.customer_id
    group by customer.id
    having count(*) = 3
)
    
UNION ALL
    
-- list all customers from Berlin
select customer.*
from customer
inner join city on customer.city_id = city.id
where city.city_name = 'Berlin';

-- INTERSECT
-- list all customers with exactly 3 calls
SELECT customer.*
FROM customer 
WHERE id IN (
    select customer.id
    from customer
    inner join calls on customer.id = calls.customer_id
    group by customer.id
    having count(*) = 3
)
INTERSECT
-- list all customers from Berlin
select customer.*
from customer
inner join city on customer.city_id = city.id 
where city.city_name = 'Berlin';

-- A EXCEPT B
-- list all customers with exactly 3 calls
select customer.*
from customer 
where id in (
    select customer.id
    from customer
    inner join calls on customer.id = calls.customer_id
    group by customer.id
    having count(*) = 3
)
    
EXCEPT
    
-- list all customers from Berlin
select customer.*
from customer
inner join city on customer.city_id = city.id
where city.city_name = 'Berlin';

-- creating user defined functions
DELIMITER //
CREATE FUNCTION east_or_west (lon DECIMAL)
  RETURNS CHAR 
  BEGIN
	DECLARE return_value CHAR;
	
	IF (lon > 0.00) THEN SET return_value = 'east';
	ELSE SET return_value = 'west';
	end if;
	SET return_value = 'same'; 
	RETURN return_value;
  END//
DELIMITER ;

-- SQL trigger to check before INSERT 
DROP TRIGGER IF EXISTS t_country_insert;
DELIMITER //
CREATE TRIGGER t_country_insert ON country INSTEAD OF INSERT
AS BEGIN
    DECLARE @country_name CHAR(128);
    DECLARE @country_name_eng CHAR(128);
    DECLARE @country_code  CHAR(8);
    SELECT @country_name = country_name, @country_name_eng = country_name_eng, @country_code = country_code FROM INSERTED;
    IF @country_name IS NULL SET @country_name = @country_name_eng;
    IF @country_name_eng IS NULL SET @country_name_eng = @country_name;
    INSERT INTO country (country_name, country_name_eng, country_code) VALUES (@country_name, @country_name_eng, @country_code);
END;
DELIMITER ;

-- DELETE trigger
DROP TRIGGER IF EXISTS t_country_delete;
DELIMITER //
CREATE TRIGGER t_country_delete ON country INSTEAD OF DELETE
AS BEGIN
    DECLARE @id INT;
    DECLARE @count INT;
    SELECT @id = id FROM DELETED;
    SELECT @count = COUNT(*) FROM city WHERE country_id = @id;
    IF @count = 0
        DELETE FROM country WHERE id = @id;
    ELSE
        THROW 51000, 'can not delete - country is referenced in other tables', 1;
END;
DELIMITER ;

-- DATEDIFF Function
-- return all call data with the duration of each call in seconds
SELECT 
    calls.*,
    DATEDIFF("SECOND", calls.start_time, calls.end_time) AS call_duration
FROM calls
ORDER BY
    calls.employee_id ASC,
    calls.start_time ASC;
-- SUM of call duration per each employee
SELECT 
    employee.id,
    employee.first_name,
    employee.last_name,
    SUM(DATEDIFF("SECOND", calls.start_time, calls.end_time)) AS call_duration_sum
FROM calls
INNER JOIN employee ON calls.employee_id = employee.id
GROUP BY
    employee.id,
    employee.first_name,
    employee.last_name
ORDER BY
    employee.id ASC;
-- calculating ratio
-- % of call duration per each employee compared to the duration of all his/her calls
SELECT 
    employee.id,
    employee.first_name,
    employee.last_name,
    calls.start_time, 
    calls.end_time,
    DATEDIFF("SECOND", calls.start_time, calls.end_time) AS call_duration,
    duration_sum.call_duration_sum,
    CAST( CAST(DATEDIFF("SECOND", calls.start_time, calls.end_time) AS DECIMAL(7,2)) / CAST(duration_sum.call_duration_sum AS DECIMAL(7,2)) AS DECIMAL(4,4)) AS call_percentage
FROM calls
INNER JOIN employee ON calls.employee_id = employee.id
INNER JOIN (
    SELECT 
        employee.id,
        SUM(DATEDIFF("SECOND", calls.start_time, calls.end_time)) AS call_duration_sum
 FROM calls
    INNER JOIN employee ON calls.employee_id = employee.id
    GROUP BY
        employee.id
) AS duration_sum ON employee.id = duration_sum.id
ORDER BY
    employee.id ASC,
    calls.start_time ASC;  

-- the difference between AVG call duration per employee and AVG call duration
SELECT 
    single_employee.id,
    single_employee.first_name,
    single_employee.last_name,
    single_employee.call_duration_avg,
    single_employee.call_duration_avg - avg_all.call_duration_avg AS avg_difference
FROM
(
    SELECT 
        1 AS join_id,
        employee.id,
        employee.first_name,
        employee.last_name,
        AVG(DATEDIFF("SECOND", calls.start_time, calls.end_time)) AS call_duration_avg
    FROM calls
    INNER JOIN employee ON calls.employee_id = employee.id
    GROUP BY
        employee.id,
        employee.first_name,
        employee.last_name
) single_employee
    
INNER JOIN
    
(
    SELECT
        1 AS join_id,
        AVG(DATEDIFF("SECOND", calls.start_time, calls.end_time)) AS call_duration_avg
    FROM calls
) avg_all ON avg_all.join_id = single_employee.join_id;

-- creating reporting categories using the Cartesian product
 
-- 1. Cartesian product without joins
SELECT
  employee.id AS employee_id,
  employee.first_name,
  employee.last_name,
  customer.id AS customer_id,
  customer.customer_name 
FROM employee, customer;
 
-- 2. Cartesian product using CROSS JOIN
SELECT
  employee.id AS employee_id,
  employee.first_name,
  employee.last_name,
  customer.id AS customer_id,
  customer.customer_name 
FROM employee
CROSS JOIN customer;

-- get report data
SELECT 
  employee.id AS employee_id, 
  customer.id AS customer_id,
  COUNT(calls.id) AS calls
FROM employee
INNER JOIN calls ON calls.employee_id = employee.id
INNER JOIN customer ON calls.customer_id = customer.id
GROUP BY 
  employee.id, 
  customer.id;
SELECT 
  report_categories.employee_id,
  report_categories.first_name,
  report_categories.last_name,
  report_categories.customer_id,
  report_categories.customer_name,
  report_data.calls
FROM
(
  -- report categories
  SELECT
    employee.id AS employee_id,
    employee.first_name,
    employee.last_name,
    customer.id AS customer_id,
    customer.customer_name 
  FROM employee
  CROSS JOIN customer
) report_categories
LEFT JOIN
 
(
  -- report data
  SELECT 
    employee.id AS employee_id, 
    customer.id AS customer_id,
    COUNT(calls.id) AS calls
  FROM employee
  INNER JOIN calls ON calls.employee_id = employee.id
  INNER JOIN customer ON calls.customer_id = customer.id
  GROUP BY 
    employee.id, 
    customer.id
) report_data ON report_categories.employee_id = report_data.employee_id AND report_categories.customer_id = report_data.customer_id;

-- Creating a date range for a SQL Server report
-- dates in range
-- declaring all DATE variables we'll use
DELIMITER //

DECLARE @dates1 DATE;
DECLARE @start_date DATE;
DECLARE @end_date DATE;
DECLARE @loop_date DATE;
    
-- declaring a table variable
DECLARE @dates TABLE (dates1 DATE);
   
-- setting the first and the last date in the month given by date
SET @dates1 = '2020/05/12';
SET @start_date = DATEFROMPARTS(YEAR(@dates1 ), MONTH(@dates1 ), '01');
SET @end_date = EOMONTH(@dates1);
    
-- check dates
SELECT 
    @dates1  AS cur_date,
    @start_date AS first_date,
    @end_date AS last_date;
 -- populating a table (variable) with all dates in a given month
SET @loop_date = @start_date;
WHILE @loop_date <= @end_date 
BEGIN
    INSERT INTO @dates(dates1) VALUES (@loop_date);
    SET @loop_date = DATEADD(DAY, 1, @loop_date);
END;
-- selecting report dates
SELECT * FROM @dates;
END;
DELIMITER;

-- Creating a datetime range in minutes
-- number of calls with predefined start time, end time and interval
DECLARE @start_time DATETIME;	-- starting from here
DECLARE @end_time DATETIME;		-- until the time is under this value
DECLARE @interval CHAR(3);		-- interval definition (e.g. day, minute etc.)
DECLARE @increment INT;			-- interval increment 
DECLARE @loop_time DATETIME;	-- variable used in the loop
DECLARE @times TABLE(start_time DATETIME, end_time DATETIME);
    
SET @start_time = '2020-01-11 09:00:00';
SET @end_time = '2020-01-11 10:00:00';
SET @interval = 'MI';
SET @increment = 10;
    
SET @loop_time = @start_time;
    
WHILE @loop_time < @end_time 
BEGIN 
    IF @interval = 'yy' SET @loop_time = DATEADD(yy, @increment, @loop_time);	-- year
    IF @interval = 'qq' SET @loop_time = DATEADD(qq, @increment, @loop_time);	-- quarter
    IF @interval = 'mm' SET @loop_time = DATEADD(mm, @increment, @loop_time);	-- month
    IF @interval = 'dy' SET @loop_time = DATEADD(dy, @increment, @loop_time);	-- day of year
    IF @interval = 'dd' SET @loop_time = DATEADD(dd, @increment, @loop_time);	-- day
    IF @interval = 'wk' SET @loop_time = DATEADD(wk, @increment, @loop_time);	-- week
    IF @interval = 'dw' SET @loop_time = DATEADD(dw, @increment, @loop_time);	-- weekday
    IF @interval = 'hh' SET @loop_time = DATEADD(hh, @increment, @loop_time);	-- hour
    IF @interval = 'mi' SET @loop_time = DATEADD(mi, @increment, @loop_time);	-- minute
    IF @interval = 'ss' SET @loop_time = DATEADD(ss, @increment, @loop_time);	-- second
    IF @interval = 'ms' SET @loop_time = DATEADD(ms, @increment, @loop_time);	-- millisecond
    IF @interval = 'mcs' SET @loop_time = DATEADD(mcs, @increment, @loop_time);	-- microsecond
    IF @interval = 'ns' SET @loop_time = DATEADD(ns, @increment, @loop_time);	-- nanosecond
 INSERT INTO @times(start_time, end_time) VALUES (@start_time, @loop_time);
    SET @start_time = @loop_time;
END;
    
SELECT 
    t.start_time,
    t.end_time,
    COUNT(call.id) AS calls
FROM @times t
LEFT JOIN call ON t.start_time < call.start_time AND call.start_time <= t.end_time
GROUP BY 
    t.start_time,
    t.end_time;   

-- PIVOT using SQL
-- select data we need
SELECT * FROM calls;
SELECT * FROM call_outcome;
SELECT * FROM customer;
SELECT * FROM city;
-- report categories
SELECT 
  c.id AS city_id,
  c.city_name,
  co.id AS call_outcome_id,
  co.outcome_text
FROM call_outcome co
CROSS JOIN city c
ORDER BY
  c.id ASC,
  co.id ASC;
-- report data, joining all 4 tables we need
SELECT 
  ci.id AS city_id,
  co.id AS call_outcome_id,
  DATEDIFF(SECOND, c.start_time, c.end_time) AS call_duration
FROM call c
INNER JOIN call_outcome co ON c.call_outcome_id = co.id
INNER JOIN customer cu ON c.customer_id = cu.id
INNER JOIN city ci ON cu.city_id = ci.id;

-- report categories & data (without pivot)
SELECT
  rc.city_id,
  rc.city_name,
  rc.call_outcome_id,
  rc.outcome_text,
  rd.call_duration
FROM
(
  SELECT 
    c.id AS city_id,
    c.city_name,
    co.id AS call_outcome_id,
    co.outcome_text
  FROM call_outcome co
  CROSS JOIN city c
) rc
 
LEFT JOIN
(
  SELECT 
    ci.id AS city_id,
    co.id AS call_outcome_id,
    DATEDIFF(SECOND, c.start_time, c.end_time) AS call_duration
  FROM call c
  INNER JOIN call_outcome co ON c.call_outcome_id = co.id
  INNER JOIN customer cu ON c.customer_id = cu.id
  INNER JOIN city ci ON cu.city_id = ci.id
) rd ON rc.city_id = rd.city_id AND rc.call_outcome_id = rd.call_outcome_id
 
ORDER BY
  rc.city_id,
  rc.call_outcome_id;

-- report (including static PIVOT)
SELECT * FROM   
(
  SELECT
    -- rc.city_id,
    rc.city_name,
    -- rc.call_outcome_id,
    rc.outcome_text,
    rd.call_duration
  FROM
  (
    SELECT 
      c.id AS city_id,
      c.city_name,
      co.id AS call_outcome_id,
      co.outcome_text
    FROM call_outcome co
    CROSS JOIN city c
  ) rc
  
  LEFT JOIN
 
  (
    SELECT 
      ci.id AS city_id,
      co.id AS call_outcome_id,
      DATEDIFF(SECOND, c.start_time, c.end_time) AS call_duration
    FROM call c
    INNER JOIN call_outcome co ON c.call_outcome_id = co.id
    INNER JOIN customer cu ON c.customer_id = cu.id
    INNER JOIN city ci ON cu.city_id = ci.id
  ) rd ON rc.city_id = rd.city_id AND rc.call_outcome_id = rd.call_outcome_id
) report_data 
PIVOT(
    COUNT(call_duration) 
    FOR outcome_text IN (
        [call started], 
        [finished - successfully], 
        [finished - unsuccessfully])
) AS pivot_table;
 
 -- Loops : print all dates between the two given dates
DECLARE @date_start DATE;
DECLARE @date_end DATE;
DECLARE @loop_date DATE;
 
SET @date_start = '2020/11/11';
SET @date_end = '2020/12/12';
 
SET @loop_date = @date_start;
 
WHILE @loop_date <= @date_end
BEGIN
   PRINT @loop_date;
   SET @loop_date = DATEADD(DAY, 1, @loop_date);
END;

