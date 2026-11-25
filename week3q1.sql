create database master2;
use master2;
create table sales_lines (sale_id int primary key,sale_date date,category varchar(50),amount int);
create table category_budget (category varchar(50),q1 int,q2 int,q3 int,q4 int);

insert into sales_lines values
(1, '2025-01-15', 'Electronics', 5000),
(2, '2025-02-20', 'Stationery', 800),
(3, '2025-04-03', 'Electronics', 7000),
(4, '2025-05-11', 'Home', 2500),
(5, '2025-06-30', 'Stationery', 600),
(6, '2025-07-19', 'Electronics', 6500),
(7, '2025-08-08', 'Home', 3000),
(8, '2025-10-01', 'Electronics', 9000),
(9, '2025-11-15', 'Stationery', 1200),
(10, '2025-12-24', 'Home', 4000),
(11, '2025-12-26', 'Electronics', 1000);

insert into category_budget values
('Electronics', 6000, 6000, 7000, 10000),
('Home', 1000, 2000, 3000, 4000),
('Stationery', 1000, 1000, 500, 1500);

select category,sum(case when datepart(quarter, sale_date) = 1 then amount else 0 end) as q1,sum(case when datepart(quarter, sale_date) = 2 then amount else 0 end) as q2,
sum(case when datepart(quarter, sale_date) = 3 then amount else 0 end) as q3,
sum(case when datepart(quarter, sale_date) = 4 then amount else 0 end) as q4,
sum(amount) as total from sales_lines group by category order by category;

select category,quarter,budget from category_budget cross apply (values
('Q1', q1),('Q2', q2),('Q3', q3),('Q4', q4)) as b(quarter, budget) order by category, quarter;

with actual_sales as (select category,concat('Q', datepart(quarter, sale_date)) as quarter,
sum(amount) as actual from sales_lines group by category, datepart(quarter, sale_date)),
budget_data as (select category,quarter,budget from category_budget cross apply (values
('Q1', q1),('Q2', q2),('Q3', q3),('Q4', q4)) as b(quarter, budget))
select b.category,b.quarter, isnull(a.actual, 0) as actual,b.budget,isnull(a.actual, 0) - b.budget as variance from budget_data b
left join actual_sales a on b.category = a.category and b.quarter = a.quarter order by b.category, b.quarter;