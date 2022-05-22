-- show tables
select * from pg_catalog.pg_tables 
where schemaname not in ('pg_catalog','information_schema');

-- create table
create table weather (
	city	varchar(80),
	temp_lo	int,
	temp_hi	int,
	prcp	real,	-- real 单精度浮点数
	date	date
);

create table cities (
	name	varchar(80),
	location	point
);

-- int
-- smallint
-- real
-- double precision
-- char(N)
-- varchar(N)
-- date
-- time
-- timestamp
-- interval
-- 其他通用功能类型和丰富的几何类型


select * from weather;

insert into weather (city, temp_lo, temp_hi, prcp, date)
 	values ('San Francisco', 43, 57, 0.25, '1994-11-29');

insert into weather (date, city, temp_hi, temp_lo)
	values ('1994-11-29', 'Hayward', 54, 37);
	
-- 导入sql文件，类似于 mysql 的 source file
copy weather
from '~/workspace/compass/dip/java-postgres-maven-demo'
(DELIMITER(','));
	
update weather set prcp = 0.25 where city = 'San Francisco';

delete from weather;

select city, (temp_hi + temp_lo) / 2 as temp_avg, date from weather;

select * from weather where city = 'San Francisco' and prcp > 0.0;

select distinct city, prcp from weather order by prcp desc;

insert into cities values ('San Francisco', '(-194.0, 53.0)');

delete from cities where name = 'San Francisco';

select * from cities;

select * from weather join cities on city = name;

select city, temp_lo, temp_hi, prcp, date, location
	from weather join cities on city = name;

select 
	weather.city, weather.temp_lo, weather.temp_hi, weather.date,
	cities.location
from weather join cities on weather.city = cities.name;

select max(temp_lo) from weather;

select city from weather 
	where temp_lo = (select max(temp_lo) from weather);
	
select city, max(temp_lo) from weather
	where city like 'H%' 	  -- where在分组和聚集计算之前选取输入行，它控制哪些行进入聚集计算，
						 	  -- 因此where子句不能包含聚集函数
	group by city
	having max(temp_lo) < 40; -- having 在分组和聚集之后选取分组行，常常包含聚集函数，
							  -- 如果不包含聚集函数的查询放在where子句更有效
	
update weather
	set temp_hi = temp_hi - 2,
		temp_lo = temp_lo - 2
	where date > '1994-11-28';

-- 清空表数据
truncate table weather, cities;

-- 移除表结构
-- drop table weather, cities;
