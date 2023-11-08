SET SQL_SAFE_UPDATES =0;

# Day 3
-- 1) Show customer number, customer name, state and credit limit from customers table for below conditions.
-- Sort the results by highest to lowest values of creditLimit.
-- State should not contain null values
-- credit limit should be between 50000 and 100000

SELECT customerNumber,customerName,state,creditLimit 
FROM customers
WHERE state IS NOT NULL AND creditLimit between 50000 and 100000
ORDER BY creditLimit DESC;

-- 2) Show the unique productline values containing the word cars at the end from products table.
SELECT DISTINCT productLine FROM products
WHERE productLine LIKE "%Cars%";

# Day 4
-- 1) Show the orderNumber, status and comments from orders table for shipped status only. If some comments are having null values then show them as "-".

SELECT orderNumber,status, CASE WHEN comments IS NULL THEN '-' ELSE comments END AS comments
FROM orders
WHERE status = 'Shipped';

SELECT orderNumber,status, COALESCE(comments, '-') as comments
FROM orders
WHERE status = 'Shipped';

-- 2) Select employee number, first name, job title and job title abbreviation from employees table based on following conditions.
-- If job title is one among the below conditions, then job title abbreviation column should show below forms.
-- President then “P”
-- Sales Manager / Sale Manager then “SM”
-- Sales Rep then “SR”
-- Containing VP word then “VP”

SELECT employeeNumber, firstName, jobTitle,
CASE
	WHEN jobTitle = 'President' THEN 'P'
	WHEN jobTitle LIKE 'Sales Manager%' OR jobTitle LIKE 'Sale Manager%' THEN 'SM'
	WHEN jobTitle = 'Sales Rep' THEN 'SR'
	WHEN jobTitle LIKE '%VP%' THEN 'VP'
END AS job_title_abbr
FROM employees;

# Day 5:
-- 1) For every year, find the minimum amount value from payments table.

SELECT * FROM payments;

SELECT YEAR(paymentDate) AS pay_year, MIN(amount) AS min_amount
FROM payments
GROUP BY YEAR(paymentDate)
ORDER BY pay_year;

-- 2) For every year and every quarter, find the unique customers and total orders from orders table. Make sure to show the quarter as Q1, Q2 etc

SELECT * FROM orders;

SELECT YEAR(orderDate) AS order_year,
CASE
	WHEN QUARTER(orderDate) = 1 THEN 'Q1'
	WHEN QUARTER(orderDate) = 2 THEN 'Q2'
	WHEN QUARTER(orderDate) = 3 THEN 'Q3'
	WHEN QUARTER(orderDate) = 4 THEN 'Q4'
END AS order_quarter,
COUNT(DISTINCT customerNumber) AS unique_customers,
COUNT(*) AS total_orders
FROM orders
GROUP BY order_year, order_quarter
ORDER BY order_year, order_quarter;

-- 3) Show the formatted amount in thousands unit (e.g. 500K, 465K etc.) for every month (e.g. Jan, Feb etc.) 
-- with filter on total amount as 500000 to 1000000. Sort the output by total amount in descending mode. [Refer. Payments Table]

SELECT * FROM payments;
SELECT MONTH(paymentDate) AS month, CONCAT(FORMAT(amount / 1000, 0), 'K') AS formatted_amount
FROM payments
HAVING formatted_amount BETWEEN '500K' AND '1000K'
ORDER BY formatted_amount DESC;

SELECT DATE_FORMAT(paymentDate, '%m') Month, SUM(amount) AS TotalAmount
FROM payments
GROUP BY Month
HAVING TotalAmount BETWEEN 500000 AND 1000000
ORDER BY TotalAmount DESC;

SELECT DATE_FORMAT(paymentDate, '%b') AS Month,
CONCAT(FORMAT(SUM(amount / 1000), 'K')) AS Formatted_amount
FROM payments
WHERE amount BETWEEN 500000 AND 1000000
GROUP BY Month
ORDER BY SUM(amount) DESC;

# Day 6:
-- 1) Create a journey table with following fields and constraints.
-- Bus_ID (No null values)
-- Bus_Name (No null values)
-- Source_Station (No null values)
-- Destination (No null values)
-- Email (must not contain any duplicates)

CREATE TABLE journey (
	Bus_Id INT NOT NULL,
	Bus_Name VARCHAR(255) NOT NULL,
	Source_Station VARCHAR(255) NOT NULL,
	Destination VARCHAR(255) NOT NULL,
	Email VARCHAR(255) UNIQUE
);

-- 2) Create vendor table with following fields and constraints.
-- Vendor_ID (Should not contain any duplicates and should not be null)
-- Name (No null values)
-- Email (must not contain any duplicates)
-- Country (If no data is available then it should be shown as “N/A”)

CREATE TABLE vendor (
	Vendor_Id INT PRIMARY KEY,
	Name VARCHAR(255) NOT NULL,
	Email VARCHAR(255) NOT NULL UNIQUE,
	Country VARCHAR(255) DEFAULT "N/A"
);

-- 3) Create movies table with following fields and constraints.
-- Movie_ID (Should not contain any duplicates and should not be null)
-- Name (No null values)
-- Release_Year (If no data is available then it should be shown as “-”)
-- Cast (No null values)
-- Gender (Either Male/Female)
-- No_of_shows (Must be a positive number)

CREATE TABLE movies (
    Movie_ID INT NOT NULL UNIQUE,
    Name VARCHAR(255) NOT NULL,
    Release_Year VARCHAR(4) DEFAULT '-',
    Cast VARCHAR(255) NOT NULL,
    Gender ENUM('Male', 'Female'),
    No_of_shows INT CHECK (No_of_shows > 0)
);

-- 4) Create the following tables. Use auto increment wherever applicable

-- a. Product
-- product_id - primary key
-- product_name - cannot be null and only unique values are allowed
-- description
-- supplier_id - foreign key of supplier table

CREATE TABLE Product (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    product_name VARCHAR(255) NOT NULL UNIQUE,
    description TEXT,
    supplier_id INT,
    FOREIGN KEY (supplier_id) REFERENCES Supplier(supplier_id)
);

-- b. Suppliers
-- supplier_id - primary key
-- supplier_name
-- location

CREATE TABLE Suppliers (
    supplier_id INT PRIMARY KEY,
    supplier_name VARCHAR(255),
    location VARCHAR(255)
);

-- c. Stock
-- id - primary key
-- product_id - foreign key of product table
-- balance_stock

CREATE TABLE Stock (
    id INT AUTO_INCREMENT PRIMARY KEY,
    product_id INT,
    balance_stock INT,
    FOREIGN KEY (product_id) REFERENCES Product(product_id)
);

# Day 7
-- 1) Show employee number, Sales Person (combination of first and last names of employees), 
-- unique customers for each employee number and sort the data by highest to lowest unique customers.
-- Tables: Employees, Customers

SELECT 
	e.employeeNumber, 
	CONCAT(e.firstName, ' ', e.lastName) AS Sales_Person,
	COUNT(DISTINCT c.customerNumber) AS unique_customers
FROM Employees AS e
LEFT JOIN Customers AS c ON e.employeeNumber = c.salesRepEmployeeNumber
GROUP BY e.employeeNumber, Sales_Person
ORDER BY unique_customers DESC;

-- 2) Show total quantities, total quantities in stock, left over quantities for each product and each customer. 
-- Sort the data by customer number.
-- Tables: Customers, Orders, Orderdetails, Products

SELECT 
    c.customerNumber,
    c.customerName,
    p.productCode,
    p.productName,
    SUM(od.quantityOrdered) AS OrderedQuantity,
    p.quantityInStock AS TotalInventry,
    (p.quantityInStock - SUM(od.quantityOrdered)) AS LeftQuantity
FROM Customers c
JOIN Orders o ON c.customerNumber = o.customerNumber
JOIN Orderdetails od ON o.orderNumber = od.orderNumber
JOIN Products p ON od.productCode = p.productCode
GROUP BY c.customerNumber, p.productCode
ORDER BY c.customerNumber;

-- 3) Create below tables and fields. (You can add the data as per your wish)
-- Laptop: (Laptop_Name)
-- Colours: (Colour_Name)
-- Perform cross join between the two tables and find number of rows.

CREATE TABLE Laptop (
Laptop_Name VARCHAR(50) PRIMARY KEY
);

CREATE TABLE Colours (
Colour_Name VARCHAR(20) PRIMARY KEY
);

INSERT INTO Laptop (Laptop_Name) VALUES ('HP'), ('DELL');

INSERT INTO Colours (Colour_Name) VALUES ('WHITE'), ('SILVER'), ('Black');
    
-- Find the number of rows
SELECT COUNT(*) AS No_laptp 
FROM Laptop
CROSS JOIN Colours;

-- Shows all columns
SELECT * FROM Laptop
CROSS JOIN Colours
ORDER BY Laptop_Name;

-- 4) Create table project with below fields.

-- EmployeeID
-- FullName
-- Gender
-- ManagerID
-- Add below data into it.

-- INSERT INTO Project VALUES(1, 'Pranaya', 'Male', 3);
-- INSERT INTO Project VALUES(2, 'Priyanka', 'Female', 1);
-- INSERT INTO Project VALUES(3, 'Preety', 'Female', NULL);
-- INSERT INTO Project VALUES(4, 'Anurag', 'Male', 1);
-- INSERT INTO Project VALUES(5, 'Sambit', 'Male', 1);
-- INSERT INTO Project VALUES(6, 'Rajesh', 'Male', 3);
-- INSERT INTO Project VALUES(7, 'Hina', 'Female', 3);
-- Find out the names of employees and their related managers.

CREATE TABLE Project (
EmployeeID INT PRIMARY KEY,
FullName VARCHAR(50),
Gender VARCHAR(10),
ManagerID INT
);

INSERT INTO Project (EmployeeID, FullName, Gender, ManagerID) VALUES
(1, 'Pranaya', 'Male', 3),
(2, 'Priyanka', 'Female', 1),
(3, 'Preety', 'Female', NULL),
(4, 'Anurag', 'Male', 1),
(5, 'Sambit', 'Male', 1),
(6, 'Rajesh', 'Male', 3),
(7, 'Hina', 'Female', 3);

SELECT * FROM Project;
-- Find out the names of employees and their related managers
SELECT 
	m.FullName AS ManagerName,
    e.FullName AS EmployeeName
FROM Project e
LEFT JOIN Project m ON e.ManagerID = m.EmployeeID
WHERE e.ManagerID IS NOT NULL
ORDER BY ManagerName;

# Day 8
-- Create table facility. Add the below fields into it.
-- Facility_ID
-- Name
-- State
-- Country

-- Create the facility table with fields
CREATE TABLE facility (
    Facility_ID INT,
    Name VARCHAR(50),
    State VARCHAR(50),
    Country VARCHAR(50)
);

-- i) Alter the table by adding the primary key and auto increment to Facility_ID column.

ALTER TABLE facility
ADD PRIMARY KEY (Facility_ID);

ALTER TABLE facility
MODIFY COLUMN Facility_ID INT AUTO_INCREMENT;

-- ii) Add a new column city after name with data type as varchar which should not accept any null values.

ALTER TABLE facility
ADD City VARCHAR(50) NOT NULL AFTER Name;

DESCRIBE facility;

# Day 9
-- Create table university with below fields.
-- ID
-- Name
-- Add the below data into it as it is.

-- INSERT INTO University
-- VALUES (1, "       Pune          University     "), 
-- (2, "  Mumbai          University     "),
-- (3, "     Delhi   University     "),
-- (4, "Madras University"),
-- (5, "Nagpur University");
-- Remove the spaces from everywhere and update the column like Pune University etc.

CREATE TABLE university (
ID INT,
Name VARCHAR(255)
);

INSERT INTO University VALUES (1, "       Pune          University     "), 
(2, "  Mumbai          University     "),
(3, "     Delhi   University     "),
(4, "Madras University"),
(5, "Nagpur University");

SELECT * FROM university;

-- Update the University table to remove extra spaces from the Name column
UPDATE University
SET Name = TRIM(BOTH ' ' FROM Name);

UPDATE University 
set name = REGEXP_REPLACE(Name, '[[:space:]]+', ' ');
SELECT * FROM university;

# Day 10
-- Create the view products status. Show year wise total products sold. Also find the percentage of total value for each year.

CREATE VIEW products_status AS
SELECT
    EXTRACT(YEAR FROM paymentDate) AS SalesYear,
    COUNT(customerNumber) AS ProductsSold,
    SUM(amount) AS TotalValue,
    MIN(amount) AS MinPayAmount,
    (SUM(amount) / (SELECT SUM(amount) FROM payments WHERE EXTRACT(YEAR FROM paymentDate) = EXTRACT(YEAR FROM paymentDate))) * 100 AS PercentageValue
FROM payments
GROUP BY SalesYear
ORDER BY SalesYear;

# Day 11
-- 1) Create a stored procedure GetCustomerLevel which takes input as customer number and gives the output as either Platinum, Gold or Silver as per below criteria.
-- Table: Customers
-- Platinum: creditLimit > 100000
-- Gold: creditLimit is between 25000 to 100000
-- Silver: creditLimit < 25000

DELIMITER //
CREATE PROCEDURE GetCustomerLevel(IN customerNumber INT, OUT CustomerLevel VARCHAR(20))
BEGIN
    DECLARE creditLimit DECIMAL(10, 2);
    
    -- Get the credit limit for the specified customer number
    SELECT creditLimit INTO CreditLimit FROM Customers WHERE customerNumber = CustomerNumber;
    
    -- Determine the customer level based on credit limit
    CASE
        WHEN creditLimit > 100000 THEN
            SET CustomerLevel = 'Platinum';
        WHEN creditLimit BETWEEN 25000 AND 100000 THEN
            SET CustomerLevel = 'Gold';
        WHEN creditLimit < 25000 THEN
            SET CustomerLevel = 'Silver';
        ELSE
            SET CustomerLevel = 'Unknown';
    END CASE;
END //
DELIMITER ;

# Day 12
-- 1) Calculate year wise, month name wise count of orders and year over year (YoY) percentage change. 
-- Format the YoY values in no decimals and show in % sign. Table: Orders

SELECT
    EXTRACT(YEAR FROM OrderDate) AS OrderYear,
    OrderDate, 'Month' AS MonthName,
    COUNT(*) AS OrderCount,
    LAG(COUNT(*)) OVER (PARTITION BY OrderDate, 'Month' ORDER BY EXTRACT(YEAR FROM OrderDate)) AS PreviousYearOrderCount,
    CONCAT(
        CASE
            WHEN COUNT(*) > 0 AND LAG(COUNT(*)) OVER (PARTITION BY OrderDate, 'Month' ORDER BY EXTRACT(YEAR FROM OrderDate)) > 0 THEN
                CONCAT(
                    ROUND(((COUNT(*) - LAG(COUNT(*)) OVER (PARTITION BY OrderDate, 'Month' ORDER BY EXTRACT(YEAR FROM OrderDate))) * 100.0) / LAG(COUNT(*)) OVER (PARTITION BY OrderDate, 'Month' ORDER BY EXTRACT(YEAR FROM OrderDate))),
                    '%'
                )
            ELSE '0%'
        END
    ) AS YoYPercentageChange
FROM Orders
GROUP BY OrderYear
ORDER BY OrderYear;

-- 2) Create the table emp_udf with below fields.
-- Emp_ID
-- Name
-- DOB
-- Add the data as shown in below query.
-- INSERT INTO Emp_UDF(Name, DOB)
-- VALUES ("Piyush", "1990-03-30"), ("Aman", "1992-08-15"), ("Meena", "1998-07-28"), ("Ketan", "2000-11-21"), ("Sanjay", "1995-05-21");
-- Create a user defined function calculate_age which returns the age in years and months (e.g. 30 years 5 months) by accepting DOB column as a parameter.

CREATE TABLE emp_udf (
    Emp_ID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(50),
    DOB DATE
);

INSERT INTO emp_udf(Name, DOB)
VALUES ("Piyush", "1990-03-30"),
("Aman", "1992-08-15"),
("Meena", "1998-07-28"),
("Ketan", "2000-11-21"),
("Sanjay", "1995-05-21");

DELIMITER //
CREATE FUNCTION calculate_age(dob DATE)
RETURNS VARCHAR(50)
BEGIN
    DECLARE years INT;
    DECLARE months INT;
    DECLARE age VARCHAR(50);

    SET years = TIMESTAMPDIFF(YEAR, dob, CURDATE());
    SET months = TIMESTAMPDIFF(MONTH, dob, CURDATE()) - years * 12;

    SET age = CONCAT(years, ' years ', months, ' months');
    
    RETURN age;
END //
DELIMITER ;

# Day 13
-- 1) Display the customer numbers and customer names from customers table who have not placed any orders using subquery
-- Table: Customers, Orders

SELECT CustomerNumber, CustomerName
FROM Customers
WHERE CustomerNumber NOT IN (
    SELECT CustomerNumber
    FROM Orders
);

-- 2) Write a full outer join between customers and orders using union and get the customer number, customer name, count of orders for every customer.
-- Table: Customers, Orders

SELECT c.CustomerNumber, c.CustomerName, COUNT(o.CustomerNumber) AS OrderCount
FROM Customers c
LEFT JOIN Orders o ON c.CustomerNumber = o.CustomerNumber
GROUP BY c.CustomerNumber, c.CustomerName

UNION

SELECT o.CustomerNumber, c.CustomerName, COUNT(o.CustomerNumber) AS OrderCount
FROM Orders o
RIGHT JOIN Customers c ON c.CustomerNumber = o.CustomerNumber
GROUP BY o.CustomerNumber, c.CustomerName;

-- 3) Show the second highest quantity ordered value for each order number.
-- Table: Orderdetails

WITH RankedOrderDetails AS (
    SELECT
        orderNumber,
        quantityOrdered,
        RANK() OVER (PARTITION BY OrderNumber ORDER BY quantityOrdered DESC) AS QuantityRank
    FROM Orderdetails
)

SELECT
    OrderNumber,
    MAX(quantityOrdered) AS SecondHighestQuantity
FROM RankedOrderDetails
WHERE QuantityRank = 2
GROUP BY OrderNumber;

-- 4) For each order number count the number of products and then find the min and max of the values among count of orders.
-- Table: Orderdetails

WITH OrderProductCounts AS (
    SELECT OrderNumber, COUNT(*) AS ProductCount
    FROM Orderdetails
    GROUP BY OrderNumber
)

SELECT
    MIN(ProductCount) AS MinProductCount,
    MAX(ProductCount) AS MaxProductCount
FROM OrderProductCounts;

-- 5) Find out how many product lines are there for which the buy price value is greater than the average of buy price value. 
-- Show the output as product line and its count.

SELECT ProductLine, COUNT(*) AS LineCount
FROM Products
WHERE BuyPrice > (SELECT AVG(BuyPrice) FROM Products)
GROUP BY ProductLine;

# Day 14
-- Create the table Emp_EH. Below are its fields.
-- EmpID (Primary Key)
-- EmpName
-- EmailAddress
-- Create a procedure to accept the values for the columns in Emp_EH. Handle the error using exception handling concept. 
-- Show the message as “Error occurred” in case of anything wrong.

CREATE TABLE Emp_EH (
    EmpID INT PRIMARY KEY,
    EmpName VARCHAR(50),
    EmailAddress VARCHAR(100)
);

DELIMITER //
DELIMITER $$

CREATE PROCEDURE InsertEmp_EH(
    IN p_EmpID INT,
    IN p_EmpName VARCHAR(50),
    IN p_EmailAddress VARCHAR(100)
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        SELECT 'Error occurred' AS Message;
    END;

    INSERT INTO Emp_EH (EmpID, EmpName, EmailAddress)
    VALUES (p_EmpID, p_EmpName, p_EmailAddress);

    SELECT 'Data inserted successfully' AS Message;
END $$

DELIMITER ;

# Day 15
-- Create the table Emp_BIT. Add below fields in it.
-- Name
-- Occupation
-- Working_date
-- Working_hours

-- Insert the data as shown in below query.
-- INSERT INTO Emp_BIT VALUES
-- ('Robin', 'Scientist', '2020-10-04', 12),  
-- ('Warner', 'Engineer', '2020-10-04', 10),  
-- ('Peter', 'Actor', '2020-10-04', 13),  
-- ('Marco', 'Doctor', '2020-10-04', 14),  
-- ('Brayden', 'Teacher', '2020-10-04', 12),  
-- ('Antonio', 'Business', '2020-10-04', 11);  
-- Create before insert trigger to make sure any new value of Working_hours, if it is negative, then it should be inserted as positive.

CREATE TABLE Emp_BIT (
    Name VARCHAR(50),
    Occupation VARCHAR(50),
    Working_date DATE,
    Working_hours INT
);

INSERT INTO Emp_BIT (Name, Occupation, Working_date, Working_hours) VALUES
('Robin', 'Scientist', '2020-10-04', 12),
('Warner', 'Engineer', '2020-10-04', 10),
('Peter', 'Actor', '2020-10-04', 13),
('Marco', 'Doctor', '2020-10-04', 14),
('Brayden', 'Teacher', '2020-10-04', 12),
('Antonio', 'Business', '2020-10-04', 11);

DELIMITER $$

CREATE TRIGGER Before_Insert_Emp_BIT
BEFORE INSERT ON Emp_BIT
FOR EACH ROW
BEGIN
    IF NEW.Working_hours < 0 THEN
        SET NEW.Working_hours = -NEW.Working_hours;
    END IF;
END;
$$

DELIMITER ;