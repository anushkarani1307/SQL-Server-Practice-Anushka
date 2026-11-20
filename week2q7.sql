use master1;
create table Books (BookID int primary key, Title varchar(100));
create table Authors (AuthorID int primary key, AuthorName varchar(100));
create table BookAuthors (BookID int, AuthorID int);

insert into Books values
(1,'Desert Winds'),
(2,'River Songs'),
(3,'The Glass Fort'),
(4,'Night Train'),
(5,'Salt and Stone'),
(6,'Paper Moons');

insert into Authors values
(1,'Meera Kaul'),
(2,'Rohan Sen'),
(3,'Tanvi Bose'),
(4,'Ishita Roy');

insert into BookAuthors values
(1,1),(2,2),(3,1),(3,3),(4,4),(5,2),(6,2),(6,1);
go

create or alter view vw_book_author as select b.Title as BookTitle,string_agg(a.AuthorName, ',') within group (order by a.AuthorName) as AuthorName,
string_agg(cast(x.book_count as varchar(10)), ',') within group (order by a.AuthorName) as Book_count from Books b
join BookAuthors ba on b.BookID = ba.BookID join Authors a on ba.AuthorID = a.AuthorID
join (select AuthorID, count(*) as book_count from BookAuthors group by AuthorID) x on 
a.AuthorID = x.AuthorID group by b.BookID, b.Title;
go

select * from vw_book_author;