use master2;
create table product_master (product_id varchar(10) primary key,product_name varchar(100),price int,is_active int);
create table product_staging (product_id varchar(10),product_name varchar(100),price int,is_deleted char(1));
create table product_actions (product_id varchar(10),action varchar(10));
insert into product_master values
('P1', 'Wireless Mouse', 799, 1),
('P2', 'USB-C Hub', 1999, 1),
('P3', 'Notebook A5', 120, 1),
('P4', 'Gel Pen Pack', 250, 1);

insert into product_staging values
('P2', 'USB-C Hub 7-in-1', 2199, 'N'),
('P3', 'Notebook A5', 120, 'N'),
('P4', 'Gel Pen Pack', 250, 'Y'),
('P5', 'Desk Lamp', 1499, 'N'),
('P6', 'Water Bottle', 499, 'N');

merge into product_master as t using product_staging as s on t.product_id = s.product_id
when matched and s.is_deleted = 'Y' then delete
when matched and s.is_deleted = 'N' and (t.product_name <> s.product_name or t.price <> s.price) then
update set t.product_name = s.product_name, t.price = s.price
when not matched by target and s.is_deleted = 'N' then insert 
(product_id, product_name, price, is_active) values (s.product_id, s.product_name, s.price, 1)
output coalesce(inserted.product_id, deleted.product_id),$action into product_actions (product_id, action);

select * from product_master order by product_id;
select * from product_actions order by product_id;

