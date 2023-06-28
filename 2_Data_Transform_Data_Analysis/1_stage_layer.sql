

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

--imported the csv data into the stage models