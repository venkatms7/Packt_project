
DROP TABLE IF EXISTS public.stg_stack_quest;
CREATE TABLE IF NOT EXISTS public.stg_stack_quest
(
    "user" character varying(200) ,
    votes character varying(100) ,
    tags character varying(555) ,
    date character varying(125) 
)
;
DROP TABLE IF EXISTS public.stg_stack_quest_unans;
CREATE TABLE IF NOT EXISTS public.stg_stack_quest_unans
(
    "user" character varying(200) ,
    votes character varying(100) ,
    tags character varying(555) ,
    date character varying(125) 
)
;
DROP TABLE IF EXISTS public.stg_stack_quest_new;
CREATE TABLE IF NOT EXISTS public.stg_stack_quest_new
(
    "user" character varying(200) ,
    votes character varying(100) ,
    tags character varying(555) ,
    date character varying(125) 
)
;
SELECT count(*) FROM public.stg_stack_quest;
SELECT count(*) FROM public.stg_stack_quest_unans ;
SELECT count(*) FROM public.stg_stack_quest_new ;

--select substring("date",1,strpos("date",' at')) as create_date FROM public.stg_stack_quest;
--select replace(trim(replace(substring("date",1,strpos("date",' at')),', ','-')),' ','-') FROM public.stg_stack_quest;
/*
select trim("user") as users
,cast(votes as integer) as votes
,initcap(tags) as tags
,case when tags ilike '%python%' then 1 else 0 end as python
,case when tags ilike '%javascript%' then 1 else 0 end as javascript
,case when tags ilike '%java%' then 1 else 0 end as java
,case when tags ilike '%c%' then (case when lower(substring(tags,strpos(tags,'c#'),2)) = 'c#' then 1 else 0 end) else 0 end as "c#"
,case when tags ilike '%html%' then 1 else 0 end as html
,case when tags ilike '%php%' then 1 else 0 end as php
,case when tags ilike '%android%' then 1 else 0 end as android
,case when tags ilike '%jquery%' then 1 else 0 end as jquery
,case when tags ilike '%c%' then (case when lower(substring(tags,strpos(tags,'c++'),3)) = 'c++' then 1 else 0 end) else 0 end as "c++"
,case when tags ilike '%css%' then 1 else 0 end as css
,case when tags ilike '%ios%' then 1 else 0 end as ios
,case when tags ilike '%sql%' then 1 else 0 end as "sql"
,case when tags ilike '% r %' then 1 else 0 end as r
,case when tags ilike '%mysql%' then 1 else 0 end as mysql
,case when tags ilike '%json%' then 1 else 0 end as "json"
,case when tags ilike '%git%' then 1 else 0 end as "git"
,"date"
,'25-06-2023'::date download_date
, case when "date" ilike '%days ago%' then 'Jul-23-2023'
		when "date" ilike '%ago%' then 'Jul-25-2023'
		when "date" ilike '%yesterday%' then 'Jul-24-2023'
		else replace(trim(replace(substring("date",1,strpos("date",' at')),', ','-')),' ','-') end as create_date
FROM public.stg_stack_quest_new ;

select extract(month from DATE '2020-12-12');
select concat("year","month","day") as dates 
	from (select case length(replace(trim(substring("date",strpos("date",'-'),3)),'-','')) 
			when 1 then concat('0',replace(trim(substring("date",strpos("date",'-'),3)),'-','')) 
			else replace(trim(substring("date",strpos("date",'-'),3)),'-','') end as "day"
		,case left(lower("a"."date"),3) when 'jan' then '01' when 'feb' then '02' when 'mar' then '03'
				   when 'apr' then '04' when 'may' then '05' when 'jun' then '06'
				   when 'jul' then '07' when 'aug' then '08' when 'sep' then '09'
				   when 'oct' then '10' when 'nov' then '11' when 'dec' then '12' end "month"
		,case length(right("date",4)) when 4 then right("date",4) when 2 then CONCAT('20',right("date",2)) end as "year"
				   FROM ( select replace(trim(replace(substring("date",1,strpos("date",' at')),', ','-')),' ','-') as "date"
						 from public.stg_stack_quest) as "a" ) z;
						 select current_date-('2023-06-25');*/

--USERS

create table public.dm_users as
select 10000+row_number() over () as user_id,
coalesce(b.users,'') users
from (
select trim("user") users
from public.stg_stack_quest
union
select trim("user") users
from public.stg_stack_quest_unans
union
select trim("user") users
from public.stg_stack_quest_new
order by users) as b;

select * from public.dm_users limit 10;


--ft_stack_quest table
drop table public.ft_stack_quest ;
create table public.ft_stack_quest as
select trim("user") as users
,cast(votes as integer) as votes
,initcap(tags) as tags
,case when tags ilike '%python%' then 1 else 0 end as python
,case when tags ilike '%javascript%' then 1 else 0 end as javascript
,case when tags ilike '%java%' then 1 else 0 end as java
,case when tags ilike '%c%' then (case when lower(substring(tags,strpos(tags,'c#'),2)) = 'c#' then 1 else 0 end) else 0 end as "c#"
,case when tags ilike '%html%' then 1 else 0 end as html
,case when tags ilike '%php%' then 1 else 0 end as php
,case when tags ilike '%android%' then 1 else 0 end as android
,case when tags ilike '%jquery%' then 1 else 0 end as jquery
,case when tags ilike '%c%' then (case when lower(substring(tags,strpos(tags,'c++'),3)) = 'c++' then 1 else 0 end) else 0 end as "c++"
,case when tags ilike '%css%' then 1 else 0 end as css
,case when tags ilike '%ios%' then 1 else 0 end as ios
,case when tags ilike '%sql%' then 1 else 0 end as "sql"
,case when tags ilike '% r %' then 1 else 0 end as r
,case when tags ilike '%mysql%' then 1 else 0 end as mysql
,case when tags ilike '%json%' then 1 else 0 end as "json"
,case when tags ilike '%git%' then 1 else 0 end as "git"
,'25-06-2023'::date download_date
, case when "date" ilike '%days ago%' then 'Jul-23-2023'
		when "date" ilike '%ago%' then 'Jul-25-2023'
		when "date" ilike '%yesterday%' then 'Jul-24-2023'
		else replace(trim(replace(substring("date",1,strpos("date",' at')),', ','-')),' ','-') end as create_date
,'Popularity' as "based_on"
FROM public.stg_stack_quest;

select * from public.ft_stack_quest limit 100;

--ft_stack_quest_unans table
drop table public.ft_stack_quest_unans;
create table public.ft_stack_quest_unans as
select trim("user") as users
,cast(votes as integer) as votes
,initcap(tags) as tags
,case when tags ilike '%python%' then 1 else 0 end as python
,case when tags ilike '%javascript%' then 1 else 0 end as javascript
,case when tags ilike '%java%' then 1 else 0 end as java
,case when tags ilike '%c%' then (case when lower(substring(tags,strpos(tags,'c#'),2)) = 'c#' then 1 else 0 end) else 0 end as "c#"
,case when tags ilike '%html%' then 1 else 0 end as html
,case when tags ilike '%php%' then 1 else 0 end as php
,case when tags ilike '%android%' then 1 else 0 end as android
,case when tags ilike '%jquery%' then 1 else 0 end as jquery
,case when tags ilike '%c%' then (case when lower(substring(tags,strpos(tags,'c++'),3)) = 'c++' then 1 else 0 end) else 0 end as "c++"
,case when tags ilike '%css%' then 1 else 0 end as css
,case when tags ilike '%ios%' then 1 else 0 end as ios
,case when tags ilike '%sql%' then 1 else 0 end as "sql"
,case when tags ilike '% r %' then 1 else 0 end as r
,case when tags ilike '%mysql%' then 1 else 0 end as mysql
,case when tags ilike '%json%' then 1 else 0 end as "json"
,case when tags ilike '%git%' then 1 else 0 end as "git"
,'25-06-2023'::date download_date
, case when "date" ilike '%days ago%' then 'Jul-23-2023'
		when "date" ilike '%ago%' then 'Jul-25-2023'
		when "date" ilike '%yesterday%' then 'Jul-24-2023'
		else replace(trim(replace(substring("date",1,strpos("date",' at')),', ','-')),' ','-') end as create_date
,'Unanswered' as "based_on"
FROM public.stg_stack_quest_unans;

--ft_stack_quest_new table
drop table public.ft_stack_quest_new ;
create table public.ft_stack_quest_new as
select trim("user") as users
,cast(votes as integer) as votes
,initcap(tags) as tags
,case when tags ilike '%python%' then 1 else 0 end as python
,case when tags ilike '%javascript%' then 1 else 0 end as javascript
,case when tags ilike '%java%' then 1 else 0 end as java
,case when tags ilike '%c%' then (case when lower(substring(tags,strpos(tags,'c#'),2)) = 'c#' then 1 else 0 end) else 0 end as "c#"
,case when tags ilike '%html%' then 1 else 0 end as html
,case when tags ilike '%php%' then 1 else 0 end as php
,case when tags ilike '%android%' then 1 else 0 end as android
,case when tags ilike '%jquery%' then 1 else 0 end as jquery
,case when tags ilike '%c%' then (case when lower(substring(tags,strpos(tags,'c++'),3)) = 'c++' then 1 else 0 end) else 0 end as "c++"
,case when tags ilike '%css%' then 1 else 0 end as css
,case when tags ilike '%ios%' then 1 else 0 end as ios
,case when tags ilike '%sql%' then 1 else 0 end as "sql"
,case when tags ilike '% r %' then 1 else 0 end as r
,case when tags ilike '%mysql%' then 1 else 0 end as mysql
,case when tags ilike '%json%' then 1 else 0 end as "json"
,case when tags ilike '%git%' then 1 else 0 end as "git"
,'25-06-2023'::date download_date
, case when "date" ilike '%days ago%' then 'Jul-23-2023'
		when "date" ilike '%ago%' then 'Jul-25-2023'
		when "date" ilike '%yesterday%' then 'Jul-24-2023'
		else replace(trim(replace(substring("date",1,strpos("date",' at')),', ','-')),' ','-') end as create_date
,'Newest' as "based_on"
FROM public.stg_stack_quest_new;


--aggregate table
--drop table public.agg_stack cascade;
create table public.agg_stack as
select user_ids
,users
,total_votes
,all_tags
,python
,javascript
,java
,"c#"
,html
,php
,android
,jquery
,"c++"
,css
,ios
,"sql"
,r
,mysql
,"json"
,"git"
,"month"
,"day"
,"year"
,downloaded_date
,created_date
,"type"
from
(select user_id as user_ids
,trim(usr."users") as users
,cast(votes as integer) as total_votes
,tags as all_tags
,sum(python) as python
,sum(javascript) as javascript
,sum(java) as java
,sum("c#") as "c#"
,sum(html) as html
,sum(php) as php
,sum(android) as android
,sum(jquery) as jquery
,sum("c++") as "c++"
,sum(css) as css
,sum(ios) as ios
,sum("sql") as "sql"
,sum(r) as r
,sum(mysql) as mysql
,sum("json") as "json"
,sum("git") as "git"
,case left(lower(create_date),3) when 'jan' then '01' when 'feb' then '02' when 'mar' then '03'
				   when 'apr' then '04' when 'may' then '05' when 'jun' then '06'
				   when 'jul' then '07' when 'aug' then '08' when 'sep' then '09'
				   when 'oct' then '10' when 'nov' then '11' when 'dec' then '12' end "month"
,case length(replace(trim(substring("create_date",strpos("create_date",'-'),3)),'-','')) 
				when 1 then concat('0',replace(trim(substring("create_date",strpos("create_date",'-'),3)),'-','')) 
				else replace(trim(substring("create_date",strpos("create_date",'-'),3)),'-','') end as "day"
,case when length(substring(create_date,strpos(create_date,'-'))) > 4 then right(create_date,4)
 		when length(substring(create_date,strpos(create_date,'-'))) < 1 then ''
 		when length(substring(create_date,strpos(create_date,'-'))) < 4 then '2023' end as "year"
,download_date as downloaded_date
,create_date as created_date
,"based_on" as "type"
FROM public.dm_users usr
left join public.ft_stack_quest stq
on usr.users = stq.users
where tags is not null
group by user_ids, usr.users, total_votes, all_tags, "month", "day", "year", downloaded_date,created_date, "type"

union all

select user_id as user_ids
,trim(usr."users") as users
,cast(votes as integer) as total_votes
,tags as all_tags
,sum(python) as python
,sum(javascript) as javascript
,sum(java) as java
,sum("c#") as "c#"
,sum(html) as html
,sum(php) as php
,sum(android) as android
,sum(jquery) as jquery
,sum("c++") as "c++"
,sum(css) as css
,sum(ios) as ios
,sum("sql") as "sql"
,sum(r) as r
,sum(mysql) as mysql
,sum("json") as "json"
,sum("git") as "git"
,case left(lower(create_date),3) when 'jan' then '01' when 'feb' then '02' when 'mar' then '03'
				   when 'apr' then '04' when 'may' then '05' when 'jun' then '06'
				   when 'jul' then '07' when 'aug' then '08' when 'sep' then '09'
				   when 'oct' then '10' when 'nov' then '11' when 'dec' then '12' end "month"
,case length(replace(trim(substring("create_date",strpos("create_date",'-'),3)),'-','')) 
				when 1 then concat('0',replace(trim(substring("create_date",strpos("create_date",'-'),3)),'-','')) 
				else replace(trim(substring("create_date",strpos("create_date",'-'),3)),'-','') end as "day"
,case when length(substring(create_date,strpos(create_date,'-'))) > 4 then right(create_date,4)
 		when length(substring(create_date,strpos(create_date,'-'))) < 1 then ''
 		when length(substring(create_date,strpos(create_date,'-'))) < 4 then '2023' end as "year"
,download_date as downloaded_date
,create_date as created_date
,"based_on" as "type"
FROM public.dm_users usr
left join public.ft_stack_quest_unans stquna
on usr.users = stquna.users
where tags is not null
group by user_ids, usr.users, total_votes, all_tags, "month", "day", "year", downloaded_date, created_date, "type"

union all

select user_id as user_ids
,trim(usr."users") as users
,cast(votes as integer) as total_votes
,tags as all_tags
,sum(python) as python
,sum(javascript) as javascript
,sum(java) as java
,sum("c#") as "c#"
,sum(html) as html
,sum(php) as php
,sum(android) as android
,sum(jquery) as jquery
,sum("c++") as "c++"
,sum(css) as css
,sum(ios) as ios
,sum("sql") as "sql"
,sum(r) as r
,sum(mysql) as mysql
,sum("json") as "json"
,sum("git") as "git"
,case left(lower(create_date),3) when 'jan' then '01' when 'feb' then '02' when 'mar' then '03'
				   when 'apr' then '04' when 'may' then '05' when 'jun' then '06'
				   when 'jul' then '07' when 'aug' then '08' when 'sep' then '09'
				   when 'oct' then '10' when 'nov' then '11' when 'dec' then '12' end "month"
,case length(replace(trim(substring("create_date",strpos("create_date",'-'),3)),'-','')) 
				when 1 then concat('0',replace(trim(substring("create_date",strpos("create_date",'-'),3)),'-','')) 
				else replace(trim(substring("create_date",strpos("create_date",'-'),3)),'-','') end as "day"
,case when length(substring(create_date,strpos(create_date,'-'))) > 4 then right(create_date,4)
 		when length(substring(create_date,strpos(create_date,'-'))) < 1 then ''
 		when length(substring(create_date,strpos(create_date,'-'))) < 4 then '2023' end as "year"
,download_date as downloaded_date
,create_date as created_date
,"based_on" as "type"
FROM public.dm_users usr
left join public.ft_stack_quest_new stqnew
on usr.users = stqnew.users
where tags is not null
group by user_ids, usr.users, total_votes, all_tags, "month", "day", "year", downloaded_date, created_date, "type") tab1
order by user_ids;


--view
--DROP VIEW public.v_stack_quest;
create or replace view public.v_stack_quest
as select user_ids
,users
,total_votes
,all_tags
,python
,javascript
,java
,"c#"
,html
,php
,android
,jquery
,"c++"
,css
,ios
,"sql"
,r
,mysql
,"json"
,"git"
,("day"||'-'||"month"||'-'||"year")::date as "date"
,"month"
,"day"
,"year"
,downloaded_date
,created_date
,"type"
from public.agg_stack;
/*
select user_ids
,users
,total_votes
,all_tags
,python
,javascript
,java
,"c#"
,html
,php
,android
,jquery
,"c++"
,css
,ios
,"sql"
,r
,mysql
,"json"
,"git"
,"date"
,cast("month" as int)
,cast("day" as int)
,cast("year" as int)
,downloaded_date
,created_date
,"type"
from public.v_stack_quest
where "date" >= '2023-06-01' and "date" <= current_date::date;


select ('25'||'-05-'||'2000')::date;


SELECT
  EXTRACT(YEAR FROM "date") AS "year",
  COUNT(*) AS Number_of_Questions,
  ROUND(100 * SUM(case when (python+javascript+java+"c#"+html+php+android+jquery+"c++"+css+ios+"sql"+r+mysql+"json"+"git") > 0 then 1
					 else 0 end) / COUNT(*), 1) AS Percent_of_tags
FROM  public.v_stack_quest
where "type" in ('Popularity', 'Unanswered', 'Newest')
group by  EXTRACT(YEAR FROM "date")
having EXTRACT(YEAR FROM "date") > 2007 and EXTRACT(YEAR FROM "date") <2024
ORDER BY  "year";
*/


--Top Trending Tags
select "year", "month_name", tag, total, "rank" from 
(select *, dense_rank() over (partition by "year", month_name order by total desc) as "rank" 
from
(select EXTRACT(YEAR FROM "date") AS "year", substring("created_date",1,3) "month_name",'Python' tag, sum(python) total
from public.v_stack_quest
 where "type" in ('Newest')
group by EXTRACT(YEAR FROM "date"), month_name
union 
select EXTRACT(YEAR FROM "date") AS "year", substring("created_date",1,3) "month_name",'Javascript' tag, sum(javascript) total
from public.v_stack_quest
 where "type" in ('Newest')
group by EXTRACT(YEAR FROM "date"), month_name
union
select EXTRACT(YEAR FROM "date") AS "year", substring("created_date",1,3) "month_name",'Java' tag, sum(java) total
from public.v_stack_quest
 where "type" in ('Newest')
group by EXTRACT(YEAR FROM "date"), month_name
union
select EXTRACT(YEAR FROM "date") AS "year", substring("created_date",1,3) "month_name",'C#' tag, sum("c#") total
from public.v_stack_quest
 where "type" in ('Newest')
group by EXTRACT(YEAR FROM "date"), month_name
union
select EXTRACT(YEAR FROM "date") AS "year", substring("created_date",1,3) "month_name",'HTML' tag, sum("html") total
from public.v_stack_quest
 where "type" in ('Newest')
group by EXTRACT(YEAR FROM "date"), month_name
union
select EXTRACT(YEAR FROM "date") AS "year", substring("created_date",1,3) "month_name",'PHP' tag, sum("php") total
from public.v_stack_quest
 where "type" in ('Newest')
group by EXTRACT(YEAR FROM "date"), month_name
union
select EXTRACT(YEAR FROM "date") AS "year", substring("created_date",1,3) "month_name",'Android' tag, sum("android") total
from public.v_stack_quest
 where "type" in ('Newest')
group by EXTRACT(YEAR FROM "date"), month_name
union
select EXTRACT(YEAR FROM "date") AS "year", substring("created_date",1,3) "month_name",'JQuery' tag, sum("jquery") total
from public.v_stack_quest
 where "type" in ('Newest')
group by EXTRACT(YEAR FROM "date"), month_name
union
select EXTRACT(YEAR FROM "date") AS "year", substring("created_date",1,3) "month_name",'C++' tag, sum("c++") total
from public.v_stack_quest
 where "type" in ('Newest')
group by EXTRACT(YEAR FROM "date"), month_name
union
select EXTRACT(YEAR FROM "date") AS "year", substring("created_date",1,3) "month_name",'CSS' tag, sum("css") total
from public.v_stack_quest
 where "type" in ('Newest')
group by EXTRACT(YEAR FROM "date"), month_name
union
select EXTRACT(YEAR FROM "date") AS "year", substring("created_date",1,3) "month_name",'ios' tag, sum("ios") total
from public.v_stack_quest
 where "type" in ('Newest')
group by EXTRACT(YEAR FROM "date"), month_name
union
select EXTRACT(YEAR FROM "date") AS "year", substring("created_date",1,3) "month_name",'SQL' tag, sum("sql") total
from public.v_stack_quest
 where "type" in ('Newest')
group by EXTRACT(YEAR FROM "date"), month_name
union
select EXTRACT(YEAR FROM "date") AS "year", substring("created_date",1,3) "month_name",'R' tag, sum("r") total
from public.v_stack_quest
 where "type" in ('Newest')
group by EXTRACT(YEAR FROM "date"), month_name
union
select EXTRACT(YEAR FROM "date") AS "year", substring("created_date",1,3) "month_name",'MySQL' tag, sum("mysql") total
from public.v_stack_quest
 where "type" in ('Newest')
group by EXTRACT(YEAR FROM "date"), month_name
union
select EXTRACT(YEAR FROM "date") AS "year", substring("created_date",1,3) "month_name",'JSON' tag, sum("json") total
from public.v_stack_quest
 where "type" in ('Newest')
group by EXTRACT(YEAR FROM "date"), month_name
union
select EXTRACT(YEAR FROM "date") AS "year", substring("created_date",1,3) "month_name",'Git' tag, sum("git") total
from public.v_stack_quest
 where "type" in ('Newest')
group by EXTRACT(YEAR FROM "date"), month_name) tab1
where 
cast("year" as int) in (select extract(YEAR from current_date))
 and cast(case lower(month_name) when 'jan' then '01' when 'feb' then '02' when 'mar' then '03'
				   when 'apr' then '04' when 'may' then '05' when 'jun' then '06'
				   when 'jul' then '07' when 'aug' then '08' when 'sep' then '09'
				   when 'oct' then '10' when 'nov' then '11' when 'dec' then '12' end as int) in 
 						(select extract(MONTH from current_date) union select 6
						)
) tab2
where "rank" < 4;


--
/*
select "year", "month", sum(python) python, sum(javascript) javascript, sum(java) java, sum("c#") "c#"
		,sum(html) html, sum(php) php, sum(android) android, sum(jquery) jquery, sum("c++") "c++", sum(css) css, sum(ios) ios
		, sum("sql") "sql", sum(r) r, sum(mysql) mysql, sum("json") "json", sum("git") git
from public.v_stack_quest 
where "type" in ('Newest') and cast("month" as int) in (select extract(MONTH from current_date)) 
		and cast("year" as int) in (select extract(YEAR from current_date))
group by "year", "month";
*/


--Top Users with votes ranked
select users, total_votes, "rank" from 
(select *, dense_rank() over (order by total_votes desc) as "rank" 
from
(select users, sum(total_votes) total_votes
from public.v_stack_quest
where "type" in ('Popularity')
group by users) tab1
) tab2
where "rank" < 6;