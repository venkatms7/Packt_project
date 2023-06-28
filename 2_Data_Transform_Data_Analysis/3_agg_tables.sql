

--Aggregate table

--agg_stack
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
