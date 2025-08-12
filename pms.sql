--Drop table part
DROP TABLE Disposed_Medicine CASCADE CONSTRAINTS;
DROP TABLE Medicine_Details CASCADE CONSTRAINTS;
DROP TABLE Customer_Insurance CASCADE CONSTRAINTS;
DROP TABLE Employee_Details CASCADE CONSTRAINTS;
DROP TABLE Customer_Order CASCADE CONSTRAINTS;
DROP TABLE Ordered_Drugs CASCADE CONSTRAINTS;
DROP TABLE Customer_Bill CASCADE CONSTRAINTS;
DROP TABLE Prescription CASCADE CONSTRAINTS;
DROP TABLE Prescribed_Drugs CASCADE CONSTRAINTS;
DROP TABLE Customer CASCADE CONSTRAINTS;
DROP TABLE Employee_Disposed_Medicine CASCADE CONSTRAINTS;


--table creation part
CREATE TABLE Medicine_Details (
    Drug_Name           VARCHAR2(255) CONSTRAINT MD_pk PRIMARY KEY,
    Drug_ID             VARCHAR2(10) CONSTRAINT MD_DrugID_nn NOT NULL, 
    Batch_Number        NUMBER(10), 
    Medicine_Type       VARCHAR2(255), 
    Manufacturer        VARCHAR2(255), 
    Stock_Quantity      NUMBER(10), 
    Mfd_Date            DATE,
    Expiry_Date         DATE, 
    Medicine_Price      NUMBER(4)
);


CREATE TABLE Disposed_Medicine (
    Medicine_Name      VARCHAR2(255) PRIMARY KEY,
    Batch_Number        NUMBER(10),
    Medicine_Quantity   NUMBER(10),
    Manufacturer        VARCHAR2(255),
    CONSTRAINT DM_Order_FK FOREIGN KEY (Medicine_Name) REFERENCES Medicine_Details (Drug_Name)
);

CREATE TABLE Customer_Insurance (
    Insurance_ID    NUMBER(10) PRIMARY KEY, 
    Company_Name    VARCHAR2(255), 
    Start_Date      DATE, 
    End_Date        DATE, 
    Co_Insurance    NUMBER(4)
);

CREATE TABLE Employee_Details (
    Employee_ID         NUMBER(5) PRIMARY KEY, 
    Employee_SSN        NUMBER(10) UNIQUE, 
    Employee_License    NUMBER(10) UNIQUE, 
    Employee_Name       VARCHAR2(255),
    Employee_Start_Date DATE, 
    Employee_End_Date   DATE, 
    Employee_Role       VARCHAR2(255), 
    Employee_Salary     NUMBER(4), 
    Employee_Phone      NUMBER(10), 
    Employee_DOB        DATE
);


CREATE TABLE Customer (
    Customer_SSN       NUMBER(10) PRIMARY KEY, 
    Customer_Name      VARCHAR2(255), 
    Customer_Phone     NUMBER(10) UNIQUE, 
    Customer_Gender    VARCHAR2(1), 
    Customer_Address   VARCHAR2(1000), 
    Customer_State     VARCHAR2(15),
    Customer_Country   VARCHAR2(15),
    Customer_DOB       DATE, 
    Customer_Insurance NUMBER(10) UNIQUE
);

CREATE TABLE Prescription (
    Prescription_ID   NUMBER(10) PRIMARY KEY, 
    Patient_SSN       NUMBER(10), 
    Doctor_ID         NUMBER(10), 
    Prescription_Date DATE,
    CONSTRAINT P_Patient_FK FOREIGN KEY (Patient_SSN) REFERENCES Customer (Customer_SSN),
    CONSTRAINT P_Doctor_FK FOREIGN KEY (Doctor_ID) REFERENCES Employee_Details (Employee_ID)
);


CREATE TABLE Customer_Order (
    Order_ID          NUMBER(10) PRIMARY KEY, 
    Prescription_ID   NUMBER(10), 
    Employee_ID       NUMBER(5), 
    Order_Date        DATE,
    CONSTRAINT CO_Prescription_FK FOREIGN KEY (Prescription_ID) REFERENCES Prescription (Prescription_ID),
    CONSTRAINT CO_Employee_FK FOREIGN KEY (Employee_ID) REFERENCES Employee_Details (Employee_ID)
);



CREATE TABLE Ordered_Drugs (
    Order_ID              NUMBER(10) PRIMARY KEY, 
    Drug_Name             VARCHAR2(255), 
    Batch_Number          NUMBER(10), 
    Ordered_Quantity      NUMBER(10), 
    Price                 NUMBER(2),
    CONSTRAINT OD_Order_FK FOREIGN KEY (Order_ID) REFERENCES Customer_Order (Order_ID),
    CONSTRAINT OD_Drug_FK FOREIGN KEY (Drug_Name) REFERENCES Medicine_Details (Drug_Name)
);

CREATE TABLE Customer_Bill (
    Order_ID            NUMBER(10) PRIMARY KEY, 
    Customer_SSN        NUMBER(10), 
    Total_Amount        NUMBER(4), 
    Customer_Payment    NUMBER(4), 
    Insurance_Payment   NUMBER(4), 
    Billing_Num         VARCHAR2(10),
    CONSTRAINT CB_Order_FK FOREIGN KEY (Order_ID) REFERENCES Customer_Order (Order_ID),
    CONSTRAINT CB_Customer_FK FOREIGN KEY (Customer_SSN) REFERENCES Customer (Customer_SSN)
);


CREATE TABLE Employee_Disposed_Medicine (
    Employee_ID        NUMBER(5),
    Medicine_Name      VARCHAR2(255),
    Medicine_Batch     NUMBER(10),
    Disposal_Date      DATE,
    PRIMARY KEY (Employee_ID, Medicine_Name, Medicine_Batch, Disposal_Date),
    CONSTRAINT EDM_Employee_FK FOREIGN KEY (Employee_ID) REFERENCES Employee_Details (Employee_ID),
    CONSTRAINT EDM_Medicine_FK FOREIGN KEY (Medicine_Name) REFERENCES Disposed_Medicine (Medicine_Name)
);


CREATE TABLE Prescribed_Drugs (
    Prescription_ID       NUMBER(10),
    Drug_Name             VARCHAR2(255),
    Prescribed_Quantity   NUMBER(10),
    Refill_Limit          NUMBER(10),
    PRIMARY KEY (Prescription_ID, Drug_Name),
    CONSTRAINT PD_Prescription_FK FOREIGN KEY (Prescription_ID) REFERENCES Prescription (Prescription_ID),
    CONSTRAINT PD_Drug_FK FOREIGN KEY (Drug_Name) REFERENCES Medicine_Details (Drug_Name)
);

--display all tables
SELECT *FROM Medicine_Details;
SELECT *FROM Disposed_Medicine;
SELECT *FROM Customer_Insurance;
SELECT *FROM Employee_Details;
SELECT *FROM Customer;
SELECT *FROM Customer_order;
SELECT *FROM Prescription;
SELECT *FROM Ordered_Drugs;
SELECT *FROM Employee_Disposed_Medicine;
SELECT *FROM Customer_Bill;
SELECT *FROM Prescribed_Drugs;

-- value insertion part

INSERT INTO Medicine_Details VALUES ('Paracetamol', 'ID1', 101, 'Tablet', 'LOL Manufacturer', 500, TO_DATE('2022-01-01', 'YYYY-MM-DD'), TO_DATE('2023-01-01', 'YYYY-MM-DD'), 15.0);
INSERT INTO Medicine_Details VALUES ('Amoxicillin', 'ID2', 102, 'Capsule', 'LMAO Manufacturer', 700, TO_DATE('2022-02-01', 'YYYY-MM-DD'), TO_DATE('2023-02-01', 'YYYY-MM-DD'), 20.0);
INSERT INTO Medicine_Details VALUES ('Ibuprofen', 'ID3', 103, 'Tablet', 'LMFAO Manufacturer', 300, TO_DATE('2022-03-01', 'YYYY-MM-DD'), TO_DATE('2023-03-01', 'YYYY-MM-DD'), 10.0);
INSERT INTO Medicine_Details VALUES ('Azithromycin', 'ID4', 104, 'Capsule', 'OMG Manufacturer', 600, TO_DATE('2022-04-01', 'YYYY-MM-DD'), TO_DATE('2023-04-01', 'YYYY-MM-DD'), 25.0);
INSERT INTO Medicine_Details VALUES ('Omeprazole', 'ID5', 105, 'Capsule', 'OMFG Manufacturer', 400, TO_DATE('2022-05-01', 'YYYY-MM-DD'), TO_DATE('2023-05-01', 'YYYY-MM-DD'), 18.0);


INSERT INTO Disposed_Medicine VALUES ('Paracetamol', 101, 50, 'LOL Manufacturer');
INSERT INTO Disposed_Medicine VALUES ('Amoxicillin', 102, 30, 'LMAO Manufacturer');
INSERT INTO Disposed_Medicine VALUES ('Ibuprofen', 103, 20, 'LMFAO Manufacturer');
INSERT INTO Disposed_Medicine VALUES ('Azithromycin', 104, 40, 'OMG Manufacturer');
INSERT INTO Disposed_Medicine VALUES ('Omeprazole', 105, 25, 'OMFG Manufacturer');


INSERT INTO Customer_Insurance VALUES (1, 'LOL Company', TO_DATE('2022-01-01', 'YYYY-MM-DD'), TO_DATE('2023-01-01', 'YYYY-MM-DD'), 5.0);
INSERT INTO Customer_Insurance VALUES (2, 'LMAO Company', TO_DATE('2022-02-01', 'YYYY-MM-DD'), TO_DATE('2023-02-01', 'YYYY-MM-DD'), 8.0);
INSERT INTO Customer_Insurance VALUES (3, 'LMFAO Company', TO_DATE('2022-03-01', 'YYYY-MM-DD'), TO_DATE('2023-03-01', 'YYYY-MM-DD'), 10.0);
INSERT INTO Customer_Insurance VALUES (4, 'OMG Company', TO_DATE('2022-04-01', 'YYYY-MM-DD'), TO_DATE('2023-04-01', 'YYYY-MM-DD'), 6.0);
INSERT INTO Customer_Insurance VALUES (5, 'OMFG Company', TO_DATE('2022-05-01', 'YYYY-MM-DD'), TO_DATE('2023-05-01', 'YYYY-MM-DD'), 7.0);


INSERT INTO Employee_Details VALUES (1, 1234567890, 111, 'John Doe', TO_DATE('2022-01-01', 'YYYY-MM-DD'), TO_DATE('2023-01-01', 'YYYY-MM-DD'), 'LOL Role', 5000, 9876543210, TO_DATE('1990-01-01', 'YYYY-MM-DD'));
INSERT INTO Employee_Details VALUES (2, 2345678901, 222, 'Jane Smith', TO_DATE('2022-02-01', 'YYYY-MM-DD'), TO_DATE('2023-02-01', 'YYYY-MM-DD'), 'LMAO Role', 6000, 8765432109, TO_DATE('1985-01-01', 'YYYY-MM-DD'));
INSERT INTO Employee_Details VALUES (3, 3456789012, 333, 'Alice Brown', TO_DATE('2022-03-01', 'YYYY-MM-DD'), TO_DATE('2023-03-01', 'YYYY-MM-DD'), 'LMFAO Role', 7000, 7654321098, TO_DATE('1988-01-01', 'YYYY-MM-DD'));
INSERT INTO Employee_Details VALUES (4, 4567890123, 444, 'Bob Williams', TO_DATE('2022-04-01', 'YYYY-MM-DD'), TO_DATE('2023-04-01', 'YYYY-MM-DD'), 'OMG Role', 8000, 6543210987, TO_DATE('1982-01-01', 'YYYY-MM-DD'));
INSERT INTO Employee_Details VALUES (5, 5678901234, 555, 'Charlie Johnson', TO_DATE('2022-05-01', 'YYYY-MM-DD'), TO_DATE('2023-05-01', 'YYYY-MM-DD'), 'OMFG Role', 9000, 5432109876, TO_DATE('1980-01-01', 'YYYY-MM-DD'));


INSERT INTO Customer VALUES (1111111111, 'Aria Scott', 9876543210, 'F', 'Vidya Nagar', 'Maharashtra', 'India', TO_DATE('1980-01-01', 'YYYY-MM-DD'), 1);
INSERT INTO Customer VALUES (2222222222, 'Brandon Taylor', 8765432109, 'M', 'Lingaraj Nagar', 'Karnataka', 'India', TO_DATE('1990-01-01', 'YYYY-MM-DD'), 2);
INSERT INTO Customer VALUES (3333333333, 'Chloe Carter', 7654321098, 'M', 'Hanuman Nagar', 'Tamil Nadu', 'India', TO_DATE('1985-01-01', 'YYYY-MM-DD'), 3);
INSERT INTO Customer VALUES (4444444444, 'Kanye West', 6543210987, 'M', 'MotaBhai Nagar', 'Gujarat', 'India', TO_DATE('1970-01-01', 'YYYY-MM-DD'), 4);
INSERT INTO Customer VALUES (5555555555, 'Ella Harris', 5432109876, 'F', 'Ganesh Nagar', 'Kerala', 'India', TO_DATE('1982-01-01', 'YYYY-MM-DD'), 5);

INSERT INTO Prescription VALUES (101, 1111111111, 1, TO_DATE('2022-01-01', 'YYYY-MM-DD'));
INSERT INTO Prescription VALUES (102, 2222222222, 2, TO_DATE('2022-02-01', 'YYYY-MM-DD'));
INSERT INTO Prescription VALUES (103, 3333333333, 3, TO_DATE('2022-03-01', 'YYYY-MM-DD'));
INSERT INTO Prescription VALUES (104, 4444444444, 4, TO_DATE('2022-04-01', 'YYYY-MM-DD'));
INSERT INTO Prescription VALUES (105, 5555555555, 5, TO_DATE('2022-05-01', 'YYYY-MM-DD'));



INSERT INTO Customer_Order VALUES (1, 101, 1, TO_DATE('2022-01-10', 'YYYY-MM-DD'));
INSERT INTO Customer_Order VALUES (2, 102, 2, TO_DATE('2022-02-10', 'YYYY-MM-DD'));
INSERT INTO Customer_Order VALUES (3, 103, 3, TO_DATE('2022-03-10', 'YYYY-MM-DD'));
INSERT INTO Customer_Order VALUES (4, 104, 4, TO_DATE('2022-04-10', 'YYYY-MM-DD'));
INSERT INTO Customer_Order VALUES (5, 105, 5, TO_DATE('2022-05-10', 'YYYY-MM-DD'));


INSERT INTO Ordered_Drugs VALUES (1, 'Paracetamol', 101, 10, 15.0);
INSERT INTO Ordered_Drugs VALUES (2, 'Amoxicillin', 102, 8, 20.0);
INSERT INTO Ordered_Drugs VALUES (3, 'Ibuprofen', 103, 12, 10.0);
INSERT INTO Ordered_Drugs VALUES (4, 'Azithromycin', 104, 5, 25.0);
INSERT INTO Ordered_Drugs VALUES (5, 'Omeprazole', 105, 3, 18.0);


INSERT INTO Customer_Bill VALUES (1, 1111111111, 50.99, 40.99, 10.0, 'Billing123');
INSERT INTO Customer_Bill VALUES (2, 2222222222, 67.97, 57.97, 10.0, 'Billing456');
INSERT INTO Customer_Bill VALUES (3, 3333333333, 56.94, 46.94, 10.0, 'Billing789');
INSERT INTO Customer_Bill VALUES (4, 4444444444, 72.92, 62.92, 10.0, 'Billing012');
INSERT INTO Customer_Bill VALUES (5, 5555555555, 38.97, 28.97, 10.0, 'Billing345');


INSERT INTO Employee_Disposed_Medicine VALUES (1, 'Paracetamol', 101, TO_DATE('2022-01-15', 'YYYY-MM-DD'));
INSERT INTO Employee_Disposed_Medicine VALUES (2, 'Amoxicillin', 102, TO_DATE('2022-02-15', 'YYYY-MM-DD'));
INSERT INTO Employee_Disposed_Medicine VALUES (3, 'Ibuprofen', 103, TO_DATE('2022-03-15', 'YYYY-MM-DD'));
INSERT INTO Employee_Disposed_Medicine VALUES (4, 'Azithromycin', 104, TO_DATE('2022-04-15', 'YYYY-MM-DD'));
INSERT INTO Employee_Disposed_Medicine VALUES (5, 'Omeprazole', 105, TO_DATE('2022-05-15', 'YYYY-MM-DD'));


INSERT INTO Prescribed_Drugs VALUES (101, 'Paracetamol', 30, 5);
INSERT INTO Prescribed_Drugs VALUES (102, 'Amoxicillin', 20, 3);
INSERT INTO Prescribed_Drugs VALUES (103, 'Ibuprofen', 25, 4);
INSERT INTO Prescribed_Drugs VALUES (104, 'Azithromycin', 15, 2);
INSERT INTO Prescribed_Drugs VALUES (105, 'Omeprazole', 10, 1);



--Retrieve the names and roles of all employees:
SELECT Employee_Name, Employee_Role
FROM Employee_Details;


--Find the total fee and billing status of Alice Johnson:
SELECT Customer_SSN, Total_Amount, Customer_Payment, Insurance_Payment
FROM Customer_Bill 
WHERE Customer_SSN = 3333333333;


--Identify the medicines disposed of by OMG Manufacturer:
SELECT Medicine_Name, Batch_Number, Medicine_Quantity
FROM Disposed_Medicine
WHERE Manufacturer = 'OMG Manufacturer';

--Find the disposal details, including company, for aspirin:
SELECT Medicine_Name, Medicine_Quantity, Manufacturer
FROM Disposed_Medicine
WHERE Medicine_Name = 'Paracetamol';

--Find the prescription details for MedicineA, including prescription date and doctor ID:
SELECT pd.Prescription_ID, p.Prescription_Date, p.Doctor_ID
FROM Prescribed_Drugs pd
JOIN Prescription p ON pd.Prescription_ID = p.Prescription_ID
WHERE pd.Drug_Name = 'Ibuprofen';


--List the employees who have disposed of medicines along with the details of the disposed medicines:
SELECT
    ed.Employee_ID,
    ed.Employee_Name,
    edm.Medicine_Name,
    edm.Medicine_Batch,
    edm.Disposal_Date
FROM
    Employee_Details ed
    JOIN Employee_Disposed_Medicine edm ON ed.Employee_ID = edm.Employee_ID;
  

--Orders containing medicines with a batch number not disposed:
SELECT DISTINCT co.Order_ID, od.Drug_Name
FROM Customer_Order co
JOIN Ordered_Drugs od ON co.Order_ID = od.Order_ID
LEFT JOIN Disposed_Medicine dm ON od.Batch_Number = dm.Batch_Number
WHERE dm.Batch_Number IS NOT NULL OR od.Batch_Number != dm.Batch_Number;



--Retrieve all orders along with the drugs ordered, ordered quantity, and total price:
SELECT co.Order_ID, od.Drug_Name, od.Ordered_Quantity, od.Price * od.Ordered_Quantity AS Total_Price
FROM Customer_Order co
JOIN Ordered_Drugs od ON co.Order_ID = od.Order_ID;


--Find the total amount paid by each customer along with their names:
SELECT c.Customer_SSN, c.Customer_Name, SUM(cb.Customer_Payment) AS Total_Payment
FROM Customer c
JOIN Customer_Bill cb ON c.Customer_SSN = cb.Customer_SSN
GROUP BY c.Customer_SSN, c.Customer_Name;


--Find the prescription drugs with the highest refill limit:
SELECT Drug_Name, MAX(Refill_Limit) AS Highest_Refill_Limit
FROM Prescribed_Drugs
GROUP BY Drug_Name;

--Show the names of customers along with the total amount billed and the amount paid:
SELECT c.Customer_SSN, 
       c.Customer_Name,
       SUM(cb.Total_Amount) AS Total_Billed,
       SUM(cb.Customer_Payment) AS Total_Paid
FROM Customer c
JOIN Customer_Bill cb ON c.Customer_SSN = cb.Customer_SSN
GROUP BY c.Customer_SSN, c.Customer_Name;


--Find the total quantity of each drug ordered across all orders:
SELECT md.Drug_Name,
       SUM(od.Ordered_Quantity) AS Total_Ordered_Quantity
FROM Medicine_Details md
JOIN Ordered_Drugs od ON md.Drug_Name = od.Drug_Name
GROUP BY md.Drug_Name;


--Calculate the total price of all medicines:
SELECT SUM(Medicine_Price * Stock_Quantity) AS Total_Price
FROM Medicine_Details;

--Calculate the average salary of employees who have prepared orders:
SELECT AVG(ed.Employee_Salary) AS Average_Salary
FROM Employee_Details ed
WHERE ed.Employee_ID IN (SELECT DISTINCT co.Employee_ID FROM Customer_Order co);


--Retrieve the names of customers who have prescriptions:
SELECT c.Customer_SSN, c.Customer_Name
FROM Customer c
WHERE EXISTS (SELECT 1 FROM Prescription p WHERE p.Patient_SSN = c.Customer_SSN);

--Retrieve customers who have insurance with the highest co-insurance value:

SELECT ci.Insurance_ID, ci.Company_Name, ci.Start_Date, ci.End_Date, ci.Co_Insurance
FROM Customer_Insurance ci
WHERE ci.Co_Insurance = (SELECT MAX(Co_Insurance) FROM Customer_Insurance);


--Find the prescription drugs with the highest prescribed quantity:
SELECT pd.Prescription_ID, pd.Drug_Name, pd.Prescribed_Quantity, pd.Refill_Limit
FROM Prescribed_Drugs pd
WHERE pd.Prescribed_Quantity = (SELECT MAX(Prescribed_Quantity) FROM Prescribed_Drugs);