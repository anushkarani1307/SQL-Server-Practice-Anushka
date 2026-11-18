use master;
drop table if exists payment_reconciliation;

create table orders1 (
order_id int primary key,
order_status varchar(30),
order_value int);

create table payment_reconciliation (
payment_id varchar(10),
order_id int,
paid_amount int);

insert into orders1 values
(1001, 'Delivered', 999),
(1002, 'Shipped', 1499),
(1003, 'Delivered', 999),
(1004, 'Cancelled', 1499),
(1007, 'Shipped', 1499),
(1008, 'Pending', 1000);

insert into payment_reconciliation values
('M01', 1001, 999),
('M02', 1002, 1499),
('M03', 1003, 500),
('M04', 1004, 1499),
('M07', 1009, 750);

select isnull(o.order_id, p.order_id) as order_id,
o.order_status,o.order_value, isnull(p.paid_amount, 0) as paid_amount,
case
when o.order_id is null then 'Unknown Order'
when o.order_status = 'Cancelled' then 'Refund Required'
when p.order_id is null then 'Payment Missing'
when p.paid_amount < o.order_value then 'Short Paid'
end as recon_status from orders1 o full outer join payment_reconciliation p on o.order_id = p.order_id where
o.order_id is null
or o.order_status = 'Cancelled'
or p.order_id is null
or p.paid_amount < o.order_value order by order_id;