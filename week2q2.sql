use master1;
create table customers (customer_id varchar(10) primary key,customer_name varchar(100),city varchar(50),signup_date date);
create table orders (order_id int primary key,customer_id varchar(10),order_date date,status varchar(30),foreign key (customer_id) references customers(customer_id));
create table order_items (order_id int,product_id varchar(10),qty int,unit_price decimal(10,2),foreign key (order_id) references orders(order_id));

insert into customers values
('C01', 'Rahul Mehta', 'Jaipur', '2025-11-02'),
('C02', 'Priya Nair', 'Kochi', '2025-12-15'),
('C03', 'Arjun Das', 'Kolkata', '2026-01-08'),
('C04', 'Fatima Sheikh', 'Mumbai', '2026-01-20'),
('C05', 'Karan Malhotra', 'Delhi', '2026-02-11'),
('C06', 'Sneha Kulkarni', 'Pune', '2026-02-25');

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
(1005, 'P3', 10, 120),
(1006, 'P6', 3, 499),
(1007, 'P5', 1, 1499),
(1008, 'P4', 4, 250);

create function dbo.fn_to_USdate (@order_date date)
returns varchar(10) as begin return convert(varchar(10), @order_date, 101);
end;
select dbo.fn_to_USdate('2006-05-21');

create procedure dbo.sp_customer_orders
@customer_id varchar(10),
@order_count int output,
@total_value decimal(10,2) output as begin
set @order_count = 0; set @total_value = 0;

select o.order_id,dbo.fn_to_USdate(o.order_date) as order_date_us,
o.status,sum(i.qty + i.unit_price) as order_value from orders o 
join order_items i on o.customer_id = i.order_id where o.customer_id = @customer_id
and o.status <> 'Cancelled' group by o.order_id order by o.order_id;
select @order_count = count(*), @total_value = sum(i.qty * i.unit_price) from orders o
join order_items i on o.order_id = i.order_id where o.customer_id = @customer_id; 
end;


