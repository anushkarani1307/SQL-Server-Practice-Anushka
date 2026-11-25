use master2;
create table CustomerDim (CustomerID int,CustomerName varchar(100),Address varchar(100),EffectiveStartDate date,EffectiveEndDate date,IsCurrent bit);
insert into CustomerDim values
(1, 'John Doe', '123 Main St', '2023-01-01', '9999-12-31', 1),
(2, 'Alice Johnson', '456 Elm St', '2023-01-01', '9999-12-31', 1),
(3, 'Bob Smith', '789 Oak St', '2023-01-01', '9999-12-31', 1);
go

create trigger trg_dim on CustomerDim instead of insert as begin set nocount on;
update CustomerDim set EffectiveEndDate = '2026-09-30',IsCurrent = 0 where CustomerID in 
(select CustomerID from inserted) and IsCurrent = 1;
insert into CustomerDim select CustomerID, CustomerName, Address,
'2026-10-01',
'9999-12-31',1 from inserted; end;

insert into CustomerDim values
(1, 'John Doe', 'Ajmer', '2026-10-01', '9999-12-31', 1),
(2, 'Alice Johnson', 'Ajmer', '2026-10-01', '9999-12-31', 1),
(3, 'Bob Smith', 'Chennai', '2026-10-01', '9999-12-31', 1),
(4, 'David Richard', 'Mumbai', '2026-10-01', '9999-12-31', 1),
(5, 'Eva Dsouza', 'Mumbai', '2026-10-01', '9999-12-31', 1);

select * from CustomerDim order by CustomerID, EffectiveStartDate;
