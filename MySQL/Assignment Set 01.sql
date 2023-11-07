SET SQL_SAFE_UPDATES =0;

-- Q1. create a database called 'assignment' (Note please do the assignment tasks in this database)
CREATE DATABASE assignment;
USE assignment;

-- Q2. Create the tables from ConsolidatedTables.sql and enter the records as specified in it.
-- Run the ConsolidateTable Script. 

-- Q3. Create a table called countries with the following columns name, population, capital    
CREATE TABLE countries (
country VARCHAR (50),
population INT,
capital VARCHAR(50)
);

-- a. Insert the following data into the table
INSERT INTO countries VALUES ('China', 1382, 'Beijing'),
('India', 1326, 'Delhi'),
('United States', 324, 'Washington D.C.'),
('Indonesia', 260, 'Jakarta'),
('Brazil', 209, 'Brasilia'),
('Pakistan', 193, 'Islamabad'),
('Nigeria',	187, 'Abuja'),
('Bangladesh', 163, 'Dhaka'),
('Russia', 143,	'Moscow'),
('Mexico', 128,	'Mexico City'),
('Japan', 126,	'Tokyo'),
('Philippines',	102, 'Manila'),
('Ethiopia', 101, 'Addis Ababa'),
('Vietnam', 94,	'Hanoi'),
('Egypt', 93, 'Cairo'),
('Germany',	81, 'Berlin'),
('Iran', 80, 'Tehran'),
('Turkey', 79, 'Ankara'),
('Congo', 79, 'Kinshasa'),
('France', 64, 'Paris'),
('United Kingdom',	65, 'London'),
('Italy	',	60, 'Rome'),
('South Africa', 55,	'Pretoria'),
('Myanmar',	54, 'Naypyidaw');

-- b. Add a couple of countries of your choice
INSERT INTO countries VALUES ('Saudi Arabia', 4, 'Riyadh'),
('Iraq', 4, 'Bagdad'),
('Oman', 4, 'Muscat'),
('Nepal', 3, 'Kathamandu');

-- c. Change ‘Delhi' to ‘New Delhi'
UPDATE countries
SET capital = 'New Delhi'
WHERE capital = 'Delhi';

-- Q4 Rename the table countries to big_countries .
ALTER TABLE countries RENAME TO big_countries;

-- Q5. Create the following tables. Use auto increment wherever applicable

-- a. Suppliers
-- supplier_id - primary key
-- supplier_name
-- location
CREATE TABLE Suppliers(
supplier_id INT AUTO_INCREMENT,
supplier_name VARCHAR(100),
location VARCHAR(50),
PRIMARY KEY (supplier_id));

-- b. Product
-- product_id - primary key
-- product_name - cannot be null and only unique values are allowed
-- description
-- supplier_id - foreign key of supplier table
CREATE TABLE Product(
product_id INT AUTO_INCREMENT PRIMARY KEY,
product_name VARCHAR(200) NOT NULL UNIQUE,
description_ VARCHAR(200),
supplier_id INT,
FOREIGN KEY (supplier_id) REFERENCES Suppliers(supplier_id)
);

-- c. Stock
-- id - primary key
-- product_id - foreign key of product table
-- balance_stock
CREATE TABLE Stock (
id INT PRIMARY KEY AUTO_INCREMENT,
product_id INT,
balance_stock INT,
FOREIGN KEY (product_id) REFERENCES Product (product_id)
);

-- Q6. Enter some records into the three tables.
INSERT INTO Suppliers(supplier_name, location) VALUES ('TATA', 'PUNE'),
('MAHINDRA', 'NASHIK'),('MARUTI',	'GUDGAON');

INSERT INTO Product( Product_name, description_, Supplier_id) VALUES('TIAGO', 'HATCHBACK', 1),
('HARRIER', 'SUV', 1),('HEXA', 'MVP',	1),
('XUV300', 'HATCHBACK',	2),('XUV700',	'SUV',	2),
('MARAZZO',	'MVP',	2),('BALENO',	'HATCHBACK', 3),
('GYPSY', 'SUV', 3),('ERTIGA', 'MVP',3);

INSERT INTO Stock (product_id, balance_stock) VALUES (1,5),(2,	7),(6,	8),
(8,	23),(3,	5),(4,	54),
(7,	4),(8,	2),(5,	7);

-- Q7. Modify the supplier table to make supplier name unique and not null.
ALTER TABLE suppliers
MODIFY COLUMN supplier_name VARCHAR(150) UNIQUE NOT NULL;

-- Q8. Modify the emp table as follows
CREATE TABLE  emp  (
emp_no  INT(11) NOT NULL,
birth_date  DATE NOT NULL,
first_name  VARCHAR(15) NOT NULL,
last_name  VARCHAR(15) NOT NULL,
gender  ENUM('M','F') NOT NULL,
hire_date  DATE NOT NULL,
salary  FLOAT(8,2) DEFAULT 7850.00
) ;

INSERT INTO  emp  VALUES (10001,'1953-09-02','Georgi','Facello','M','2020-02-23',7850.00),(10002,'1964-06-02','Bezalel','Simmel','F','2020-02-23',1756.50),
(10003,'1959-12-03','Parto','Bamford','M','2020-02-23',7850.00),(10004,'1954-05-01','Chirstian','Koblick','M','2020-04-15',3475.00),
(10005,'1955-01-21','Kyoichi','Maliniak','M','2019-12-27',1756.50),(10006,'1953-04-20','Anneke','Preusig','F','2020-02-23',7850.00),
(10007,'1957-05-23','Tzvetan','Zielinski','F','2020-02-23',7850.00),(10008,'1958-02-19','Saniya','Kalloufi','M','1994-09-15',6759.00),
(10009,'1952-04-19','Sumant','Peac','F','2020-02-23',7850.00),(10010,'1963-06-01','Duangkaew','Piveteau','F','2019-12-27',1375.00),
(10011,'1953-11-07','Mary','Sluis','F','1990-01-22',6759.00),(10012,'1960-10-04','Patricio','Bridgland','M','1992-12-18',3475.00),
(10013,'1963-06-07','Eberhardt','Terkki','M','2020-02-23',7850.00),(10014,'1956-02-12','Berni','Genin','M','2020-02-23',1756.50),
(10015,'1959-08-19','Guoxiang','Nooteboom','M','2019-12-27',1375.00),(10016,'1961-05-02','Kazuhito','Cappelletti','M','1995-01-27',3475.00),
(10017,'1958-07-06','Cristinel','Bouloucos','F','1993-08-03',6759.00),(10018,'1954-06-19','Kazuhide','Peha','F','2020-02-23',7850.00),
(10019,'1953-01-23','Lillian','Haddadi','M','1999-04-30',7850.00),(10020,'1952-12-24','Mayuko','Warwick','M','1991-01-26',4300.00),
(10021,'1960-02-20','Ramzi','Erde','M','2020-02-23',7850.00),(10022,'1952-07-08','Shahaf','Famili','M','1995-08-22',7850.00),
(10023,'1953-09-29','Bojan','Montemayor','F','2020-02-23',1756.50),(10024,'1958-09-05','Suzette','Pettey','F','1997-05-19',3475.00),
(10025,'1958-10-31','Prasadram','Heyers','M','2019-12-27',1375.00),(10026,'1953-04-03','Yongqiao','Berztiss','M','1995-03-20',6759.00),
(10027,'1962-07-10','Divier','Reistad','F','2020-02-23',7850.00),(10028,'1963-11-26','Domenick','Tempesti','M','1991-10-22',3475.00),
(10029,'1956-12-13','Otmar','Herbst','M','2020-02-23',1756.50),(10030,'1958-07-14','Elvis','Demeyer','M','1994-02-17',4300.00),
(10031,'1959-01-27','Karsten','Joslin','M','1991-09-01',7850.00),(10032,'1960-08-09','Jeong','Reistad','F','1990-06-20',6759.00),
(10033,'1956-11-14','Arif','Merlo','M','2020-02-23',7850.00),(10034,'1962-12-29','Bader','Swan','M','2020-02-23',7850.00),
(10035,'1953-02-08','Alain','Chappelet','M','2019-12-27',1756.50),(10036,'1959-08-10','Adamantios','Portugali','M','1992-01-03',3475.00),
(10037,'1963-07-22','Pradeep','Makrucki','M','1990-12-05',7850.00),(10038,'1960-07-20','Huan','Lortz','M','2020-02-23',1756.50),
(10039,'1959-10-01','Alejandro','Brender','M','2020-02-23',7850.00),(10040,'1959-09-13','Weiyi','Meriste','F','1993-02-14',4300.00),
(10041,'1959-08-27','Uri','Lenart','F','2020-02-23',1756.50),(10042,'1956-02-26','Magy','Stamatiou','F','1993-03-21',7850.00),
(10043,'1960-09-19','Yishay','Tzvieli','M','1990-10-20',7850.00),(10044,'1961-09-21','Mingsen','Casley','F','1994-05-21',6759.00),
(10045,'1957-08-14','Moss','Shanbhogue','M','2019-12-27',1375.00),(10046,'1960-07-23','Lucien','Rosenbaum','M','1992-06-20',7850.00),
(10047,'1952-06-29','Zvonko','Nyanchama','M','2020-02-23',1756.50),(10048,'1963-07-11','Florian','Syrotiuk','M','2020-04-15',3475.00),
(10049,'1961-04-24','Basil','Tramer','F','1992-05-04',7850.00),(10050,'1958-05-21','Yinghua','Dredge','M','1990-12-25',4300.00),
(10051,'1953-07-28','Hidefumi','Caine','M','1992-10-15',7850.00),(10052,'1961-02-26','Heping','Nitsch','M','2020-04-15',3475.00),
(10053,'1954-09-13','Sanjiv','Zschoche','F','2020-02-23',1756.50),(10054,'1957-04-04','Mayumi','Schueller','M','1995-03-13',7850.00),
(10055,'1956-06-06','Georgy','Dredge','M','1992-04-27',4300.00),(10056,'1961-09-01','Brendon','Bernini','F','1990-02-01',6759.00),
(10057,'1954-05-30','Ebbe','Callaway','F','1992-01-15',7850.00),(10058,'1954-10-01','Berhard','McFarlin','M','2020-02-23',7850.00),
(10059,'1953-09-19','Alejandro','McAlpine','F','1991-06-26',6759.00),(10060,'1961-10-15','Breannda','Billingsley','M','2020-04-15',1375.00),
(10061,'1962-10-19','Tse','Herber','M','2020-02-23',7850.00),(10062,'1961-11-02','Anoosh','Peyn','M','1991-08-30',6759.00),
(10063,'1952-08-06','Gino','Leonhardt','F','2020-02-23',7850.00),(10064,'1959-04-07','Udi','Jansch','M','2020-04-15',3475.00),
(10065,'1963-04-14','Satosi','Awdeh','M','2019-12-27',1756.50),(10066,'1952-11-13','Kwee','Schusler','M','2020-02-23',7850.00),
(10067,'1953-01-07','Claudi','Stavenow','M','2020-02-23',7850.00),(10068,'1962-11-26','Charlene','Brattka','M','2020-04-15',1756.50),
(10069,'1960-09-06','Margareta','Bierman','F','2020-02-23',7850.00),(10070,'1955-08-20','Reuven','Garigliano','M','2019-12-27',1375.00),
(10071,'1958-01-21','Hisao','Lipner','M','2020-02-23',1756.50),(10072,'1952-05-15','Hironoby','Sidou','F','2020-04-15',3475.00),
(10073,'1954-02-23','Shir','McClurg','M','1991-12-01',7850.00),(10074,'1955-08-28','Mokhtar','Bernatsky','F','1990-08-13',6759.00),
(10075,'1960-03-09','Gao','Dolinsky','F','2019-12-27',1375.00),(10076,'1952-06-13','Erez','Ritzmann','F','2020-04-15',3475.00),
(10077,'1964-04-18','Mona','Azuma','M','1990-03-02',6759.00),(10078,'1959-12-25','Danel','Mondadori','F','2020-02-23',7850.00),
(10079,'1961-10-05','Kshitij','Gils','F','2020-02-23',7850.00),(10080,'1957-12-03','Premal','Baek','M','2020-04-15',1756.50),
(10081,'1960-12-17','Zhongwei','Rosen','M','2020-02-23',7850.00),(10082,'1963-09-09','Parviz','Lortz','M','1990-01-03',7850.00),
(10083,'1959-07-23','Vishv','Zockler','M','2020-02-23',1756.50),(10084,'1960-05-25','Tuval','Kalloufi','M','1995-12-15',3475.00),
(10085,'1962-11-07','Kenroku','Malabarba','M','1994-04-09',4300.00),(10086,'1962-11-19','Somnath','Foote','M','1990-02-16',6759.00),
(10087,'1959-07-23','Xinglin','Eugenio','F','2020-02-23',7850.00),(10088,'1954-02-25','Jungsoon','Syrzycki','F','2020-04-15',3475.00),
(10089,'1963-03-21','Sudharsan','Flasterstein','F','2020-02-23',1756.50),(10090,'1961-05-30','Kendra','Hofting','M','2019-12-27',1375.00),
(10091,'1955-10-04','Amabile','Gomatam','M','1992-11-18',7850.00),(10092,'1964-10-18','Valdiodio','Niizuma','F','2020-04-15',1756.50),
(10093,'1964-06-11','Sailaja','Desikan','M','1996-11-05',7850.00),(10094,'1957-05-25','Arumugam','Ossenbruggen','F','2020-02-23',7850.00),
(10095,'1965-01-03','Hilari','Morton','M','2019-12-27',1756.50),(10096,'1954-09-16','Jayson','Mandell','M','1990-01-14',3475.00),
(10097,'1952-02-27','Remzi','Waschkowski','M','1990-09-15',7850.00),(10098,'1961-09-23','Sreekrishna','Servieres','F','2020-02-23',1756.50),
(10099,'1956-05-25','Valter','Sullins','F','2020-02-23',7850.00),(10100,'1953-04-21','Hironobu','Haraldson','F','2020-04-15',1375.00);

-- a. Add a column called deptno
ALTER TABLE emp
ADD deptno INT;

-- b. Set the value of deptno in the following order
-- deptno = 20 where emp_id is divisible by 2
-- deptno = 30 where emp_id is divisible by 3
-- deptno = 40 where emp_id is divisible by 4
-- deptno = 50 where emp_id is divisible by 5
-- deptno = 10 for the remaining records.
UPDATE emp SET deptno = 20 WHERE emp_no % 2 = 0;
UPDATE emp SET deptno = 30 WHERE emp_no % 3 = 0;
UPDATE emp SET deptno = 40 WHERE emp_no % 4 = 0;
UPDATE emp SET deptno = 50 WHERE emp_no % 5 = 0;
UPDATE emp SET deptno = 10 WHERE emp_no IS NULL;

-- Q9. Create a unique index on the emp_id column.
CREATE UNIQUE INDEX unique_index ON emp (emp_no);

-- Q10. Create a view called emp_sal on the emp table by selecting the following fields in the order of highest salary to the lowest salary.
-- emp_no, first_name, last_name, salary
CREATE VIEW emp_sal AS
SELECT emp_no, first_name, last_name, salary
FROM emp
ORDER BY salary DESC;