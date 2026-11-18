use master;
CREATE TABLE subjects ( subject_id VARCHAR(10) PRIMARY KEY,subject_name VARCHAR(100),fee INT,max_seats INT );
INSERT INTO subjects VALUES
('S01', 'SQL Fundamentals', 4000, 30),
('S02', 'Python Programming', 5000, 30),
('S03', 'Data Visualization', 3500, 20),
('S04', 'Statistics', 3000, 25),
('S05', 'Cloud Basics', 4500, 20),
('S06', 'Machine Learning', 6000, 15);

CREATE TABLE enrollments (enrollment_id VARCHAR(10) PRIMARY KEY,student_id INT,subject_id VARCHAR(10),enroll_date DATE);
INSERT INTO enrollments VALUES
('E01', 101, 'S01', '2026-01-06'),
('E02', 101, 'S02', '2026-01-06'),
('E03', 102, 'S01', '2026-01-11'),
('E04', 103, 'S02', '2026-01-19'),
('E05', 103, 'S03', '2026-02-01'),
('E06', 104, 'S01', '2026-02-04'),
('E07', 105, 'S02', '2026-02-15'),
('E08', 105, 'S04', '2026-02-15'),
('E09', 107, 'S01', '2026-03-02'),
('E10', 107, 'S02', '2026-03-02'),
('E11', 108, 'S03', '2026-03-06'),
('E12', 109, 'S01', '2026-03-12'),
('E13', 110, 'S05', '2026-03-21'),
('E14', 112, 'S02', '2026-03-25');

select s.subject_id, s.subject_name, count(e.enrollment_id) as enrolled_students, s.max_seats - count(e.enrollment_id) as seats_left,
case when count(e.enrollment_id) >= 4 then 'High' when count(e.enrollment_id) >= 2 then 'Medium' when count(e.enrollment_id) = 1 then 'Low'
else 'No Demand' end as demand_level into subject_demand from subjects s
left join enrollments e on s.subject_id = e.subject_id where e.student_id in (select student_id from students)
or e.enrollment_id is null group by s.subject_id, s.subject_name, s.max_seats order by enrolled_students desc, s.subject_id;

drop table if exists subject_demand;

select * from subject_demand order by enrolled_students desc, subject_id;