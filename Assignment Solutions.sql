# Day 3 - (1) 
SELECT customerNumber, customerName, state, creditLimit
FROM Customers
WHERE state IS NOT NULL AND creditLimit BETWEEN 50000 AND 100000
ORDER BY creditLimit DESC;

# Day 3 - (2) 
SELECT DISTINCT(productLine) FROM Products
WHERE productLine LIKE "%Cars";

SELECT DISTINCT(productLine) FROM Products
WHERE productLine regexp 'Cars$';

/*-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/

# Day 4 - (1)
SELECT orderNumber, comments ,status, IFNULL(comments, "-") AS Comments FROM Orders
WHERE status = "Shipped";

SELECT orderNumber, comments ,status, Coalesce(comments, "-") AS Comments FROM Orders
WHERE status = "Shipped";

SELECT orderNumber, comments ,status, 
case
when comments is null then '-'
else comments
end as Cm
from Orders
WHERE status = "Shipped";


# Day 4 - (2) 
SELECT employeeNumber, firstName, jobTitle,
CASE WHEN jobTitle = "President" THEN "P"
		  WHEN jobTitle LIKE "%Sales Manager%" OR jobTitle LIKE "%Sale Manager%" THEN "SM"
          WHEN jobTitle = "Sales Rep" THEN "SR"
          WHEN jobTitle LIKE "VP%" THEN "VP"
          END AS jobTitle_abbr
FROM Employees
ORDER BY jobTitle;

/*-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/

# Day 5 - (1)
SELECT YEAR(paymentDate) AS "Year", MIN(amount) AS "Min Amount" FROM Payments
GROUP BY Year
ORDER BY Year;

# Day 5 - (2)
SELECT 
			YEAR(orderDate) AS "Year", 
			CONCAT("Q", QUARTER(orderDate)) AS "Quarter", 
			COUNT(DISTINCT(customerNumber)) AS "Unique Customers",
			COUNT(orderNumber) AS "Total Orders"
FROM Orders
GROUP BY Year, QUARTER(orderDate);

# Day 5 - (3)
SELECT 
	MonthName(PaymentDate) AS "Month", 
    CONCAT(ROUND(SUM(amount)/1000),"K") AS "formatted amount"
FROM Payments 
GROUP BY Month
HAVING SUM(amount) BETWEEN 500000 AND 1000000
ORDER BY SUM(amount) DESC;

/*-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/

# Day 6 - (1)
CREATE TABLE Journey(
Bus_ID INT NOT NULL,
Bus_Name VARCHAR(100) NOT NULL,
Source_Station VARCHAR(100) NOT NULL,
Destination VARCHAR(100) NOT NULL,
Email VARCHAR(100) UNIQUE
);


# Day 6 - (2)
CREATE TABLE Vendor(
Vendor_ID INT PRIMARY KEY,
Name VARCHAR(100) NOT NULL,
Email VARCHAR(100) UNIQUE,
Country VARCHAR(100) DEFAULT "N/A"
);


# Day  6 - (3)
CREATE TABLE Movies(
Movie_ID INT PRIMARY KEY,
Name VARCHAR(100) NOT NULL,
Release_Year VARCHAR(4) DEFAULT "-" ,
Cast VARCHAR(100) NOT NULL,
Gender ENUM ("Male", "Female"),
No_of_shows INT CHECK(No_of_shows > 0)
);


# Day 6 - (4)
CREATE TABLE suppliers (
supplier_id INTEGER PRIMARY KEY AUTO_INCREMENT,
supplier_name VARCHAR(30),
location VARCHAR(50)
);

CREATE TABLE product (
product_id INTEGER PRIMARY KEY AUTO_INCREMENT,
product_name VARCHAR(50) NOT NULL UNIQUE,
description VARCHAR(150),
supplier_id INTEGER, 
FOREIGN KEY(supplier_id) REFERENCES suppliers(supplier_id)
);

CREATE TABLE stock (
id INTEGER PRIMARY KEY AUTO_INCREMENT,
product_id INTEGER,
balance_stock  INTEGER,
FOREIGN KEY(product_id) REFERENCES product(product_id)
);

/*-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/

# Day 7 - (1)
SELECT 
	employeeNumber, 
    CONCAT(firstName, " ", lastName) AS "Sales Person", 
    COUNT(DISTINCT(customerNumber)) AS "Unique Customers"
FROM Employees e INNER JOIN Customers c
ON e.employeeNumber = c.salesRepEmployeeNumber
GROUP BY employeeNumber
ORDER BY COUNT(DISTINCT(customerNumber)) DESC;

# Day 7 - (2)
SELECT 
	c.customerNumber, 
    c.customerName, 
    p.productCode, 
    p.productName, 
    SUM(od.quantityOrdered) AS "Ordered Qty", 
    SUM(p.quantityInStock) AS "Total Inventory",
    SUM(p.quantityInStock) - SUM(od.quantityOrdered) AS "Left Qty"
FROM Customers c INNER JOIN Orders o USING (customerNumber)
INNER JOIN Orderdetails od USING (orderNumber)
INNER JOIN Products p USING (productCode)
GROUP BY c.customerNumber, 
    c.customerName, 
    p.productCode, 
    p.productName
ORDER BY c.customerNumber;

# Day 7 - (3)
CREATE TABLE Laptop(
Laptop_Name VARCHAR(100)
);

CREATE TABLE Colours(
Colour_Name VARCHAR(100)
);

INSERT INTO Laptop
VALUES ("HP"), ("Dell");

INSERT INTO Colours
VALUES("White"),("Silver"),("Black");

SELECT * FROM Laptop CROSS JOIN Colours ORDER BY Laptop_Name;


# Day 7 - (4)
CREATE TABLE Project
(
  EmployeeID INT PRIMARY KEY,
  FullName VARCHAR(50),
  Gender VARCHAR(50),
  ManagerID INT
);

-- Insert the following records
INSERT INTO Project VALUES(1, 'Pranaya', 'Male', 3);
INSERT INTO Project VALUES(2, 'Priyanka', 'Female', 1);
INSERT INTO Project VALUES(3, 'Preety', 'Female', NULL);
INSERT INTO Project VALUES(4, 'Anurag', 'Male', 1);
INSERT INTO Project VALUES(5, 'Sambit', 'Male', 1);
INSERT INTO Project VALUES(6, 'Rajesh', 'Male', 3);
INSERT INTO Project VALUES(7, 'Hina', 'Female', 3);

SELECT T1.FullName AS "Manager Name", T2.FullName AS "Emp Name" 
FROM Project T1 INNER JOIN Project T2
ON T1.EmployeeID = T2.ManagerID
ORDER BY T2.ManagerID;

/*-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/

# Day 8
CREATE TABLE Facility(
Facility_ID INT,
Name VARCHAR(100),
State VARCHAR(100),
Country VARCHAR(100)
);

ALTER TABLE Facility MODIFY Facility_ID INT PRIMARY KEY AUTO_INCREMENT;
ALTER TABLE Facility ADD City VARCHAR(100) NOT NULL AFTER Name;
DESCRIBE Facility;

/*-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/

# Day 9
CREATE TABLE University(
ID INT PRIMARY KEY,
Name VARCHAR(100)
);

INSERT INTO University
VALUES (1, "       Pune          University     "), 
			  (2, "  Mumbai          University     "),
              (3, "     Delhi   University     "),
              (4, "Madras University"),
              (5, "Nagpur University");

UPDATE University
SET Name = CONCAT(REPLACE(REPLACE(Name, " ", ""), "University",""), " ", "University")
WHERE ID IN (1,2,3);

/*-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/

# Day 10
CREATE VIEW Products_Status AS
	SELECT 
		YEAR(o.orderDate) AS Year, 
        CONCAT(COUNT(productCode), " (", CONCAT(ROUND((COUNT(productCode)  / (SELECT COUNT(productCode) FROM Orderdetails))*100), "%"), ")") AS "Value"
    FROM Orders o INNER JOIN Orderdetails od USING(orderNumber)
    GROUP BY Year
    ORDER BY COUNT(productCode) DESC;

SELECT * FROM Products_Status;

/*-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/

# Day 11 - (1)
DELIMITER //
CREATE PROCEDURE GetCustomerLevel( IN  pCustomerNumber INT,  OUT pCustomerLevel  VARCHAR(20))
BEGIN
    DECLARE credit DECIMAL DEFAULT 0;

    SELECT creditLimit INTO credit
    FROM customers
    WHERE customerNumber = pCustomerNumber;

    IF credit > 100000 THEN
        SET pCustomerLevel = 'Platinum';
        
    ELSEIF credit BETWEEN 25000 AND 100000 THEN
        SET pCustomerLevel = 'Gold';
        
    ELSE
        SET pCustomerLevel = 'Silver';
        
    END IF;
    
END //

CALL GetCustomerLevel(447, @abc); 
SELECT @abc As Customer_Type;


# Day 11 - (2)
DELIMITER //
CREATE PROCEDURE Get_country_payments (IN p_year YEAR, IN p_country VARCHAR(100))
BEGIN

	SELECT 
		YEAR(paymentDate) AS Year, 
        country, 
        CONCAT(ROUND(SUM(amount)/1000), "K") AS "Total Amount"
    FROM Customers INNER JOIN Payments USING (customerNumber)
    WHERE YEAR(paymentDate) =  p_year AND country = p_country
    GROUP BY Year, country;

END //

CALL Get_country_payments(2003, "France");

/*-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/

# Day 12 - (1)
SELECT 
	YEAR(orderDate) AS "Year", 
    MONTHNAME(orderDate) AS "Month",
    COUNT(orderNumber) AS "Total Orders",
    CONCAT(ROUND(((COUNT(orderNumber) - LAG(COUNT(orderNumber),1) OVER()) / LAG(COUNT(orderNumber),1) OVER())*100), "%") AS "% YoY Change"
FROM Orders
GROUP BY Year, Month;

# Day 12 - (2)
CREATE TABLE Emp_UDF(
Emp_ID INT PRIMARY KEY AUTO_INCREMENT,
Name VARCHAR(100),
DOB DATE
);

INSERT INTO Emp_UDF(Name, DOB)
VALUES ("Piyush", "1990-03-30"), ("Aman", "1992-08-15"), ("Meena", "1998-07-28"), ("Ketan", "2000-11-21"), ("Sanjay", "1995-05-21");

DELIMITER //
CREATE FUNCTION Calculate_Age(p_date DATE)
RETURNS VARCHAR(100)
DETERMINISTIC
BEGIN
	
		RETURN CONCAT(TIMESTAMPDIFF(YEAR, p_date, NOW()), " years ", TIMESTAMPDIFF(MONTH, p_date, NOW())%12, " months");

END //

SELECT *, Calculate_Age(DOB) AS "Age" FROM Emp_UDF;

/*-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/

# Day 13 - (1)
SELECT customerNumber, customerName FROM Customers
WHERE customerNumber NOT IN (SELECT customerNumber FROM Orders);


# Day 13 - (2)
SELECT c.customerNumber, c.customerName, COUNT(o.orderNumber) AS "Total Orders"
FROM Customers c LEFT JOIN Orders o USING(customerNumber)
GROUP BY c.customerNumber

UNION

SELECT c.customerNumber, c.customerName, COUNT(o.orderNumber) AS "Total Orders"
FROM Customers c RIGHT JOIN Orders o USING(customerNumber)
GROUP BY c.customerNumber;


# Day 13 - (3)
SELECT orderNumber, quantityOrdered 
FROM(SELECT orderNumber, quantityOrdered, DENSE_RANK() OVER(PARTITION BY orderNumber ORDER BY quantityOrdered DESC) AS "ranking"
			FROM Orderdetails
			ORDER BY orderNumber) AS Shubham
WHERE ranking = 2;

with Shubham as
(SELECT orderNumber, quantityOrdered, DENSE_RANK() OVER(PARTITION BY orderNumber ORDER BY quantityOrdered DESC) AS ranking
			FROM Orderdetails
			ORDER BY orderNumber
)
Select 	orderNumber, quantityOrdered
from Shubham
where Ranking = 2;											
                                                    
# Day 13 - (4)
SELECT MAX(Total), MIN(Total)
FROM(SELECT orderNumber, COUNT(productCode) AS Total
			FROM Orderdetails
			GROUP BY orderNumber) AS Shubham;
            
            
# Day 13 - (5)
SELECT productLine, COUNT(productLine) AS Total
FROM ( SELECT productCode, productName, productLine, MSRP FROM Products
			  WHERE MSRP > (SELECT AVG(MSRP) FROM Products)
              ) AS Shubham
GROUP BY productLine
ORDER BY Total DESC;

/*-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/

# Day 14
CREATE TABLE Employee 
(
     EmpID INT PRIMARY KEY,
     EmpName VARCHAR(50),
     EmailAddress VARCHAR(50)    
);

DELIMITER //
CREATE PROCEDURE InsertEmployeeDetails
(
     InputEmpID INTEGER,
     InputEmpName VARCHAR(50),
     InputEmailAddress VARCHAR(50)    
)

BEGIN 
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SELECT 'Error occured';
	INSERT INTO Employee (EmpID, EmpName, EmailAddress)
	VALUES (InputEmpID, InputEmpName, InputEmailAddress);    
 
 SELECT * FROM Employee;
 
END // 


CALL InsertEmployeeDetails (1,'Anvesh','anvesh@gmail.com');
CALL InsertEmployeeDetails (1,'Roy','Roy@gmail.com');

/*-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/

# Day 15
CREATE TABLE Emp_BIT(  
    name VARCHAR(45) NOT NULL,    
    occupation VARCHAR(35) NOT NULL,    
    working_date DATE,  
    working_hours INT
);  

INSERT INTO Emp_BIT VALUES    
('Robin', 'Scientist', '2020-10-04', 12),  
('Warner', 'Engineer', '2020-10-04', 10),  
('Peter', 'Actor', '2020-10-04', 13),  
('Marco', 'Doctor', '2020-10-04', 14),  
('Brayden', 'Teacher', '2020-10-04', 12),  
('Antonio', 'Business', '2020-10-04', 11);  

SELECT * FROM Emp_BIT;

DELIMITER &&
CREATE TRIGGER before_insert_empworkinghours   
BEFORE INSERT ON Emp_BIT FOR EACH ROW  
BEGIN  
IF NEW.working_hours < 0 THEN SET NEW.working_hours = - (NEW.working_hours);  
END IF;  
END &&


INSERT INTO Emp_BIT VALUES    
('Markus', 'Farmer', '2020-10-08', 14);  

INSERT INTO Emp_BIT VALUES    
('Alexander', 'Actor', '2020-10-12', -13);  

SELECT * FROM Emp_BIT;

/*-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/












          