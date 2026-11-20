use master1;
create table logins (user_id varchar(10),login_date date);
insert into logins values
('U1', '2026-03-01'),
('U1', '2026-03-02'),
('U1', '2026-03-03'),
('U1', '2026-03-05'),
('U1', '2026-03-06'),
('U1', '2026-03-07'),
('U2', '2026-03-01'),
('U2', '2026-03-03'),
('U2', '2026-03-04'),
('U2', '2026-03-05'),
('U2', '2026-03-08'),
('U3', '2026-03-10'),
('U3', '2026-03-02'),
('U4', '2026-03-01'),
('U4', '2026-03-02'),
('U4', '2026-03-03'),
('U4', '2026-03-04'),
('U4', '2026-03-05'),
('U4', '2026-03-08'),
('U4', '2026-03-09');

with cte as (select *,dateadd(day, -row_number() over (partition by user_id order by login_date), login_date) as grp
from logins),streaks as (select user_id,min(login_date) as streak_start,max(login_date) as streak_end,count(*) as streak_days
from cte group by user_id, grp),ranked as (select *,row_number() over (partition by user_id order by streak_days desc, streak_end desc) as rn
from streaks) select user_id,streak_start,streak_end,streak_days from ranked where rn = 1 order by user_id;