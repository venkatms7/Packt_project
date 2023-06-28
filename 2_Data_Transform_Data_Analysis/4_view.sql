
--view:

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