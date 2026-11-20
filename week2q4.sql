use master1;
create table StudentDetails
(StudentId varchar(10) primary key,StudentName varchar(50),GPA decimal(3,2),Branch varchar(10),Section varchar(5));

create table SubjectDetails
(SubjectId varchar(10) primary key,SubjectName varchar(50),MaxSeats int,RemainingSeats int);

create table StudentPreference
(StudentId varchar(10),SubjectId varchar(10),Preference int,primary key (StudentId, SubjectId),foreign key (StudentId) references StudentDetails(StudentId),
foreign key (SubjectId) references SubjectDetails(SubjectId));

create table Allotments(SubjectId varchar(10),StudentId varchar(10));
create table UnallottedStudents(StudentId varchar(10));

insert into StudentDetails values
('159103036', 'Mohit Agarwal', 8.90, 'CCE', 'A'),
('159103037', 'Rohit Agarwal', 5.20, 'CCE', 'A'),
('159103038', 'Shobhit Garg', 7.10, 'CCE', 'B'),
('159103039', 'Nirmal Malhotra', 7.90, 'CCE', 'A'),
('159103040', 'Meherneet Singh', 5.60, 'CCE', 'A'),
('159103041', 'Arjun Tehlan', 9.20, 'CCE', 'B');

insert into SubjectDetails values
('PO1491', 'Basics of Political Science', 60, 2),
('PO1492', 'Basics of Accounting', 120, 1),
('PO1493', 'Basics of Financial Markets', 90, 1),
('PO1494', 'Eco philosophy', 60, 1),
('PO1495', 'Automotive Trends', 60, 0);

insert into StudentPreference values
('159103036', 'PO1491', 1),
('159103036', 'PO1492', 2),
('159103036', 'PO1493', 3),
('159103036', 'PO1494', 4),
('159103036', 'PO1495', 5),

('159103037', 'PO1494', 1),
('159103037', 'PO1495', 2),
('159103037', 'PO1492', 3),
('159103037', 'PO1491', 4),
('159103037', 'PO1493', 5),

('159103038', 'PO1492', 1),
('159103038', 'PO1491', 2),
('159103038', 'PO1494', 3),
('159103038', 'PO1495', 4),
('159103038', 'PO1493', 5),

('159103039', 'PO1492', 1),
('159103039', 'PO1495', 2),
('159103039', 'PO1493', 3),
('159103039', 'PO1494', 4),
('159103039', 'PO1491', 5),

('159103040', 'PO1493', 1),
('159103040', 'PO1494', 2),
('159103040', 'PO1491', 3),
('159103040', 'PO1495', 4),
('159103040', 'PO1492', 5),

('159103041', 'PO1491', 1),
('159103041', 'PO1493', 2),
('159103041', 'PO1492', 3),
('159103041', 'PO1494', 4),
('159103041', 'PO1495', 5);
go 

create or alter procedure dbo.sp_allot_subjects as
begin set nocount on;
delete from Allotments;
delete from UnallottedStudents;
declare @studentid varchar(10),@subjectid varchar(10),@currentstudent varchar(10),@allotted bit = 0,@seats int;
declare cur cursor for select p.StudentId, p.SubjectId from StudentPreference p join StudentDetails s on p.StudentId = s.StudentId order by s.GPA desc, s.StudentId, p.Preference;
open cur; fetch next from cur into @studentid, @subjectid; while @@fetch_status = 0
begin if @currentstudent is null or @currentstudent <> @studentid
begin if @currentstudent is not null and @allotted = 0
insert into UnallottedStudents values (@currentstudent);
set @currentstudent = @studentid; set @allotted = 0;
end;
if @allotted = 0 begin
select @seats = RemainingSeats from SubjectDetails where SubjectId = @subjectid;
if @seats > 0 begin insert into Allotments values (@subjectid, @studentid); update SubjectDetails
set RemainingSeats = RemainingSeats - 1 where SubjectId = @subjectid set @allotted = 1;
end; 
end;
fetch next from cur into @studentid, @subjectid;
end;
if @currentstudent is not null and @allotted = 0 insert into UnallottedStudents values (@currentstudent);
close cur; deallocate cur;
exec dbo.sp_allot_subjects;
select * from Allotments;
select * from UnallottedStudents;
select * from SubjectDetails;
end;