use master1;
create table orders1 (order_id int primary key,order_value decimal(10,2),status varchar(20));
create table payments (payment_id varchar(10) primary key,order_id int,payment_date date,amount decimal(10,2),method varchar(30));
create table error_log (log_id int identity(1,1) primary key,error_time datetime default getdate(),proc_name varchar(100),error_number int,error_message varchar(500),input_values varchar(200));
insert into orders1 values
(1001, 5000, 'Active'),
(1002, 5000, 'Active'),
(1003, 1000, 'Active'),
(1004, 5000, 'Cancelled'),
(1005, 5000, 'Active'),
(1006, 5000, 'Active'),
(1009, 5000, 'Active'),
(1010, 5000, 'Cancelled');

insert into payments values
('PM01', 1001, '2026-03-02', 2198, 'UPI'),
('PM02', 1002, '2026-03-03', 1000, 'Card'),
('PM03', 1002, '2026-03-05', 999, 'Card'),
('PM04', 1003, '2026-03-10', 500, 'UPI'),
('PM05', 1005, '2026-03-15', 3998, 'NetBanking'),
('PM06', 1006, '2026-03-18', 1497, 'UPI'),
('PM07', 1009, '2026-04-02', 750, 'UPI'),
('PM08', 1004, '2026-03-12', 1499, 'Card');
go

create or alter procedure dbo.sp_record_payment @payment_id varchar(10),@order_id int,@amount decimal(10,2),@method varchar(30)
as begin set nocount on;
begin try begin transaction;
if not exists (select 1 from orders1 where order_id = @order_id) throw 50001, 'Order not found', 1;
if exists (select 1 from orders1 where order_id = @order_id and status = 'Cancelled') throw 50002, 'Order is cancelled', 1;
if @amount <= 0 throw 50003, 'Amount must be greater than zero', 1;
if @amount + isnull((select sum(amount) from payments where order_id = @order_id), 0) > (select order_value from orders1 where order_id = @order_id)
throw 50004, 'Payment exceeds order value', 1;
insert into payments values (@payment_id, @order_id, getdate(), @amount, @method);
commit transaction;
end try
begin catch
rollback transaction;
insert into error_log (proc_name, error_number, error_message, input_values) values ('sp_record_payment',error_number(),error_message(),
concat(@payment_id, ',', @order_id, ',', @amount, ',', @method));
end catch
end;

exec dbo.sp_record_payment 'PM09', 1007, 1499, 'Card';
exec dbo.sp_record_payment 'PM10', 1010, 500, 'UPI';
exec dbo.sp_record_payment 'PM11', 1004, 100, 'UPI';
exec dbo.sp_record_payment 'PM12', 1003, 0, 'UPI';
exec dbo.sp_record_payment 'PM13', 1003, 600, 'UPI';
exec dbo.sp_record_payment 'PM14', 1003, 499, 'UPI';

select * from payments;
select * from error_log;