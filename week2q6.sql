use master1;
create table emp_salary (emp_id int primary key,emp_name varchar(50),department varchar(50),salary int);

insert into emp_salary values
(1, 'Aditi', 'Engineering', 100000),
(2, 'Bharat', 'Engineering', 100000),
(3, 'Chetan', 'Engineering', 90000),
(4, 'Divya', 'Engineering', 80000),
(5, 'Eshan', 'Engineering', 80000),
(6, 'Farhan', 'Engineering', 70000),
(7, 'Gauri', 'Sales', 75000),
(8, 'Harsh', 'Sales', 72000),
(9, 'Ira', 'Sales', 72000),
(10, 'Jatin', 'Support', 50000),
(11, 'Kavya', 'HR', 60000),
(12, 'Lokesh', 'HR', 60000);

select emp_id,emp_name,department,salary,
row_number() over (partition by department order by salary desc, emp_id) 
as row_num,rank() over (partition by department order by salary desc) as rnk,
dense_rank() over (partition by department order by salary desc) as dense_rnk from emp_salary order by department, salary desc, emp_id;

with cte as (select department, emp_name, salary, dense_rank() over (partition by department order by salary desc) 
as salary_level from emp_salary) select department,emp_name,salary,salary_level from cte where 
salary_level <= 3 order by department, salary desc, emp_name;