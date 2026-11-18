use master;
drop table if exists monthly_revenue;

select convert(varchar(7), payment_date, 120) as pay_month,
count(case when status = 'Success' then 1 end) as successful_payments,
sum(case when status = 'Success' then amount else 0 end) as total_revenue,
avg(case when status = 'Success' then amount end) as avg_payment,
sum(case when status <> 'Success' or status is null then 1 else 0 end) as other_payments
into monthly_revenue from fee_payments group by convert(varchar(7), payment_date, 120) having sum(case when status = 'Success' then amount else 0 end) >= 15000;

select * from monthly_revenue order by pay_month;

drop table if exists subject_revenue;

select s.subject_name, sum(p.amount) as total_revenue into subject_revenue from subjects s
join fee_payments p on s.subject_id = p.subject_id where p.status = 'Success' group by s.subject_name having sum(p.amount) > 8000;

select * from subject_revenue order by total_revenue desc;