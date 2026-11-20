use master1;
create table monthly_sales (month_start date,region varchar(20),revenue int);
insert into monthly_sales values
('2026-01-01', 'North', 120000),
('2026-02-01', 'North', 135000),
('2026-03-01', 'North', 128000),
('2026-04-01', 'North', 150000),
('2026-05-01', 'North', 160000),
('2026-06-01', 'North', 145000),
('2026-01-01', 'South', 90000),
('2026-02-01', 'South', 85000),
('2026-03-01', 'South', 110000),
('2026-04-01', 'South', 105000),
('2026-05-01', 'South', 130000),
('2026-06-01', 'South', 140000);

select region, month_start,revenue, sum(revenue) over (partition by region order by month_start) as running_total,
cast(round(avg(1.0 * revenue) over (partition by region order by month_start rows between 2 preceding and current row), 2) as decimal(10,2)) as moving_avg_3m,
cast(round( 100.0 * revenue / sum(revenue) over (partition by region), 2) as decimal(10,2)) as pct_of_total
from monthly_sales order by region, month_start;