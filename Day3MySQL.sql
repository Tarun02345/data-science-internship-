CREATE DATABASE employee;
USE employee;

CREATE TABLE employee_table (
    EmployeeID INT,
    Name VARCHAR(50),
    Gender CHAR(1),
    Department VARCHAR(50),
    Education VARCHAR(50),
    MonthOfJoining VARCHAR(50),
    Salary INT
);

INSERT INTO employee_table (EmployeeID, Name , Gender, Department, Education, MonthOfJoining, Salary) VALUES
(1001, 'Ajay', 'M', 'Engineering', 'Doctoral', 'January', 25),
(1002, 'Babloo', 'M', 'Engineering', 'UG', 'February', 23),
(1003, 'Chhavi', 'F', 'HR', 'PG', 'March', 15),
(1004, 'Dheeraj', 'M', 'HR', 'UG', 'January', 12),
(1005, 'Evina', 'F', 'Marketing', 'UG', 'March', 16),
(1006, 'Fredy', 'M', 'Sales', 'UG', 'December', 10),
(1007, 'Garima', 'F', 'Sales', 'PG', 'March', 10),
(1008, 'Hans', 'M', 'Admin', 'PG', 'November', 8),
(1009, 'Ivanka', 'F', 'Admin', 'Intermediate', 'April', 7),
(1010, 'Jai', 'M', 'Peon', 'High School', 'December', 4);

select * from employee_table;

SELECT Department
FROM employee_table
WHERE Education != 'UG'
GROUP BY Department
HAVING SUM(Salary) >= 20;

select Department , sum(salary) as totalsalary
from employee_table
group by Department
having totalsalary >=15
order by totalsalary desc;

#KEYS

CREATE TABLE CUSTOMERS (
CUSTOMERID INT PRIMARY KEY,
CUSTOMERNAME VARCHAR(50) NOT NULL
);
CREATE TABLE ORDERS(
ORDERID INT PRIMARY KEY,
ORDERNUMBER INT NOT NULL,
CUSTOMERID INT,
foreign key (CUSTOMERID) REFERENCES
CUSTOMERS(CUSTOMERID));
INSERT INTO CUSTOMERS(CUSTOMERID,CUSTOMERNAME)
VALUES (1,'JOHN'),(2,'JANE'),(3,'BOB');
INSERT INTO ORDERS (ORDERID,ORDERNUMBER,CUSTOMERID)
VALUES (1,101,1),(2,102,2),(3,103,3);
 
 SELECT * FROM CUSTOMERS;
 SELECT * FROM ORDERS;
 
 #union
 
-- Create the first table
CREATE TABLE Employees (
    EmpID INT,
    Name VARCHAR(100),
    Country VARCHAR(100)
);

-- Insert data into the first table
INSERT INTO Employees (EmpID, Name, Country) VALUES
(1, 'Shubham', 'India'),
(2, 'Aman', 'Australia'),
(3, 'Naveen', 'Sri Lanka'),
(4, 'Aditya', 'Austria'),
(5, 'Nihant', 'Spain');

-- Create the second table
CREATE TABLE Employees2 (
    EmpID INT,
    Name VARCHAR(100),
    Country VARCHAR(100)
);

-- Insert data into the second table
INSERT INTO Employees2 (EmpID, Name, Country) VALUES
(1, 'Tommy', 'England'),
(2, 'Allen', 'France'),
(3, 'Nancy', 'India'),
(4, 'Adi', 'Ireland'),
(5, 'Sandy', 'Spain');

SELECT Country FROM Employees
UNION 
SELECT Country FROM Employees2
ORDER BY Country;

SELECT Country FROM Employees
INTERSECT
SELECT Country FROM Employees2
ORDER BY Country;

#substraction operation 1st table - 2nd table
SELECT Country FROM Employees
EXCEPT 
SELECT Country FROM Employees2
ORDER BY Country;

# SQL JOINS
-- INNER JOIN 
SELECT COLUMN_NAME
FROM TABLE A 
INNER JOIN TABLE B 
ON TABLEA.COL_NAME=TABLEB.COL_NAME

-- Create the customer table
CREATE TABLE customer (
    Customer_id INT,
    First_name VARCHAR(100),
    Last_name VARCHAR(100),
    Address_id INT
);

-- Insert data into the customer table
INSERT INTO customer (Customer_id, First_name, Last_name, Address_id) VALUES
(1, 'Mary', 'Jonas', 5),
(3, 'Linda', 'Smith', 7),
(4, 'Madan', 'Mohan', 8),
(2, 'Bary', 'Williams', 6);

-- Create the payment table
CREATE TABLE payment (
    Customer_id INT,
    Amount INT,
    Mode VARCHAR(100),
    Date DATE
);

-- Insert data into the payment table
INSERT INTO payment (Customer_id, Amount, Mode, Date) VALUES
(1, 60, 'Cash', '2024-04-03'),
(2, 30, 'Credit card', '2024-04-05'),
(3, 110, 'Cash', '2024-04-15'),
(10, 70, 'Mobile Payment', '2024-04-20'),
(11, 80, 'Cash', '2024-04-29');


SELECT * 
FROM CUSTOMER AS c
INNER JOIN payment AS p 
ON c.CUSTOMER_ID = p.CUSTOMER_ID;

SELECT * 
FROM CUSTOMER AS c
RIGHT JOIN payment AS p 
ON c.CUSTOMER_ID = p.CUSTOMER_ID;

SELECT * 
FROM CUSTOMER AS c
LEFT JOIN payment AS p 
ON c.CUSTOMER_ID = p.CUSTOMER_ID;

-- WINDOW FUNCTION SYNTAX 


#SELEC TCOLUMN_NAMES,
-- ( [<PARTITION BY CLAUSE>]
-- [<ORDER BY CLAUSE>]
-- [<ROW OR RANGE CLAUSE>]


-- Create the table
CREATE TABLE example_table (
    new_id INT,
    new_cat VARCHAR(50)
);

-- Insert the data into the table
INSERT INTO example_table (new_id, new_cat) VALUES
(100, 'Agni'),
(200, 'Agni'),
(500, 'Dharti'),
(700, 'Dharti'),
(200, 'Vayu'),
(300, 'Vayu'),
(500, 'Vayu');

SELECT new_id,new_cat,
SUM(new_id) OVER (PARTITION BY new_cat ORDER BY new_id) AS "total",
AVG(new_id) OVER (PARTITION BY new_cat ORDER BY new_id) AS "Average",
COUNT(new_id) OVER (PARTITION BY new_cat ORDER BY new_id) AS "count",
MIN(new_id) OVER (PARTITION BY new_cat ORDER BY new_id) AS "min",
MAX(new_id) OVER (PARTITION BY new_cat ORDER BY new_id) AS "max"
FROM example_table;


SELECT 
    new_id, 
    new_cat,  -- Assuming you meant new_cat based on the previous table structure
    SUM(new_id) OVER (ORDER BY new_id ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS "Total",
    AVG(new_id) OVER (ORDER BY new_id ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS "Average",
    COUNT(new_id) OVER (ORDER BY new_id ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS "Count",
    MIN(new_id) OVER (ORDER BY new_id ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS "Min",
    MAX(new_id) OVER (ORDER BY new_id ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS "Max"
FROM 
    example_table;
    
    
SELECT new_id,
FIRST_VALUE(new_id) OVER( ORDER BY new_id) AS "FIRST_VALUE",
LAST_VALUE(new_id) OVER( ORDER BY new_id) AS "LAST_VALUE",
LEAD(new_id) OVER(ORDER BY new_id) AS "LEAD",
LAG(new_id) OVER(ORDER BY new_id) AS "LAG"
FROM example_table;



