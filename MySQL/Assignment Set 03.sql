SET SQL_SAFE_UPDATES =0;

-- Q1.

Order_status

Delimiter //
CREATE PROCEDURE Order_status (IN in_month INT, IN in_year INT )
BEGIN
SELECT orderNumber, orderDate ,status FROM orders 
WHERE in_month = MONTH(shippeddate) AND in_year = YEAR(shippeddate) ;
END //

CALL Order_status ( 5 , 2005);

-- Q2

CREATE TABLE cancellations(
id INT PRIMARY KEY AUTO_INCREMENT, 
customernumber INT, 
ordernumber INT,
comments VARCHAR(250)
);

DELIMITER // 
CREATE PROCEDURE cancel_order()
BEGIN  
   INSERT INTO cancellations (customerNumber,ordernumber, comments) 
   SELECT customerNumber,ordernumber, comments FROM orders WHERE status ='cancelled' ;

END//

CALL cancel_order();

-- Q3 a.

DELIMITER //
CREATE FUNCTION purchase_status(in_customerNumber INT)
RETURNS varchar(10)
READS SQL DATA
DETERMINISTIC
BEGIN
DECLARE Stat  VARCHAR(20);
DECLARE total FLOAT DEFAULT 0;
SET total = (SELECT SUM(amount) FROM payments WHERE in_customerNumber = customerNumber);
IF total<25000 THEN SET Stat = 'Silver' ;
ELSEIF total > 25000 AND amount <50000  THEN SET Stat = 'Gold' ;
ELSEIF total < 50000  THEN SET Stat ='Platinum';
END IF;
RETURN Stat;
END//

-- Q3b
DELIMITER // 
CREATE PROCEDURE cust_detail()
BEGIN  
Select cutomerNumber, customerName, if (creditLimit>50000,'Platinum',IF( 50000>creditLimit>25000,'Gold','Silver')) FROM customers;
END//



-- Q4
DELIMITER $$
CREATE TRIGGER trg_movies_update
AFTER DELETE ON movies
FOR EACH ROW
BEGIN
    UPDATE rentals
    SET movieid = id
    WHERE movieid = OLD.id ;
END;

DELIMITER $$
CREATE TRIGGER trg_movies_delete 
AFTER DELETE ON movies 
FOR EACH ROW 
BEGIN
    DELETE FROM  rentals
    WHERE movieid 
    NOT IN (SELECT DISTINCT id FROM movies);
END;

-- Q5
SELECT fname FROM employee ORDER BY salary DESC LIMIT 2, 1;

-- Q6
SELECT *, 
RANK () OVER (
ORDER BY salary DESC
) AS Rank_no 
FROM employee;