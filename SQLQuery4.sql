
USE CompanyDB;

SELECT e.EmployeeID, e.EmployeeName, d.DepartmentName FROM Employees e INNER JOIN Departments d ON e.DepartmentID = d.DepartmentID;

SELECT e.EmployeeID, e.EmployeeName, d.DepartmentName FROM Employees e LEFT JOIN Departments d ON e.DepartmentID = d.DepartmentID;

SELECT e.EmployeeID, e.EmployeeName, d.DepartmentName FROM Employees e RIGHT JOIN Departments d ON e.DepartmentID = d.DepartmentID;

SELECT e.EmployeeID, e.EmployeeName, d.DepartmentName FROM Employees e FULL OUTER JOIN Departments d ON e.DepartmentID = d.DepartmentID;

SELECT e.EmployeeName, d.DepartmentName FROM Employees e CROSS JOIN Departments d;

SELECT DepartmentID, SUM(Salary) AS TotalSalary FROM Employees GROUP BY DepartmentID;

SELECT d.DepartmentName, s.TotalSalary FROM Departments d LEFT JOIN (SELECT DepartmentID, SUM(Salary) AS TotalSalary FROM Employees GROUP BY DepartmentID) s ON d.DepartmentID = s.DepartmentID;

SELECT EmployeeName, Salary FROM Employees WHERE Salary > (SELECT AVG(Salary) FROM Employees);

SELECT * FROM Employees WHERE DepartmentID IN (SELECT DepartmentID FROM Departments);

SELECT * FROM Departments d WHERE EXISTS (SELECT 1 FROM Employees e WHERE e.DepartmentID = d.DepartmentID);

SELECT * FROM Departments d WHERE NOT EXISTS (SELECT 1 FROM Employees e WHERE e.DepartmentID = d.DepartmentID);

SELECT EmployeeName, Salary FROM Employees e WHERE Salary > (SELECT AVG(Salary) FROM Employees WHERE DepartmentID = e.DepartmentID);

SELECT d.DepartmentName, s.AverageSalary FROM Departments d JOIN (SELECT DepartmentID, AVG(Salary) AS AverageSalary FROM Employees GROUP BY DepartmentID) s ON d.DepartmentID = s.DepartmentID;

SELECT MAX(Salary) AS SecondHighestSalary FROM Employees WHERE Salary < (SELECT MAX(Salary) FROM Employees);

SELECT MAX(Salary) AS ThirdHighestSalary FROM Employees WHERE Salary < (SELECT MAX(Salary) FROM Employees WHERE Salary < (SELECT MAX(Salary) FROM Employees));

DECLARE @N INT = 3;
SELECT DISTINCT Salary FROM Employees e WHERE @N - 1 = (SELECT COUNT(DISTINCT Salary) FROM Employees WHERE Salary > e.Salary);
