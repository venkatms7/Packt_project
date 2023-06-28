
--Dimension
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

--Facts


--ft_stack_quest table
--drop table public.ft_stack_quest ;
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


--ft_stack_quest_unans table

--drop table public.ft_stack_quest_unans;
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
--drop table public.ft_stack_quest_new ;
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

