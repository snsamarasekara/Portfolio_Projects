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
 

