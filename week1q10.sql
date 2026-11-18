use master;
drop table if exists employees;
drop table if exists departments;

create table departments (
dept_id int primary key,
dept_name varchar(50),
location varchar(50));

create table employees (
emp_id varchar(10) primary key,
emp_name varchar(50),
dept_id int,
manager_id varchar(10),
salary int,
hire_date date);

insert into departments values
(10, 'Leadership', 'Jaipur'),
(20, 'Engineering', 'Bengaluru'),
(30, 'Analytics', 'Pune'),
(40, 'Finance', 'Mumbai'),
(50, 'Legal', 'Delhi');

insert into employees values
('E01', 'Asha Verma', 10, NULL, 150000, '2018-04-10'),
('E02', 'Ravi Kumar', 20, 'E01', 95000, '2019-06-15'),
('E03', 'Meena Pillai', 20, 'E02', 72000, '2021-01-10'),
('E04', 'John Mathew', 20, 'E02', 72000, '2022-03-01'),
('E05', 'Sara Ali', 30, 'E01', 98000, '2019-09-20'),
('E06', 'Vivek Rao', 30, 'E05', 64000, '2023-02-14'),
('E07', 'Pooja Shah', 30, 'E05', 58000, '2024-07-01'),
('E08', 'Nikhil Jain', 20, 'E03', 55000, '2025-01-06'),
('E09', 'Tara Menon', 40, 'E01', 88000, '2020-11-11'),
('E10', 'Imran Qureshi', NULL, 'E01', 61000, '2025-08-18');

select e.emp_id, e.emp_name,
isnull(m.emp_name, 'No Manager') as manager_name,
isnull(d.dept_name, 'Not Assigned') as dept_name,
isnull(d.location, 'Not Assigned') as location from employees e
left join employees m on e.manager_id = m.emp_id left join departments d on e.dept_id = d.dept_id order by e.emp_id;

select d.dept_id, d.dept_name, d.location from employees e right join departments d on e.dept_id = d.dept_id where e.emp_id is null;