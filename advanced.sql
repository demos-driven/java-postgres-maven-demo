-- show tables
select * from pg_catalog.pg_tables 
where schemaname not in ('pg_catalog','information_schema');

-- 视图
-- 对视图的使用是一个好的 SQL 数据库设计的关键。
-- 视图允许用户通过始终如一的接口封装表的 结构细节，可避免表结构随应用的进化而频繁改变

create view myview as
	select city, temp_lo, temp_hi, prcp, date, location
	from weather, cities
	where city = name;
	
select * from myview;

-- 外键
-- 外键可以维持数据的引用完整性

drop table weather, cities;

create table cities (
	name	text,
	population	float8,
	elevation	int
);

-- table inherit
create table capitals (
	state	char(2)
) inherits (cities);

insert into cities values
	('San Francisco', 7.24E+5, 63),
	('Las Vegas', 2.583E+5, 2174),
	('Mariposa', 1200, 1953);
	
select * from cities;

insert into capitals values
	('Sacramento', 3.694E+5, 30, 'CA'),
	('Madison', 1.913E+5, 845, 'WI');

select * from capitals;

select c.name, c.elevation
from cities c
where c.elevation > 500;

-- you must remove the children first
DROP table capitals, cities;


