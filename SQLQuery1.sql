
CREATE DATABASE CompanyDB;

USE CompanyDB;

CREATE TABLE Departments (
    DepartmentID INT PRIMARY KEY,
    DepartmentName VARCHAR(50) NOT NULL UNIQUE,
    Location VARCHAR(50) DEFAULT 'India'
);

CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    EmployeeName VARCHAR(100) NOT NULL,
    Email VARCHAR(100) UNIQUE NOT NULL,
    Salary DECIMAL(10,2) CHECK (Salary > 0),
    DepartmentID INT,
    JoiningDate DATE DEFAULT GETDATE(),
    Status VARCHAR(20) DEFAULT 'Active',
    FOREIGN KEY (DepartmentID)
    REFERENCES Departments(DepartmentID),
    CHECK (Status IN ('Active', 'Inactive'))
);

INSERT INTO Departments
VALUES
(101, 'IT', 'Gurugram'),
(102, 'HR', 'Delhi'),
(103, 'Finance', 'Ambala');

INSERT INTO Employees
(EmployeeID, EmployeeName, Email, Salary, DepartmentID)
VALUES
(1, 'Rahul', 'rahul@gmail.com', 50000, 101),
(2, 'Priya', 'priya@gmail.com', 60000, 102),
(3, 'Amit', 'amit@gmail.com', 45000, 101),
(4, 'Neha', 'neha@gmail.com', 55000, 103),
(5, 'Karan', 'karan@gmail.com', 40000, 102);

SELECT * FROM Employees;

SELECT
    E.EmployeeID,
    E.EmployeeName,
    E.Email,
    E.Salary,
    D.DepartmentName
FROM Employees E
INNER JOIN Departments D
ON E.DepartmentID = D.DepartmentID;

UPDATE Employees
SET Salary = 65000
WHERE EmployeeID = 1;

DELETE FROM Employees
WHERE EmployeeID = 5;

ALTER TABLE Employees
ADD PhoneNumber VARCHAR(15);

BEGIN TRAN;

UPDATE Employees
SET Salary = 70000
WHERE EmployeeID = 2;

COMMIT;

BEGIN TRAN;

UPDATE Employees
SET Salary = 100000
WHERE EmployeeID = 3;

ROLLBACK;

DELETE FROM Employees
WHERE EmployeeID = 4;

CREATE TABLE #TempEmployees (
    EmployeeID INT,
    EmployeeName VARCHAR(100)
);

INSERT INTO #TempEmployees
VALUES (101, 'Test Employee');

SELECT * FROM #TempEmployees;

DROP TABLE #TempEmployees;

SELECT * FROM Employees;
