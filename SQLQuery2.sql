
USE CompanyDB;

SELECT * FROM Employees;
SELECT EmployeeID, EmployeeName, Salary, Email FROM Employees;
SELECT * FROM Employees WHERE Salary > 50000;
SELECT * FROM Employees ORDER BY Salary DESC;
SELECT DISTINCT DepartmentID FROM Employees;
SELECT EmployeeName AS Name, Salary AS Monthly_Salary FROM Employees;
SELECT TOP 3 * FROM Employees ORDER BY Salary DESC;

SELECT * FROM Employees WHERE Salary BETWEEN 30000 AND 70000;
SELECT * FROM Employees WHERE DepartmentID IN (101, 102);
SELECT * FROM Employees WHERE EmployeeName LIKE 'A%';
SELECT * FROM Employees WHERE EmployeeName LIKE '%a';
SELECT * FROM Employees WHERE EmployeeName LIKE '%an%';
SELECT * FROM Employees WHERE EmployeeName LIKE '_____';
SELECT * FROM Employees WHERE Salary > 40000 AND DepartmentID = 102;
SELECT * FROM Employees WHERE Salary < 30000 OR Salary > 80000;
SELECT * FROM Employees WHERE DepartmentID <> 101;

SELECT GETDATE() AS CurrentDateTime;
SELECT EmployeeName, JoiningDate, DATEDIFF(YEAR, JoiningDate, GETDATE()) AS ExperienceYears FROM Employees;
SELECT EmployeeName, DATEPART(YEAR, JoiningDate) AS JoiningYear, DATEPART(MONTH, JoiningDate) AS JoiningMonth, DATEPART(DAY, JoiningDate) AS JoiningDay FROM Employees;
SELECT EmployeeName, JoiningDate, DATEADD(MONTH, 6, JoiningDate) AS AfterSixMonths FROM Employees;
SELECT EmployeeName, DATEDIFF(DAY, JoiningDate, GETDATE()) AS WorkingDays FROM Employees;

SELECT UPPER(EmployeeName) AS UpperName FROM Employees;
SELECT LOWER(EmployeeName) AS LowerName FROM Employees;
SELECT EmployeeName, LEFT(EmployeeName, 3) AS FirstThreeCharacters FROM Employees;
SELECT EmployeeName, RIGHT(EmployeeName, 3) AS LastThreeCharacters FROM Employees;
SELECT EmployeeName, SUBSTRING(EmployeeName, 2, 3) AS ExtractedName FROM Employees;
SELECT EmployeeName, LEN(EmployeeName) AS NameLength FROM Employees;
SELECT TRIM(EmployeeName) AS CleanName FROM Employees;
SELECT Email, REPLACE(Email, 'gmail.com', 'company.com') AS UpdatedEmail FROM Employees;
SELECT CONCAT(EmployeeName, ' - ', Email) AS EmployeeDetails FROM Employees;
SELECT Email, CHARINDEX('@', Email) AS AtPosition FROM Employees;

SELECT EmployeeName, Salary, ROUND(Salary, -3) AS RoundedSalary FROM Employees;
SELECT EmployeeName, Salary, CEILING(Salary) AS CeilingSalary FROM Employees;
SELECT EmployeeName, Salary, FLOOR(Salary) AS FloorSalary FROM Employees;

SELECT EmployeeName, CAST(Salary AS VARCHAR(20)) AS SalaryText FROM Employees;
SELECT EmployeeName, CONVERT(VARCHAR(10), JoiningDate, 105) AS FormattedDate FROM Employees;
SELECT EmployeeName, CAST(Salary AS INT) AS SalaryUsingCast, CONVERT(INT, Salary) AS SalaryUsingConvert FROM Employees;

SELECT EmployeeName, ISNULL(PhoneNumber, 'Not Provided') AS ContactNumber FROM Employees;
SELECT EmployeeName, COALESCE(PhoneNumber, Email, 'Not Available') AS ContactDetails FROM Employees;
SELECT EmployeeName, NULLIF(Status, 'Inactive') AS EmployeeStatus FROM Employees;

SELECT EmployeeName, Salary,
CASE
    WHEN Salary >= 70000 THEN 'High Salary'
    WHEN Salary >= 40000 THEN 'Medium Salary'
    ELSE 'Low Salary'
END AS SalaryCategory
FROM Employees;

SELECT EmployeeName, Status,
CASE
    WHEN Status = 'Active' THEN 'Currently Working'
    WHEN Status = 'Inactive' THEN 'Not Working'
    ELSE 'Unknown Status'
END AS EmployeeCategory
FROM Employees;

SELECT EmployeeName, Salary,
CASE
    WHEN Salary > 70000 THEN Salary * 0.15
    WHEN Salary >= 40000 THEN Salary * 0.10
    ELSE Salary * 0.05
END AS Bonus
FROM Employees;
