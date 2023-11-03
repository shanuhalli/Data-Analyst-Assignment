SET SQL_SAFE_UPDATES =0;
-- Using tables from ConsolidatedTables.

-- Q1. select all employees in department 10 whose salary is greater than 3000. [table: employee]

SELECT * FROM  employee WHERE deptno = 10 and salary > 3000;

-- Q2. The grading of students based on the marks they have obtained is done as follows:

-- a. How many students have graduated with first class?
SELECT COUNT(*) FROM students where marks between 50 and 80;

-- b. How many students have obtained distinction?
SELECT COUNT(*) FROM students where marks between 80 and 100;

-- Q3. Get a list of city names from station with even ID numbers only. Exclude duplicates from your answer.[table: station]
Select DISTINCT city from station where id % 2 = 0; 

-- Q4.
select (( select count(city) from station )-( select count(distinct city) from station )) as difference; 

-- Q5a.
SELECT DISTINCT city from station where lower(SUBSTR(city,1,1)) in ('a','e','i','o','u') order by city;

-- Q5b.
SELECT DISTINCT
    city
FROM
    station
WHERE
    LOWER(SUBSTR(city, 1, 1)) IN ('a' , 'e', 'i', 'o', 'u')
        AND LOWER(SUBSTR(city, - 1, 1)) IN ('a' , 'e', 'i', 'o', 'u')
ORDER BY city;

-- Q5c.
SELECT DISTINCT city FROM station WHERE LOWER(SUBSTR(city, 1, 1)) NOT IN ('a' , 'e', 'i', 'o', 'u') ORDER BY city; 

-- Q5d.
SELECT DISTINCT
    city
FROM
    station
WHERE
    LOWER(SUBSTR(city, 1, 1)) NOt IN ('a' , 'e', 'i', 'o', 'u')
        AND LOWER(SUBSTR(city, - 1, 1)) NOT IN ('a' , 'e', 'i', 'o', 'u')
ORDER BY city;

-- Q6.
SELECT * FROM emp WHERE salary > 2000 and hire_date >now() - INTERVAL 36 MONTH;

-- Q7.
Select deptno, SUM(salary) AS total_salary FROM employee GROUP BY deptno;

-- Q8.
SELECT COUNT(name) as ans FROM city WHERE population > 100000; 

-- Q9.
SELECT SUM(population) as cal_pop FROM city WHERE district = 'California';

-- Q10. 
SELECT countrycode, district, AVG(population) AS AveragePopulation FROM city GROUP BY countrycode, district;

-- Q11. 
SELECT orderNumber, status, customerNumber, (select customerName from customers where customers.customerNumber = orders.customerNumber) as customerName, comments FROM orders WHERE status = 'Disputed';
