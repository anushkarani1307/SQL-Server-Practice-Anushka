use master1;
create table datepro (id int, Dateint int, Datetime varchar(50));

insert into datepro values
(101, 20220510, '2022-05-10T09:30:00+05:30'),
(102, 20220227, '2022-02-27T18:45:00+05:30'),
(103, 20220925, '2022-09-25T12:16:00+05:30'),
(104, 20221229, '2022-12-29T07:05:00+05:30'),
(105, 20221228, '2022-12-28T11:29:00+05:30');

create table datepro_data (id int,Dateint int,Datetime varchar(50),Dates datetime2(0));
go

create procedure sp_dateproc @ids varchar(100) as begin ;with cte as ( select p.id,p.Dateint,p.Datetime,
cast(try_convert(datetimeoffset, p.Datetime) as datetime2) as Dates, eomonth(convert(date,
convert(varchar(8), p.Dateint))) as last_date from datepro p join string_split(@ids, ',') s on p.id = try_convert(int, s.value)
union all
select id,Dateint,Datetime,dateadd(day, 1, Dates),last_date from cte where cast(Dates as date) < last_date) 
insert into datepro_data (id, Dateint, Datetime, Dates)
select id, Dateint, Datetime, Dates from cte option (maxrecursion 0);
select id, Dateint, Datetime, Dates from datepro_data where id in (select try_convert(int, value) from string_split(@ids, ',')) order by id, Dates;
end;

exec sp_dateproc '101,102,104';
select * from datepro_data;