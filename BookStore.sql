--create database BookStore
--use BookStore
create table Book 
(
  Isbn char(13) primary key,
  Title nvarchar(50) not null,
  Author nvarchar(50) not null,
  Edition int,
  PublishedYear int
);

insert into Book values ('2518407786529', N'The Alchemist (Nhà giả kim)', N'Paulo Coelho', 1, 2013);
insert into Book values ('6911225907262', N'Tuổi Trẻ Đáng Giá Bao Nhiêu', N'Rosie Nguyễn', 2, 2018);
insert into Book values ('2425402340697', N'Đời Ngắn Đừng Ngủ Dài', N'Robin Sharma', 2, 2014);

select * from Book;
