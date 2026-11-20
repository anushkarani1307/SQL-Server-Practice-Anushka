create database master1;
use master1;
create table author (author_id int primary key, author_name varchar(100));
create table book (book_id int primary key,author_id int,title varchar(100),publish_year int,foreign key (author_id) references author(author_id));
create table adaptation (book_id int,type varchar(20),title varchar(100),release_year int,rating decimal(4,2),foreign key (book_id) references book(book_id));
create table book_review (review_id int primary key,book_id int,rating decimal(4,2),foreign key (book_id) references book(book_id));

insert into author values
(1, 'Anita Rao'),
(2, 'Dev Malhotra'),
(3, 'Kiran Sethi'),
(4, 'Leela Thomas');

insert into book values
(101, 1, 'The Monsoon Letters', 2015),
(102, 1, 'City of Lanterns', 2018),
(103, 2, 'Code of the Hills', 2012),
(104, 3, 'The Last Tea Garden', 2019),
(105, 4, 'Silent Harbour', 2016),
(106, 2, 'Paper Kites', 2020);

insert into adaptation values
(101, 'Movie', 'Monsoon Letters', 2017, 8.10),
(102, 'Series', 'Lanterns', 2024, 7.90),
(103, 'Movie', 'Hill Code', 2014, 7.00),
(104, 'Series', 'Tea Garden', 2022, 8.60),
(105, 'Movie', 'Harbour', 2018, 6.50),
(106, 'Movie', 'Kites', 2021, 7.40);

insert into book_review values
(1, 101, 7),
(2, 101, 8),
(3, 102, 6),
(4, 102, 7),
(5, 103, 8),
(6, 103, 7),
(7, 103, 9),
(8, 104, 8),
(9, 104, 8),
(10, 105, 6),
(11, 105, 7),
(12, 106, 7),
(13, 106, 7),
(14, 106, 7);

select
b.title as book_title, a.title as adaptation_title, a.release_year as adaptation_year, b.publish_year as publication_year,
au.author_name, cast(round(avg(r.rating), 2) as decimal(4,2)) as book_rating,
a.rating as adaptation_rating from book b join author au on b.author_id = au.author_id join adaptation a on b.book_id = a.book_id
join book_review r on b.book_id = r.book_id where a.release_year between b.publish_year and b.publish_year + 4
group by b.title, a.title,a.release_year,b.publish_year,au.author_name, a.rating having avg(r.rating) < a.rating order by b.title;