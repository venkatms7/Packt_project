--analysis


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