
USE CompanyDB;

SELECT COUNT(*) AS TotalEmployees FROM Employees;

SELECT SUM(Salary) AS TotalSalaryExpense FROM Employees;

SELECT AVG(Salary) AS AverageSalary FROM Employees;

SELECT MIN(Salary) AS LowestSalary FROM Employees;

SELECT MAX(Salary) AS HighestSalary FROM Employees;

SELECT DepartmentID, COUNT(*) AS TotalEmployees FROM Employees GROUP BY DepartmentID;

SELECT DepartmentID, SUM(Salary) AS TotalSalary FROM Employees GROUP BY DepartmentID;

SELECT DepartmentID, AVG(Salary) AS AverageSalary FROM Employees GROUP BY DepartmentID;

SELECT DepartmentID, COUNT(*) AS TotalEmployees FROM Employees GROUP BY DepartmentID HAVING COUNT(*) > 1;

SELECT DepartmentID, AVG(Salary) AS AverageSalary FROM Employees GROUP BY DepartmentID HAVING AVG(Salary) > 50000;

SELECT DepartmentID, COUNT(*) AS TotalEmployees, AVG(Salary) AS AverageSalary FROM Employees WHERE Salary > 40000 GROUP BY DepartmentID HAVING COUNT(*) >= 1;

SELECT e.EmployeeID, e.EmployeeName, e.Salary, d.DepartmentName FROM Employees e INNER JOIN Departments d ON e.DepartmentID = d.DepartmentID;

SELECT e.EmployeeID, e.EmployeeName, e.Salary, d.DepartmentName FROM Employees e LEFT JOIN Departments d ON e.DepartmentID = d.DepartmentID;

SELECT d.DepartmentID, d.DepartmentName FROM Departments d LEFT JOIN Employees e ON d.DepartmentID = e.DepartmentID WHERE e.EmployeeID IS NULL;

SELECT e.EmployeeID, e.EmployeeName, e.DepartmentID FROM Employees e LEFT JOIN Departments d ON e.DepartmentID = d.DepartmentID WHERE d.DepartmentID IS NULL;
