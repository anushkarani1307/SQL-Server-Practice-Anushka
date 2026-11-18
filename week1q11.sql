use master;
drop table if exists employees;

create table employees (
emp_id varchar(10) primary key,
emp_name varchar(50),
dept_id int,
salary decimal(10,2),
manager_id varchar(10));

insert into employees values
('E01', 'Asha Verma', 10, 70000, null),
('E02', 'Ravi Kumar', 20, 95000, 'E01'),
('E03', 'Meena Pillai', 10, 70000, 'E01'),
('E05', 'Sara Ali', 30, 98000, 'E01'),
('E06', 'Rahul Sharma', 20, 52000, 'E01'),
('E07', 'Neha Singh', 20, 63000, 'E02'),
('E08', 'Amit Kumar', 20, 84000, 'E02'),
('E09', 'Priya Jain', 10, 70000, 'E03'),
('E10', 'Karan Mehta', 30, 60000, 'E05'),
('E11', 'Simran Kaur', 30, 62000, 'E05'),
('E12', 'Vikas Rao', 40, 100000, null),
('E13', 'Rohit Das', 50, 88000, null);

select distinct salary as fourth_highest_salary from employees e1 where 3 = (
select count(distinct salary) from employees e2 where e2.salary > e1.salary);

select
emp_name,
dept_id,
salary,
(select round(avg(salary), 2) from employees e2 where e2.dept_id = e1.dept_id) as dept_avg_salary from employees e1
where dept_id is not null and salary > (select avg(salary) from employees e2 where e2.dept_id = e1.dept_id) order by dept_id, salary desc;

select
e1.emp_id,
e1.emp_name,
(select count(*) from employees e2 where e2.manager_id = e1.emp_id) as direct_reports from employees e1 
where exists (select 1 from employees e2 where e2.manager_id = e1.emp_id);