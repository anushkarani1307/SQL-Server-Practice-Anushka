use master;
create table students (student_id int primary key,student_name varchar(50),city varchar(50));
create table enrollments (enrollment_id int primary key,student_id int,subject_name varchar(50));
create table store_customers (customer_id varchar(10) primary key,customer_name varchar(50),city varchar(50));
create table store_orders (order_id varchar(10) primary key,customer_id varchar(10),order_date date,amount int);



insert into students values
(101, 'Rahul', 'Jaipur'),
(102, 'Priya', 'Kochi'),
(103, 'Aman', 'Mumbai'),
(104, 'Neha', 'Delhi'),
(105, 'Riya', 'Pune'),
(106, 'Sana Khan', 'Delhi');

insert into enrollments values
(1, 101, 'SQL'),
(2, 102, 'Python'),
(3, 103, 'Java'),
(4, 104, 'SQL'),
(5, 105, 'Python');

insert into store_customers values
('C01', 'Rahul Mehta', 'Jaipur'),
('C02', 'Priya Nair', 'Kochi'),
('C03', 'Arjun Das', 'Kolkata'),
('C04', 'Fatima Sheikh', 'Mumbai'),
('C05', 'Karan Malhotra', 'Delhi');

insert into store_orders values
('O1001', 'C01', '2026-03-01', 1200),
('O1002', 'C02', '2026-03-02', 850),
('O1003', 'C01', '2026-03-05', 430),
('O1004', 'C07', '2026-03-06', 999),
('O1005', 'C04', '2026-03-08', 2100),
('O1006', NULL, '2026-03-09', 300);

select student_id, student_name, city from students s where not exists (select 1 from enrollments e where e.student_id = s.student_id );

select customer_id, customer_name, city from store_customers c where not exists (select 1 from store_orders o where o.customer_id = c.customer_id);

select o.order_id, o.customer_id, o.amount, case when o.customer_id is null then 'Guest order - no customer' else 'Customer not found' end as issue
from store_orders o where o.customer_id is null or not exists ( select 1 from store_customers c where c.customer_id = o.customer_id );