use master;
create table customers (
customer_id varchar(10) primary key,
customer_name varchar(100),
city varchar(50),
signup_date date );

create table products (
product_id varchar(10) primary key,
product_name varchar(100),
category varchar(50),
unit_price int);

create table orders (
order_id int primary key,
customer_id varchar(10),
order_date date,
status varchar(30),
foreign key (customer_id) references customers(customer_id));

create table order_items (
order_id int,
product_id varchar(10),
qty int,
unit_price int,
primary key (order_id, product_id),
foreign key (order_id) references orders(order_id),
foreign key (product_id) references products(product_id));

create table payments (
payment_id varchar(10) primary key,
order_id int,
payment_date date,
amount int,
method varchar(30));

insert into customers values
('C01', 'Rahul Mehta', 'Jaipur', '2025-11-02'),
('C02', 'Priya Nair', 'Kochi', '2025-12-15'),
('C03', 'Arjun Das', 'Kolkata', '2026-01-08'),
('C04', 'Fatima Sheikh', 'Mumbai', '2026-01-20'),
('C05', 'Karan Malhotra', 'Delhi', '2026-02-11'),
('C06', 'Sneha Kulkarni', 'Pune', '2026-02-25');

insert into products values
('P1', 'Wireless Mouse', 'Electronics', 799),
('P2', 'USB-C Hub', 'Electronics', 1999),
('P3', 'Notebook A5', 'Stationery', 120),
('P4', 'Gel Pen Pack', 'Stationery', 250),
('P5', 'Desk Lamp', 'Home', 1499),
('P6', 'Water Bottle', 'Home', 499);

insert into orders values
(1001, 'C01', '2026-03-02', 'Delivered'),
(1002, 'C02', '2026-03-03', 'Delivered'),
(1003, 'C01', '2026-03-10', 'Delivered'),
(1004, 'C03', '2026-03-12', 'Cancelled'),
(1005, 'C04', '2026-03-15', 'Shipped'),
(1006, 'C05', '2026-03-18', 'Delivered'),
(1007, 'C01', '2026-04-01', 'Shipped'),
(1008, 'C06', '2026-04-03', 'Pending');

insert into order_items values
(1001, 'P1', 2, 799),
(1001, 'P3', 5, 120),
(1002, 'P2', 1, 1999),
(1003, 'P4', 2, 250),
(1003, 'P6', 1, 499),
(1004, 'P5', 1, 1499),
(1005, 'P1', 1, 799),
(1005, 'P2', 1, 1999),
(1006, 'P3', 10, 120),
(1006, 'P6', 3, 499),
(1007, 'P5', 1, 1499),
(1008, 'P4', 4, 250);


insert into payments values
('PM01', 1001, '2026-03-02', 2198, 'UPI'),
('PM02', 1002, '2026-03-03', 1000, 'Card'),
('PM03', 1002, '2026-03-05', 999, 'Card'),
('PM04', 1003, '2026-03-10', 500, 'UPI'),
('PM05', 1005, '2026-03-15', 3998, 'NetBanking'),
('PM06', 1006, '2026-03-18', 1497, 'UPI'),
('PM07', 1009, '2026-04-02', 750, 'UPI'),
('PM08', 1004, '2026-03-12', 1499, 'Card');