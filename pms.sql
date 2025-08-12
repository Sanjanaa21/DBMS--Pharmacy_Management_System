SET FOREIGN_KEY_CHECKS = 0;

--Drop tables
DROP TABLE IF EXISTS Notification;
DROP TABLE IF EXISTS Ordered_Drugs;
DROP TABLE IF EXISTS Ordered_Table;
DROP TABLE IF EXISTS Prescription;
DROP TABLE IF EXISTS Prescribed_Drugs;
DROP TABLE IF EXISTS Bill;
DROP TABLE IF EXISTS Customer_Order;
DROP TABLE IF EXISTS Insurance;
DROP TABLE IF EXISTS Employee;
DROP TABLE IF EXISTS Employee_Notification;
DROP TABLE IF EXISTS Medicine;
DROP TABLE IF EXISTS Disposed_Drugs;
DROP TABLE IF EXISTS Employee_Disposed_Drugs;
DROP TABLE IF EXISTS Customer;


CREATE TABLE Customer (
    SSN BIGINT PRIMARY KEY, 
    First_Name VARCHAR(255) NOT NULL, 
    Last_Name VARCHAR(255) NOT NULL, 
    Phone BIGINT UNIQUE NOT NULL, 
    Gender CHAR(1) NOT NULL, 
    Address VARCHAR(1000) NOT NULL, 
    Date_of_Birth DATE NOT NULL, 
    Insurance_ID BIGINT UNIQUE NOT NULL
);
SHOW TABLES;
/* Create Insurance table*/
CREATE TABLE Insurance (
    Insurance_ID BIGINT(10) PRIMARY KEY, 
    Company_Name VARCHAR(255) NOT NULL, 
    Start_Date DATE NOT NULL, 
    End_Date DATE NOT NULL, 
    Co_Insurance INT(4) NOT NULL
) ENGINE=InnoDB;

/* Create Employee table*/
CREATE TABLE Employee (
    ID INT(5) PRIMARY KEY, 
    SSN BIGINT(10) UNIQUE NOT NULL, 
    License BIGINT(10) UNIQUE, 
    First_Name VARCHAR(255) NOT NULL, 
    Last_Name VARCHAR(255) NOT NULL, 
    Start_Date DATE NOT NULL, 
    End_Date DATE, 
    Role VARCHAR(255) NOT NULL, 
    Salary INT(4) NOT NULL, 
    Phone_Number BIGINT(10) NOT NULL, 
    Date_of_Birth DATE NOT NULL
) ENGINE=InnoDB;

/*Create Medicine table*/
CREATE TABLE Medicine (
    Drug_Name VARCHAR(255) NOT NULL, 
    Batch_Number BIGINT(10) NOT NULL, 
    Medicine_Type VARCHAR(255) NOT NULL, 
    Manufacturer VARCHAR(255) NOT NULL, 
    Stock_Quantity BIGINT(10) NOT NULL, 
    Expiry_Date DATE NOT NULL, 
    Price DECIMAL(10,2) NOT NULL,
    PRIMARY KEY (Drug_Name, Batch_Number)
) ENGINE=InnoDB;

/*Create Prescription table*/
CREATE TABLE Prescription (
    Prescription_ID BIGINT(10) PRIMARY KEY, 
    SSN BIGINT(10) NOT NULL, 
    Doctor_ID BIGINT(10) NOT NULL, 
    Prescribed_Date DATE NOT NULL,
    FOREIGN KEY (SSN) REFERENCES Customer (SSN)
) ENGINE=InnoDB;

/*Create Prescribed Drugs table*/
CREATE TABLE Prescribed_Drugs (
    Prescription_ID BIGINT(10) NOT NULL, 
    Drug_Name VARCHAR(255) NOT NULL, 
    Prescribed_Quantity BIGINT(10) NOT NULL, 
    Refill_Limit BIGINT(10) NOT NULL,
    PRIMARY KEY (Prescription_ID, Drug_Name),
    FOREIGN KEY (Prescription_ID) REFERENCES Prescription (Prescription_ID)
) ENGINE=InnoDB;

/*Create Order table*/
CREATE TABLE Order_Table (
    Order_ID BIGINT(10) PRIMARY KEY, 
    Prescription_ID BIGINT(10) NOT NULL, 
    Employee_ID INT(5) NOT NULL, 
    Order_Date DATE NOT NULL,
    FOREIGN KEY (Employee_ID) REFERENCES Employee (ID),
    FOREIGN KEY (Prescription_ID) REFERENCES Prescription (Prescription_ID)
) ENGINE=InnoDB;

/* Create Ordered Drugs table*/
CREATE TABLE Ordered_Drugs (
    Order_ID BIGINT(10) NOT NULL, 
    Drug_Name VARCHAR(255) NOT NULL, 
    Batch_Number BIGINT(10) NOT NULL, 
    Ordered_Quantity BIGINT(10) NOT NULL, 
    Price DECIMAL(10,2) NOT NULL,
    PRIMARY KEY (Order_ID, Drug_Name, Batch_Number),
    FOREIGN KEY (Order_ID) REFERENCES Order_Table (Order_ID) ON DELETE CASCADE,
    FOREIGN KEY (Drug_Name, Batch_Number) REFERENCES Medicine (Drug_Name, Batch_Number)
) ENGINE=InnoDB;

/* Create Bill table*/
CREATE TABLE Bill (
    Order_ID BIGINT(10) NOT NULL, 
    Customer_SSN BIGINT(10) NOT NULL, 
    Total_Amount DECIMAL(10,2) NOT NULL, 
    Customer_Payment DECIMAL(10,2) NOT NULL, 
    Insurance_Payment DECIMAL(10,2) NOT NULL,
    PRIMARY KEY (Order_ID, Customer_SSN),
    FOREIGN KEY (Order_ID) REFERENCES Order_Table (Order_ID),
    FOREIGN KEY (Customer_SSN) REFERENCES Customer (SSN)
) ENGINE=InnoDB;

/*Create Disposed Drugs table*/
CREATE TABLE Disposed_Drugs (
    Drug_Name VARCHAR(255) NOT NULL, 
    Batch_Number BIGINT(10) NOT NULL, 
    Quantity BIGINT(10) NOT NULL, 
    Company VARCHAR(255) NOT NULL,
    PRIMARY KEY (Drug_Name, Batch_Number),
    FOREIGN KEY (Drug_Name, Batch_Number) REFERENCES Medicine (Drug_Name, Batch_Number)
) ENGINE=InnoDB;

/*Create Notification table*/
CREATE TABLE Notification (
    ID BIGINT(10) PRIMARY KEY, 
    Message VARCHAR(255) NOT NULL, 
    Type VARCHAR(255) NOT NULL
) ENGINE=InnoDB;

/* Create Employee_Notification table*/
CREATE TABLE Employee_Notification (
    Employee_ID INT(5) NOT NULL, 
    Notification_ID BIGINT(10) NOT NULL, 
    PRIMARY KEY (Employee_ID, Notification_ID),
    FOREIGN KEY (Employee_ID) REFERENCES Employee (ID) ON DELETE CASCADE,
    FOREIGN KEY (Notification_ID) REFERENCES Notification (ID) ON DELETE CASCADE
) ENGINE=InnoDB;

/* Create Employee_Disposed_Drugs table*/
CREATE TABLE Employee_Disposed_Drugs (
    Employee_ID INT(5) NOT NULL, 
    Drug_Name VARCHAR(255) NOT NULL, 
    Batch_Number BIGINT(10) NOT NULL, 
    Disposal_Date DATE NOT NULL, 
    PRIMARY KEY (Employee_ID, Drug_Name, Batch_Number),
    FOREIGN KEY (Employee_ID) REFERENCES Employee (ID),
    FOREIGN KEY (Drug_Name, Batch_Number) REFERENCES Disposed_Drugs (Drug_Name, Batch_Number)
) ENGINE=InnoDB;

SET FOREIGN_KEY_CHECKS = 1;

-- Insert into Customer
INSERT INTO Customer (SSN, First_Name, Last_Name, Phone, Gender, Address, Date_of_Birth, Insurance_ID) VALUES
(123456789, 'John', 'Doe', 9876543210, 'M', '123 Main St', '1990-01-01', 987654321),
(234567890, 'Jane', 'Smith', 8765432109, 'F', '456 Oak St', '1985-05-15', 876543210),
(345678901, 'Alice', 'Johnson', 7654321098, 'F', '789 Pine St', '1992-09-20', 765432109),
(456789012, 'Bob', 'Williams', 6543210987, 'M', '101 Elm St', '1988-03-12', 654321098),
(567890123, 'Charlie', 'Brown', 5432109876, 'M', '202 Maple St', '1995-07-08', 543210987);

-- Insert into Prescription
INSERT INTO Prescription (Prescription_ID, SSN, Doctor_ID, Prescribed_Date) VALUES
(1, 123456789, 101, '2024-01-07'),
(2, 234567890, 102, '2024-01-08'),
(3, 345678901, 103, '2024-01-09'),
(4, 456789012, 104, '2024-01-10'),
(5, 567890123, 105, '2024-01-11');

-- Insert into Prescribed_Drugs
INSERT INTO Prescribed_Drugs (Prescription_ID, Drug_Name, Prescribed_Quantity, Refill_Limit) VALUES
(1, 'Aspirin', 30, 5),
(2, 'Ibuprofen', 20, 3),
(3, 'Paracetamol', 25, 4),
(4, 'Amoxicillin', 15, 2),
(5, 'Lisinopril', 10, 1);

-- Insert into Employee
INSERT INTO Employee (ID, SSN, License, First_Name, Last_Name, Start_Date, End_Date, Role, Salary, Phone_Number, Date_of_Birth) VALUES
(201, 123456789, 987654, 'Dr. Smith', 'Dentist', '2010-01-01', NULL, 'Dentist', 80000, 1112223333, '1975-05-10'),
(202, 234567890, 876543, 'Dr. Johnson', 'Cardiologist', '2012-01-01', NULL, 'Cardiologist', 90000, 2223334444, '1980-02-15'),
(203, 345678901, 765432, 'Dr. Williams', 'Pediatrician', '2015-01-01', NULL, 'Pediatrician', 85000, 3334445555, '1985-09-20'),
(204, 456789012, 654321, 'Dr. Davis', 'Surgeon', '2018-01-01', NULL, 'Surgeon', 100000, 4445556666, '1978-03-12'),
(205, 567890123, 543210, 'Dr. Miller', 'Oncologist', '2020-01-01', NULL, 'Oncologist', 95000, 5556667777, '1987-07-08');

-- Insert into Order_Table
INSERT INTO Order_Table (Order_ID, Prescription_ID, Employee_ID, Order_Date) VALUES
(101, 1, 201, '2024-01-12'),
(102, 2, 202, '2024-01-13'),
(103, 3, 203, '2024-01-14'),
(104, 4, 204, '2024-01-15'),
(105, 5, 205, '2024-01-16');

-- Insert into Insurance
INSERT INTO Insurance (Insurance_ID, Company_Name, Start_Date, End_Date, Co_Insurance) VALUES
(501, 'XYZ Insurance', '2020-01-01', '2025-01-01', 20),
(502, 'ABC Insurance', '2019-01-01', '2024-01-01', 15),
(503, 'PQR Insurance', '2022-01-01', '2027-01-01', 25),
(504, 'LMN Insurance', '2018-01-01', '2023-01-01', 18),
(505, 'DEF Insurance', '2023-01-01', '2028-01-01', 22);

-- Insert into Bill
INSERT INTO Bill (Order_ID, Customer_SSN, Total_Amount, Customer_Payment, Insurance_Payment) VALUES
(101, 123456789, 50.99, 40.99, 10.00),
(102, 234567890, 67.97, 57.97, 10.00),
(103, 345678901, 56.94, 46.94, 10.00),
(104, 456789012, 72.92, 62.92, 10.00),
(105, 567890123, 38.97, 28.97, 10.00);

-- Insert into Disposed_Drugs
INSERT INTO Disposed_Drugs (Drug_Name, Batch_Number, Quantity, Company) VALUES
('Aspirin', 101, 5, 'ABC Disposals'),
('Ibuprofen', 102, 3, 'XYZ Disposals'),
('Paracetamol', 103, 4, 'PQR Disposals'),
('Amoxicillin', 104, 2, 'LMN Disposals'),
('Lisinopril', 105, 1, 'DEF Disposals');

-- Insert into Notification
INSERT INTO Notification (ID, Message, Type) VALUES
(1, 'Your prescription is ready for pickup.', 'Info'),
(2, 'Appointment reminder: Dr. Smith on 2024-01-20.', 'Reminder'),
(3, 'Important: Insurance update required.', 'Alert'),
(4, 'New job opportunity available.', 'Job'),
(5, 'Payment received for Order #101.', 'Payment');

-- Insert into Employee_Notification
INSERT INTO Employee_Notification (Employee_ID, Notification_ID) VALUES
(201, 1),
(202, 2),
(203, 3),
(204, 4),
(205, 5);

-- Insert into Employee_Disposed_Drugs
INSERT INTO Employee_Disposed_Drugs (Employee_ID, Drug_Name, Batch_Number, Disposal_Date) VALUES
(201, 'Aspirin', 101, '2024-01-05'),
(202, 'Ibuprofen', 102, '2024-01-06'),
(203, 'Paracetamol', 103, '2024-01-07'),
(204, 'Amoxicillin', 104, '2024-01-08'),
(205, 'Lisinopril', 105, '2024-01-09');

-- Insert into Medicine
INSERT INTO Medicine (Drug_Name, Batch_Number, Medicine_Type, Manufacturer, Stock_Quantity, Expiry_Date, Price) VALUES
('Aspirin', 101, 'Tablet', 'ABC Pharmaceuticals', 100, '2025-01-01', 5.99),
('Ibuprofen', 102, 'Tablet', 'XYZ Pharma', 150, '2025-02-01', 7.49),
('Paracetamol', 103, 'Tablet', 'PQR Pharmaceuticals', 120, '2024-12-01', 3.99),
('Amoxicillin', 104, 'Capsule', 'LMN Drugs', 80, '2025-03-01', 12.99),
('Lisinopril', 105, 'Tablet', 'DEF Medicines', 60, '2025-04-01', 8.99);

-- Insert into Ordered_Drugs
INSERT INTO Ordered_Drugs (Order_ID, Drug_Name, Batch_Number, Ordered_Quantity, Price) VALUES
(101, 'Aspirin', 101, 10, 5.99),
(102, 'Ibuprofen', 102, 8, 7.49),
(103, 'Paracetamol', 103, 12, 3.99),
(104, 'Amoxicillin', 104, 5, 12.99),
(105, 'Lisinopril', 105, 3, 8.99);

SHOW TABLES
-- check number of  tables 
SELECT COUNT(*)
FROM information_schema.tables
WHERE table_schema = 'pharmacy';

-- 1. Retrieve the names and roles of all employees
SELECT First_Name, Last_Name, Role
FROM Employee;

-- 2. Find the total fee and billing status of Alice Johnson
SELECT Customer_SSN, Total_Amount, Customer_Payment, Insurance_Payment
FROM Bill
WHERE Customer_SSN = (SELECT SSN FROM Customer WHERE First_Name = 'Alice' AND Last_Name = 'Johnson');

-- 3. Identify the medicines disposed of by 'OMG Manufacturer' (no match in your inserts, adjust name as needed)
SELECT Drug_Name, Batch_Number, Quantity
FROM Disposed_Drugs
WHERE Company = 'OMG Manufacturer';

-- 4. Find the disposal details, including company, for Paracetamol
SELECT Drug_Name, Quantity, Company
FROM Disposed_Drugs
WHERE Drug_Name = 'Paracetamol';

-- 5. Find the prescription details for Ibuprofen
SELECT pd.Prescription_ID, p.Prescribed_Date, p.Doctor_ID
FROM Prescribed_Drugs pd
JOIN Prescription p ON pd.Prescription_ID = p.Prescription_ID
WHERE pd.Drug_Name = 'Ibuprofen';

-- 6. List employees who have disposed of medicines along with details
SELECT e.ID AS Employee_ID,
       e.First_Name,
       e.Last_Name,
       edd.Drug_Name,
       edd.Batch_Number,
       edd.Disposal_Date
FROM Employee e
JOIN Employee_Disposed_Drugs edd ON e.ID = edd.Employee_ID;

-- 7. Orders containing medicines with a batch number not disposed
SELECT DISTINCT o.Order_ID, od.Drug_Name
FROM Order_Table o
JOIN Ordered_Drugs od ON o.Order_ID = od.Order_ID
LEFT JOIN Disposed_Drugs dd ON od.Batch_Number = dd.Batch_Number
WHERE dd.Batch_Number IS NULL;

-- 8. Retrieve all orders along with ordered drugs, quantity, and total price
SELECT o.Order_ID, od.Drug_Name, od.Ordered_Quantity, (od.Price * od.Ordered_Quantity) AS Total_Price
FROM Order_Table o
JOIN Ordered_Drugs od ON o.Order_ID = od.Order_ID;

-- 9. Total amount paid by each customer along with their names
SELECT c.SSN AS Customer_SSN,
       CONCAT(c.First_Name, ' ', c.Last_Name) AS Customer_Name,
       SUM(b.Customer_Payment) AS Total_Payment
FROM Customer c
JOIN Bill b ON c.SSN = b.Customer_SSN
GROUP BY c.SSN, Customer_Name;

-- 10. Prescription drugs with highest refill limit
SELECT Drug_Name, MAX(Refill_Limit) AS Highest_Refill_Limit
FROM Prescribed_Drugs
GROUP BY Drug_Name;

-- 11. Show names of customers with total billed and amount paid
SELECT c.SSN AS Customer_SSN,
       CONCAT(c.First_Name, ' ', c.Last_Name) AS Customer_Name,
       SUM(b.Total_Amount) AS Total_Billed,
       SUM(b.Customer_Payment) AS Total_Paid
FROM Customer c
JOIN Bill b ON c.SSN = b.Customer_SSN
GROUP BY c.SSN, Customer_Name;

-- 12. Total quantity of each drug ordered across all orders
SELECT m.Drug_Name,
       SUM(od.Ordered_Quantity) AS Total_Ordered_Quantity
FROM Medicine m
JOIN Ordered_Drugs od ON m.Drug_Name = od.Drug_Name
GROUP BY m.Drug_Name;

-- 13. Total price of all medicines
SELECT SUM(Price * Stock_Quantity) AS Total_Price
FROM Medicine;

-- 14. Average salary of employees who have prepared orders
SELECT AVG(e.Salary) AS Average_Salary
FROM Employee e
WHERE e.ID IN (SELECT DISTINCT o.Employee_ID FROM Order_Table o);

-- 15. Names of customers who have prescriptions
SELECT c.SSN AS Customer_SSN, CONCAT(c.First_Name, ' ', c.Last_Name) AS Customer_Name
FROM Customer c
WHERE EXISTS (SELECT 1 FROM Prescription p WHERE p.SSN = c.SSN);

-- 16. Customers who have insurance with the highest co-insurance value
SELECT i.Insurance_ID, i.Company_Name, i.Start_Date, i.End_Date, i.Co_Insurance
FROM Insurance i
WHERE i.Co_Insurance = (SELECT MAX(Co_Insurance) FROM Insurance);

-- 17. Prescription drugs with highest prescribed quantity
SELECT pd.Prescription_ID, pd.Drug_Name, pd.Prescribed_Quantity, pd.Refill_Limit
FROM Prescribed_Drugs pd
WHERE pd.Prescribed_Quantity = (SELECT MAX(Prescribed_Quantity) FROM Prescribed_Drugs);

