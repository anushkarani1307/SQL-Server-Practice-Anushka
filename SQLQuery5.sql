use CompanyDB;
select * from Employees;
WITH AvgSalary AS
(
    SELECT AVG(Salary) AS AverageSalary FROM Employees
)
SELECT EmployeeID, EmployeeName, Salary FROM Employees WHERE Salary > (SELECT AverageSalary FROM AvgSalary);

WITH DeptSalary AS
(
    SELECT DepartmentID, AVG(Salary) AS AvgSalary FROM Employees GROUP BY DepartmentID
),
HighSalaryDept AS
(
    SELECT * FROM DeptSalary WHERE AvgSalary > 50000
)
SELECT * FROM HighSalaryDept;

WITH NumberCTE AS
(
    SELECT 1 AS Num
    UNION ALL
    SELECT Num + 1 FROM NumberCTE WHERE Num < 10
)
SELECT * FROM NumberCTE;