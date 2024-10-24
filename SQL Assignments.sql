# Day3 ---> Que1
SELECT customerNumber, customerName, state, creditLimit
FROM Customers
WHERE state IS NOT NULL AND creditLimit BETWEEN 50000 AND 100000
ORDER BY creditLimit DESC;

# Day3 --->Que2
SELECT DISTINCT productLine
FROM products
WHERE productLine LIKE "%cars";


# Day4 --->Que1
SELECT orderNumber,status,comments,
IFNULL(comments,"-") AS Comments
FROM orders
WHERE status = "shipped" ;

# Day4 --->Que2
SELECT EmployeeNumber, FirstName,JobTitle,
CASE 
WHEN JobTitle = "President" THEN "P"
WHEN JobTitle LIKE "%Sales Manager%" OR JobTitle LIKE "%Sale Manager%" THEN "SM"
when JobTitle = "Sales Rep" THEN "SR"
WHEN JobTitle LIKE "VP%" THEN "VP"
END AS JobTitle_Abbr
FROM Employees
ORDER BY jobTitle;



# Day5 --->Que1
SELECT Year(PaymentDate) AS "Year", MIN(Amount) AS "Min Amount"
FROM Payments
GROUP BY Year
ORDER BY Year;

# Day5 --->Que2
SELECT 
Year(orderDate) AS "Year",
CONCAT("Q", Quarter(orderDate)) AS "Quarter",
COUNT(Distinct(customerNumber)) AS "Unique Customers",
Count(orderNumber) AS "Total Orders"
FROM Orders
GROUP BY Year, QUARTER(orderDate);

# Day5 --->Que3
SELECT 
LEFT(MONTHNAME(PaymentDate),3) AS "Month",
CONCAT(ROUND(SUM(Amount)/1000),"k") AS "Formated Amount"
FROM Payments
GROUP BY Month
HAVING SUM(Amount) BETWEEN 500000 AND 1000000
ORDER BY SUM(Amount) DESC;

# Day6 --->Que1
CREATE TABLE Journey(
Bus_ID INT NOT NULL,
Bus_Name VARCHAR(100) NOT NULL,
Source_Station VARCHAR(100) NOT NULL,
Destination VARCHAR(100) NOT NULL,
Email VARCHAR(100) UNIQUE);

# Day6 --->Que2
CREATE TABLE VENDER(
Vendor_ID INT PRIMARY KEY,
Name VARCHAR(100) NOT NULL,
Email VARCHAR(100) UNIQUE,
Country VARCHAR(100) DEFAULT "N/A");

# Day6 --->Que3
CREATE TABLE MOVIES(
Movie_ID INT PRIMARY KEY,
Name VARCHAR(100) NOT NULL,
Release_Year VARCHAR(4) DEFAULT "-",
Cast VARCHAR(100) NOT NULL,
Gender  ENUM("Male","Female"),
No_of_shows INT CHECK(No_of_shows>0)); 

# Day6 --->Que4(B)
CREATE TABLE Suppliers(
Supplier_ID INTEGER PRIMARY KEY AUTO_INCREMENT,
Supplier_Name VARCHAR(50),
Location VARCHAR(50));


# Day6 --->Que4(A)
CREATE Table Product(
Product_ID INT PRIMARY KEY AUTO_INCREMENT,
Product_Name VARCHAR(50) NOT NULL UNIQUE,
Description VARCHAR(100),
Supplier_ID INTEGER,
FOREIGN KEY (Supplier_ID) REFERENCES Suppliers(Supplier_ID));


# Day6 --->Que4(C)
CREATE TABLE Stock(
ID INTEGER PRIMARY KEY AUTO_INCREMENT,
Product_ID INTEGER,
Balance_Stock INTEGER,
FOREIGN KEY(Product_ID) REFERENCES Product(Product_ID));


# Day7 --->Que1
SELECT EmployeeNumber, 
CONCAT(FirstName," ",LastName) AS "Sales Person",
COUNT(DISTINCT(CustomerNumber)) AS "Unique Customers"
FROM Employees E INNER JOIN  Customers C
ON E.EmployeeNumber = C.SalesRepEmployeeNumber
GROUP BY EmployeeNumber
ORDER BY COUNT(DISTINCT(CustomerNumber))DESC;

# Day7 ---> Que2
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

# Day7 ---> Que3
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


# Day7 ---> Que4
CREATE TABLE Project
(
  EmployeeID INT PRIMARY KEY,
  FullName VARCHAR(50),
  Gender VARCHAR(50),
  ManagerID INT
);

-- Inserting the records
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


# Day8 
CREATE TABLE Facility(
Facility_ID INT,
Name VARCHAR(100),
State VARCHAR(100),
Country VARCHAR(100)
);

ALTER TABLE Facility MODIFY Facility_ID INT PRIMARY KEY AUTO_INCREMENT;
ALTER TABLE Facility ADD City VARCHAR(100) NOT NULL AFTER Name;
Describe Facility;

# Day9
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


# Day10
CREATE VIEW Products_Status AS
	SELECT 
		YEAR(o.orderDate) AS Year, 
        CONCAT(COUNT(productCode), " (", CONCAT(ROUND((COUNT(productCode)  / (SELECT COUNT(productCode) FROM Orderdetails))*100), "%"), ")") AS "Value"
    FROM Orders o INNER JOIN Orderdetails od USING(orderNumber)
    GROUP BY Year
    ORDER BY COUNT(productCode) DESC;

SELECT * FROM Products_Status;

# Day11 --->Que1
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

# Day11 --->Que2
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

# Day12 --->Que1
SELECT 
	YEAR(orderDate) AS "Year", 
    MONTHNAME(orderDate) AS "Month",
    COUNT(orderNumber) AS "Total Orders",
    CONCAT(ROUND(((COUNT(orderNumber) - LAG(COUNT(orderNumber),1) OVER()) / LAG(COUNT(orderNumber),1) OVER())*100), "%") AS "% YoY Change"
FROM Orders
GROUP BY Year, Month;


# Day12 --->Que2
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

# Day13 --->Que1
SELECT customerNumber, customerName FROM Customers
WHERE customerNumber NOT IN (SELECT customerNumber FROM Orders);

# Day13 --->Que2
SELECT c.customerNumber, c.customerName, COUNT(o.orderNumber) AS "Total Orders"
FROM Customers c LEFT JOIN Orders o USING(customerNumber)
GROUP BY c.customerNumber

UNION

SELECT c.customerNumber, c.customerName, COUNT(o.orderNumber) AS "Total Orders"
FROM Customers c RIGHT JOIN Orders o USING(customerNumber)
GROUP BY c.customerNumber;

# Day13 --->Que3
SELECT orderNumber, quantityOrdered 
FROM(SELECT orderNumber, quantityOrdered, DENSE_RANK() OVER(PARTITION BY orderNumber ORDER BY quantityOrdered DESC) AS "ranking"
			FROM Orderdetails
			ORDER BY orderNumber) AS Subh
WHERE ranking = 2;



# Day13 --->Que4
	SELECT MAX(Total), MIN(Total)
FROM(SELECT orderNumber, COUNT(productCode) AS Total
			FROM Orderdetails
			GROUP BY orderNumber) AS Subh;
            
  # Day13 --->Que5
  SELECT productLine, COUNT(productLine) AS Total
FROM ( SELECT productCode, productName, productLine, MSRP FROM Products
			  WHERE MSRP > (SELECT AVG(MSRP) FROM Products)
              ) AS Subh
GROUP BY productLine
ORDER BY Total DESC;


# Day14
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


# Day15
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



