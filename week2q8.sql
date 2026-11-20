use master1;
create table Employee (Empid int primary key,Full_name varchar(100),Salary decimal(10,2),Hiredate date,deptid int);
create table Dept_loc (deptid int primary key,deptname varchar(50),loc varchar(50));

insert into Employee values
(1012, 'Raji K Nair', 35500, '2018-04-09', 1),
(1009, 'Jeena', 12000, '2018-11-17', 2),
(1005, 'Nidhi R Shetty', 10000, '2019-01-16', 3),
(1011, 'Jiya Shetty', 45500, '2019-03-27', 4),
(1003, 'Arun Kumar Menon', 45500, '2019-08-02', 5),
(1007, 'Farah Ali', 30000, '2020-02-10', NULL),
(1001, 'Manoj P Iyer', 52000, '2020-07-15', 2);

insert into Dept_loc values
(1, 'HR', 'Dallas'),
(2, 'Sales', 'Chicago'),
(3, 'Customer service', 'Chicago'),
(4, 'IT', 'Boston'),
(5, 'Research', 'Seattle'),
(6, 'Legal', 'New York');
go 
create or alter view VW_EMP_DEPT as with emp_data as (select e.Empid, concat( left(e.Full_name, charindex(' ', e.Full_name + ' ') - 1),' ',
right(e.Full_name, charindex(' ', reverse(e.Full_name) + ' ') - 1)) as Full_name,
e.Salary as New_Salary,e.Hiredate,d.deptname,d.loc,lag(e.Salary) over (order by e.Hiredate) as Previous_emp from Employee e
left join Dept_loc d on e.deptid = d.deptid)
select Empid,Full_name,New_Salary, cast(
case when loc = 'Chicago' then New_Salary * 1.05
when loc = 'Boston' then New_Salary * 1.03
when loc = 'Dallas' then New_Salary * 1.10
when loc = 'New York' then New_Salary * 1.10
else New_Salary
end as decimal(10,2)) as Inc_Sal,Previous_emp,Hiredate,deptname,loc,
case when Previous_emp is null then 'No previous employee'
when New_Salary > Previous_emp then 'Salary is greater than previously hired'
when New_Salary < Previous_emp then 'Salary is less than previously hired'
else 'Salary is same as previously hired' end as message from emp_data;
go 
select * from sys.views where name = 'VW_EMP_DEPT';

select * from VW_EMP_DEPT order by Hiredate;

select * from dbo.VW_EMP_DEPT
order by Hiredate;