use master;
create table crm_customers (customer_id varchar(10), email varchar(100));
create table billing_customers (customer_id varchar(10),email varchar(100));


insert into crm_customers values
('C01', 'rahul.mehta@gmail.com'),
('C02', 'priya.nair@gmail.com'),
('C02', 'priya.nair@gmail.com'),
('C03', 'arjun.das@gmail.com'),
('C04', 'fatima.s@gmail.com');

insert into billing_customers values
('C02', 'priya.nair@gmail.com'),
('C04', 'fatima.s@gmail.com'),
('C05', 'karan.m@gmail.com'),
('C06', 'sneha.k@gmail.com');

select customer_id, email from crm_customers intersect select customer_id, email from billing_customers;
select customer_id, email from crm_customers except select customer_id, email from billing_customers;
select customer_id, email from billing_customers except select customer_id, email from crm_customers;

select (select count(*) from (
select customer_id, email from crm_customers union select customer_id, email from billing_customers) as a) as union_rows,
(select count(*) from (select customer_id, email from crm_customers union all select customer_id, email from billing_customers) as b) as union_all_rows;
