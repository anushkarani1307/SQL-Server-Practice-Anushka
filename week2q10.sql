use master1;
create table customer_updates (load_id int primary key,customer_id varchar(10),email varchar(100),city varchar(50),updated_at datetime);
insert into customer_updates values
(1, 'C01', 'rahul@gmail.com', 'Jaipur', '2026-05-01 10:00:00'),
(2, 'C02', 'priya@gmail.com', 'Kochi', '2026-05-01 10:05:00'),
(3, 'C01', 'rahul.m@gmail.com', 'Jaipur', '2026-05-03 09:00:00'),
(4, 'C03', 'arjun@gmail.com', 'Kolkata', '2026-05-02 12:00:00'),
(5, 'C02', 'priya@gmail.com', 'Kochi', '2026-05-01 10:05:00'),
(6, 'C04', 'rahul.m2@gmail.com', 'Delhi', '2026-05-03 09:00:00'),
(7, 'C04', 'fatima@gmail.com', 'Mumbai', '2026-05-04 08:30:00'),
(8, 'C03', 'arjun.d@gmail.com', 'Kolkata', '2026-05-05 18:45:00');

with cte as (select *,row_number() over (partition by customer_id order by updated_at desc, load_id desc) as rn
from customer_updates)
select customer_id, email, city, updated_at, load_id from cte where rn = 1 order by customer_id;

with cte as (select *,row_number() over (partition by customer_id order by updated_at desc, load_id desc) as rn
from customer_updates) select count(*) as rows_loaded,sum(case when rn = 1 then 1 else 0 end) as rows_kept, sum(case when rn > 1 then 1 else 0 end) as rows_removed from cte;