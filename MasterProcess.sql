--Survey Processing Codes --
--################################################################--
--CONSTRUCT GEOID TAGS
Update GEOID in Place Table
alter table place add column geoid_md character varying;
update place set geoid_md = 
concat(state10, lpad(county10::character varying,3,'0'),
lpad(tract10::character varying,6,'0'), block10) 

select a.taz, a.geoid10, b.geoid_md, b.sampn, b.plano, b.perno
from geoid_sumtaz a, place b
where a.geoid10 = b.geoid_md

--################################################################--
--Remove all trips that are not in the model area
/*table geoidsumtaz was created by intersecting census block centroids with
the model 986 TAZ file in ArcMap, the attribute table was then exported to ms Access
and imported into Postgres. This table can then be linked to the GEOID constructed in 
the previous step.*/
--################################################################--

--Create a Table of all Persons that had at least one tpurp = 8
create table changed_trans_people  as
select sampn, perno, count(plano)
from place 
where tpurp = 8
group by sampn, perno
order by sampn

--################################################################--
--Find all record that have people that had no transfer, these do not need to be corrected
create table place_not8 as
select * from place 
where not exists (
select b.sampn, b.perno from changed_trans_people b
where place.sampn = b.sampn and place.perno = b.perno);

--################################################################--
-- Find all the records that have people that DO have transfers
drop table place_is8;
create table place_is8 as
select * from place 
where exists (
select b.sampn, b.perno from changed_trans_people b
where place.sampn = b.sampn and place.perno = b.perno)
--################################################################--
--Below are households that had a person where the last trip of their day 
--was a tpurp = 8. Python code was updated to remove such trips, there were only
--14 trips. 

select m.sampn, m.perno, m.placeno, a.tpurp, a.state
from place a,
(select sampn, perno, max(plano) placeno
from place
group by sampn, perno) m
where a.sampn = m.sampn and a.perno = m.perno and a.plano = m.placeno
and tpurp = 8
order by tpurp

select * from place
where sampn in (2455754,
7554457,
2081315,
2455754,
2030933,
7560201,
2036433,
2101929,
2092564,
2139445,
2133948,
2028020,
2423986,
2043849)


/*
At this point we must process the trip purpose 8 peoples trips,
if they have a tpurp = 8 or a series of them we collapse those down
until the first trip purpose before 8 and the first trip purpose after
8 are linked. We record all the intervening modes.

In python prcoess place_is8 and then export table to csv.

Then re-import the csv file into postgres via ms_access.

once imported we then append the processed trips to the trips that
do not have any trip purpose 8.

*/
--Alter the table that was not processed to match the one that has been
-- So the append will be successful
alter table place_not8 add column cmode1 smallint;
alter table place_not8 add column cmode2 smallint;
alter table place_not8 add column cmode3 smallint;
alter table place_not8 add column cmode4 smallint;
alter table place_not8 add column cmode5 smallint;
alter table place_not8 add column cmode6 smallint;
alter table place_not8 add column cmode7 smallint;
alter table place_not8 add column cmode8 smallint;
alter table place_not8 add column cmode9 smallint;
alter table place_not8 add column cmode10 smallint;
--
select column_name from information_schema.columns where
table_name='place_not8'


--################################################################--

--Correct Column Order from Processed Tablecreate table pro8 as EXPAND-->
	select
	sampn,
	perno,
	plano,
	tpurp,
	tpur2,
	o_tpurp,
	o_tpur2,
	mode,
	o_mode,
	tottr,
	hhmem,
	per1,
	per2,
	per3,
	per4,
	per5,
	nonhh,
	vehno,
	prkty,
	o_prkty,
	ploc,
	prklc,
	prkcs,
	o_prkcs,
	prkun,
	prkhw,
	epark,
	toll,
	tollt,
	tolle,
	tollx,
	tollc,
	hov,
	mode2,
	fare,
	o_fare,
	route,
	arr_hr,
	arr_min,
	dep_hr,
	dep_min,
	trpdur,
	actdur,
	city,
	state,
	zip,
	town_id,
	town,
	state10,
	county10,
	cousub10,
	tract10,
	blkgrp10,
	block10,
	puma10,
	pwgt,
	exppwgt,
	geoid_md,
	cmode1,
	cmode2,
	cmode3,
	cmode4,
	cmode5,
	cmode6,
	cmode7,
	cmode8,
	cmode9,
	cmode10
	from processed_is8;
--################################################################--


--################################################################--

--Access automatically changes some column types so script below will correct column types EXPAND -->

	alter table pro8 alter column actdur type  bigint using actdur::bigint;
	alter table pro8 alter column arr_hr type  bigint using arr_hr::bigint;
	alter table pro8 alter column arr_min type  bigint using arr_min::bigint;
	alter table pro8 alter column blkgrp10 type  bigint using blkgrp10::bigint;
	alter table pro8 alter column block10 type  bigint using block10::bigint;
	alter table pro8 alter column city type  character varying using city::character varying;
	alter table pro8 alter column cmode1 type  bigint using cmode1::bigint;
	alter table pro8 alter column cmode10 type  bigint using cmode10::bigint;
	alter table pro8 alter column cmode2 type  bigint using cmode2::bigint;
	alter table pro8 alter column cmode3 type  bigint using cmode3::bigint;
	alter table pro8 alter column cmode4 type  bigint using cmode4::bigint;
	alter table pro8 alter column cmode5 type  bigint using cmode5::bigint;
	alter table pro8 alter column cmode6 type  bigint using cmode6::bigint;
	alter table pro8 alter column cmode7 type  bigint using cmode7::bigint;
	alter table pro8 alter column cmode8 type  bigint using cmode8::bigint;
	alter table pro8 alter column cmode9 type  bigint using cmode9::bigint;
	alter table pro8 alter column county10 type  bigint using county10::bigint;
	alter table pro8 alter column cousub10 type  numeric using cousub10::numeric;
	alter table pro8 alter column dep_hr type  bigint using dep_hr::bigint;
	alter table pro8 alter column dep_min type  bigint using dep_min::bigint;
	alter table pro8 alter column epark type  double precision using epark::double precision;
	alter table pro8 alter column exppwgt type  double precision using exppwgt::double precision;
	alter table pro8 alter column fare type  double precision using fare::double precision;
	alter table pro8 alter column geoid_md type  character varying using geoid_md::character varying;
	alter table pro8 alter column hhmem type  bigint using hhmem::numeric;
	alter table pro8 alter column hov type  character varying using hov::character varying;
	alter table pro8 alter column mode type  numeric using mode::numeric;
	alter table pro8 alter column mode2 type  double precision using mode2::double precision;
	alter table pro8 alter column nonhh type  numeric using nonhh::numeric;
	alter table pro8 alter column o_fare type  character varying using o_fare::character varying;
	alter table pro8 alter column o_mode type  character varying using o_mode::character varying;
	alter table pro8 alter column o_prkcs type  character varying using o_prkcs::character varying;
	alter table pro8 alter column o_prkty type  character varying using o_prkty::character varying;
	alter table pro8 alter column o_tpur2 type  character varying using o_tpur2::character varying;
	alter table pro8 alter column o_tpurp type  character varying using o_tpurp::character varying;
	alter table pro8 alter column per1 type  numeric using per1::numeric;
	alter table pro8 alter column per2 type  numeric using per2::numeric;
	alter table pro8 alter column per3 type  numeric using per3::numeric;
	alter table pro8 alter column per4 type  numeric using per4::numeric;
	alter table pro8 alter column per5 type  numeric using per5::numeric;
	alter table pro8 alter column perno type  numeric using perno::numeric;
	alter table pro8 alter column plano type  double precision using plano::double precision;
	alter table pro8 alter column ploc type  numeric using ploc::numeric;
	alter table pro8 alter column prkcs type  double precision using prkcs::double precision;
	alter table pro8 alter column prkhw type  double precision using prkhw::double precision;
	alter table pro8 alter column prklc type  character varying using prklc::character varying;
	alter table pro8 alter column prkty type  double precision using prkty::double precision;
	alter table pro8 alter column prkun type  double precision using prkun::double precision;
	alter table pro8 alter column puma10 type  character varying using puma10::character varying;
	alter table pro8 alter column pwgt type  double precision using pwgt::double precision;
	alter table pro8 alter column route type  character varying using route::character varying;
	alter table pro8 alter column sampn type  numeric using sampn::numeric;
	alter table pro8 alter column state type  character varying using state::character varying;
	alter table pro8 alter column state10 type  bigint using state10::numeric;
	alter table pro8 alter column toll type  double precision using toll::double precision;
	alter table pro8 alter column tollc type  double precision using tollc::double precision;
	alter table pro8 alter column tolle type  double precision using tolle::double precision;
	alter table pro8 alter column tollt type  double precision using tollt::double precision;
	alter table pro8 alter column tollx type  double precision using tollx::double precision;
	alter table pro8 alter column tottr type  numeric using tottr::numeric;
	alter table pro8 alter column town type  character varying using town::character varying;
	alter table pro8 alter column town_id type  bigint using town_id::bigint;
	alter table pro8 alter column tpur2 type  numeric using tpur2::numeric;
	alter table pro8 alter column tpurp type  bigint using tpurp::bigint;
	alter table pro8 alter column tract10 type  numeric using tract10::numeric;
	alter table pro8 alter column trpdur type  bigint using trpdur::numeric;
	alter table pro8 alter column vehno type  bigint using vehno::numeric;
	alter table pro8 alter column zip type  character varying using zip::character varying;
--################################################################--


--Once updated the tables can be Unioned 
create table up_place as
(select * from pro8 
union
select * from place_not8)

--################################################################--
--UNIONING the Fixed Place 8 Tables Stuff
--################################################################--

-- alter table place_not8 add column cmode1 bigint;
-- alter table place_not8 add column cmode2 bigint;
-- alter table place_not8 add column cmode3 bigint;
-- alter table place_not8 add column cmode4 bigint;
-- alter table place_not8 add column cmode5 bigint;
-- alter table place_not8 add column cmode6 bigint;
-- alter table place_not8 add column cmode7 bigint;
-- alter table place_not8 add column cmode8 bigint;
-- alter table place_not8 add column cmode9 bigint;
-- alter table place_not8 add column cmode10 bigint;
-- 
-- select column_name from information_schema.columns where
-- table_name='place_not8';

-- select column_name from information_schema.columns where
-- table_name='place_is8processed'

-- drop view vt;
-- create view vt as(
-- select sampn,perno,plano,tpurp,tpur2::integer, from place_is8processed 
-- union 
-- select sampn,perno, plano,tpurp,tpur2 from v_not8 )

-- select * from vt
-- order by sampn, perno, plano


-- select column_name, data_type
-- from information_schema.columns
-- where table_schema = 'public' and table_name = 'place'
-- group by column_name, data_type 
-- order by column_name

alter table place_is8processed alter column actdur type  bigint using actdur::bigint;
alter table place_is8processed alter column arr_hr type  bigint using arr_hr::bigint;
alter table place_is8processed alter column arr_min type  bigint using arr_min::bigint;
alter table place_is8processed alter column blkgrp10 type  bigint using blkgrp10::bigint;
alter table place_is8processed alter column block10 type  bigint using block10::bigint;
alter table place_is8processed alter column city type  character varying using city::character varying;
alter table place_is8processed alter column cmode1 type  bigint using cmode1::bigint;
alter table place_is8processed alter column cmode10 type  bigint using cmode10::bigint;
alter table place_is8processed alter column cmode2 type  bigint using cmode2::bigint;
alter table place_is8processed alter column cmode3 type  bigint using cmode3::bigint;
alter table place_is8processed alter column cmode4 type  bigint using cmode4::bigint;
alter table place_is8processed alter column cmode5 type  bigint using cmode5::bigint;
alter table place_is8processed alter column cmode6 type  bigint using cmode6::bigint;
alter table place_is8processed alter column cmode7 type  bigint using cmode7::bigint;
alter table place_is8processed alter column cmode8 type  bigint using cmode8::bigint;
alter table place_is8processed alter column cmode9 type  bigint using cmode9::bigint;
alter table place_is8processed alter column county10 type  bigint using county10::bigint;
alter table place_is8processed alter column cousub10 type  integer using cousub10::integer;
alter table place_is8processed alter column dep_hr type  bigint using dep_hr::bigint;
alter table place_is8processed alter column dep_min type  bigint using dep_min::bigint;
alter table place_is8processed alter column epark type  double precision using epark::double precision;
alter table place_is8processed alter column exppwgt type  double precision using exppwgt::double precision;
alter table place_is8processed alter column fare type  double precision using fare::double precision;
alter table place_is8processed alter column geoid_md type  character varying using geoid_md::character varying;
alter table place_is8processed alter column hhmem type  bigint using hhmem::bigint;
alter table place_is8processed alter column hov type  character varying using hov::character varying;
alter table place_is8processed alter column mode type  integer using mode::integer;
alter table place_is8processed alter column mode2 type  double precision using mode2::double precision;
alter table place_is8processed alter column nonhh type  integer using nonhh::integer;
alter table place_is8processed alter column o_fare type  character varying using o_fare::character varying;
alter table place_is8processed alter column o_mode type  character varying using o_mode::character varying;
alter table place_is8processed alter column o_prkcs type  character varying using o_prkcs::character varying;
alter table place_is8processed alter column o_prkty type  character varying using o_prkty::character varying;
alter table place_is8processed alter column o_tpur2 type  character varying using o_tpur2::character varying;
alter table place_is8processed alter column o_tpurp type  character varying using o_tpurp::character varying;
alter table place_is8processed alter column per1 type  integer using per1::integer;
alter table place_is8processed alter column per2 type  integer using per2::integer;
alter table place_is8processed alter column per3 type  integer using per3::integer;
alter table place_is8processed alter column per4 type  integer using per4::integer;
alter table place_is8processed alter column per5 type  integer using per5::integer;
alter table place_is8processed alter column perno type  integer using perno::integer;
alter table place_is8processed alter column plano type  double precision using plano::double precision;
alter table place_is8processed alter column ploc type  integer using ploc::integer;
alter table place_is8processed alter column prkcs type  double precision using prkcs::double precision;
alter table place_is8processed alter column prkhw type  double precision using prkhw::double precision;
alter table place_is8processed alter column prklc type  character varying using prklc::character varying;
alter table place_is8processed alter column prkty type  double precision using prkty::double precision;
alter table place_is8processed alter column prkun type  double precision using prkun::double precision;
alter table place_is8processed alter column puma10 type  character varying using puma10::character varying;
alter table place_is8processed alter column pwgt type  double precision using pwgt::double precision;
alter table place_is8processed alter column route type  character varying using route::character varying;
alter table place_is8processed alter column sampn type  integer using sampn::integer;
alter table place_is8processed alter column state type  character varying using state::character varying;
alter table place_is8processed alter column state10 type  bigint using state10::bigint;
alter table place_is8processed alter column toll type  double precision using toll::double precision;
alter table place_is8processed alter column tollc type  double precision using tollc::double precision;
alter table place_is8processed alter column tolle type  double precision using tolle::double precision;
alter table place_is8processed alter column tollt type  double precision using tollt::double precision;
alter table place_is8processed alter column tollx type  double precision using tollx::double precision;
alter table place_is8processed alter column tottr type  integer using tottr::integer;
alter table place_is8processed alter column town type  character varying using town::character varying;
alter table place_is8processed alter column town_id type  bigint using town_id::bigint;
alter table place_is8processed alter column tpur2 type  integer using tpur2::integer;
alter table place_is8processed alter column tpurp type  bigint using tpurp::bigint;
alter table place_is8processed alter column tract10 type  integer using tract10::integer;
alter table place_is8processed alter column trpdur type  bigint using trpdur::bigint;
alter table place_is8processed alter column vehno type  bigint using vehno::bigint;
alter table place_is8processed alter column zip type  character varying using zip::character varying;



--################################################################--
--Now we need create the OD trip purpose table
--First we need to create a new plano id number, since they are no longer sequential, 
--for example if plano=3 was a tpurp = 8, then plano-3 was removed. So we need a new
--set of sequential numbers. 

alter table up_place add column seq serial;

create view v_up_place as 
SELECT *, row_number() OVER (PARTITION BY sampn, perno ORDER BY seq)
from up_place; 

create table place_new as
	select
	sampn,
	perno,
	plano,
	row_number new_plano,
	tpurp,
	tpur2,
	o_tpurp,
	o_tpur2,
	mode,
	o_mode,
	tottr,
	hhmem,
	per1,
	per2,
	per3,
	per4,
	per5,
	nonhh,
	vehno,
	prkty,
	o_prkty,
	ploc,
	prklc,
	prkcs,
	o_prkcs,
	prkun,
	prkhw,
	epark,
	toll,
	tollt,
	tolle,
	tollx,
	tollc,
	hov,
	mode2,
	fare,
	o_fare,
	route,
	arr_hr,
	arr_min,
	dep_hr,
	dep_min,
	trpdur,
	actdur,
	city,
	state,
	zip,
	town_id,
	town,
	state10,
	county10,
	cousub10,
	tract10,
	blkgrp10,
	block10,
	puma10,
	pwgt,
	exppwgt,
	geoid_md,
	cmode1,
	cmode2,
	cmode3,
	cmode4,
	cmode5,
	cmode6,
	cmode7,
	cmode8,
	cmode9,
	cmode10
		from v_up_place;

--Start populationg other variables
/*Copy the values in geoid_md into a new column d_geoid just to match the column o_geoid in the next step.*/
--Create Origin & Destination Coding
(select  b.tpurp or_tpurp, a.tpurp d_tpurp, a.*, b.geoid_md o_geoid
from place_new2 a, place_new2 b 
where  a.new_plano-1 = b.new_plano and a.sampn = b.sampn and a.perno = b.perno 
order by a.sampn, a.perno, a.plano);


create table place_oda as
select * from w_place_od1 
alter table place_oda add column d_taz character(4);
alter table place_oda add column o_taz character(4);
alter table place_oda add column hh_geoid character varying;
alter table place_oda add column hh_taz character(4);

--Get Destination TAZ
update place_oda as a
set d_taz = b.taz
from geoid_sumtaz as b
where a.d_geoid = b.geoid10;

--Get Origin TAZ
update place_oda as a
set o_taz = b.taz
from geoid_sumtaz as b
where a.o_geoid = b.geoid10;

--Get HH Location (GEOID)
update place_oda as a
set hh_geoid = b.geoid_md
from hh as b
where a.sampn = b.sampn;

--Get HH TAZ
update place_oda as a
set hh_taz = b.taz
from geoid_sumtaz  as b
where a.hh_geoid = b.geoid10;

--Add Train Skim Data
alter table place_oda add column tr_tot_tt numeric;
alter table place_oda add column tr_ivtt numeric;
alter table place_oda add column tr_walk_tt numeric;
alter table place_oda add column tr_wait_tt numeric;
alter table place_oda add column tr_xfer_wt numeric;
alter table place_oda add column tr_dist numeric;
alter table place_oda add column tr_fares numeric;
alter table place_oda add column tt_faremin numeric;
alter table place_oda add column tr_noxfer numeric;
alter table place_oda add column tr_distwalk numeric;

--Update Train Data
update place_oda as a
set 
tr_tot_tt = b.tot_tim,
tr_ivtt = b.ivtt,
tr_walk_tt = b.walk_tt,
tr_wait_tt = b.wait_tt,
tr_xfer_wt = b.xfer_wt,
tr_dist = b.dist,
tr_fares = b.fares,
tt_faremin = b.faremin,
tr_noxfer = b.noxfer,
tr_distwalk = b.distwalk
from train_skim2010 as b
where a.o_taz::smallint  = b.origin and a.d_taz::smallint  = b.dest

--Add Auto Skim Data
alter table place_oda add column auto_am_tt numeric;
alter table place_oda add column auto_dist numeric;

update place_oda as a
set 
auto_am_tt = b.amtime,
auto_dist = b.dist
from auto_skim2010 as b
where a.o_taz::smallint  = b.origin and a.d_taz::smallint = b.dest;

--Add Bus Skim Data
alter table place_oda add column bus_tot_tt numeric;
alter table place_oda add column bus_ivtt numeric;
alter table place_oda add column bus_walk_tt numeric;
alter table place_oda add column bus_wait_tt numeric;
alter table place_oda add column bus_xfer_wt numeric;
alter table place_oda add column bus_dist numeric;
alter table place_oda add column bus_fares numeric;
alter table place_oda add column bus_faremin numeric;
alter table place_oda add column bus_noxfer numeric;
alter table place_oda add column bus_distwalk numeric;

--Update Bus Data
update place_oda as a
set 
bus_tot_tt = b.tot_time,
bus_ivtt = b.ivtt,
bus_walk_tt = b.walk_tt,
bus_wait_tt = b.wait_tt,
bus_xfer_wt = b.xfer_wt,
bus_dist = b.dist,
bus_fares = b.fares,
bus_faremin = b.faremin,
bus_noxfer = b.noxfer,
bus_distwalk = b.distwalk
from bus_skim2010 as b
where a.o_taz::smallint  = b.origin and a.d_taz::smallint  = b.dest
--******************************************--
-- Trip Purpose Coding
--******************************************--

--Add Column to recode 2010 trip purposes to 1991 trip purposes
alter table place_oda add column o_purp91 integer;
alter table place_oda add column d_purp91 integer;

--###### UPDATE TRIP PURPOSE 2010 to 1991 VALUES ######--  
update place_oda
set o_purp91 = case 
when (or_tpurp in (1,2)) then 1
when (or_tpurp in (9,10)) then 2
when (or_tpurp in (3, 4, 5)) then 3
when (or_tpurp = 12) then 4
when (or_tpurp in (6, 7)) then 5
when (or_tpurp in (14, 15)) then 6
when (or_tpurp in (20, 23)) then 7
when (or_tpurp in (21, 22)) then 8
when (or_tpurp = 18) then 9
when (or_tpurp in (13,16,17,19)) then 10
else  -1
end;

update place_oda 
set d_purp91 = case 
when (d_tpurp in (1,2)) then 1
when (d_tpurp in (9,10)) then 2
when (d_tpurp in (3, 4, 5)) then 3
when (d_tpurp = 12) then 4
when (d_tpurp in (6, 7)) then 5
when (d_tpurp in (14, 15)) then 6
when (d_tpurp in (20, 23)) then 7
when (d_tpurp in (21, 22)) then 8
when (d_tpurp = 18) then 9
when (d_tpurp in (13,16,17,19)) then 10
else  -1
end;

--Add a Trip Purpose Text Description 
alter table place_oda add column o_desc91 character varying;
alter table place_oda add column d_desc91 character varying;

update place_oda as a
set 
o_desc91 = b.desc91
from trip_purpose as b
where a.o_purp91 = tpurp91;

update place_oda as a
set 
d_desc91 = b.desc91
from trip_purpose as b
where a.d_purp91 = tpurp91;


--Add & Code Trip Classification
alter table place_oda add column trip_class character varying;

update place_oda 
set trip_class = case 
when (o_purp91 = 1 and d_purp91 = 3 OR d_purp91 = 3 and o_purp91 = 1) then 'HBW'
when (o_purp91 = 3 )

--******************************************--
-- UPDATE TO GENERAL TRIP PURPOSES (HBW, etc)s
--******************************************--


--###### UPDATE TRIP PURPOSE 2010 to 1991 VALUES ######--  
--Export to csv
copy place_od2 to 'C:/Users/mdo/Desktop/Trash/pg_exort.csv' delimiter '|' csv header;

--Add Skim values--update place_oda add column train_tt numeric;
-- select a.*, b.tot_tim tr_tot_tt, b.ivtt tr_ivtt, b.walk_tt tr_walk_tt, b.wait_tt tr_wait_tt, b.xfer_wt tr_xfer_wt, b.dist tr_dist, 
-- b.fares tr_fares, b.faremin tt_faremin, b.noxfer tr_noxfer, b.distwalk tr_distwalk
-- from place_oda a, bus_skim2010 b
-- where a.o_taz::smallint  = b.origin and a.d_taz::smallint  = b.dest

--Add Skim values
update place_oda as i
set 
bus_tot_tt = j.tot_time,
bus_ivtt = j.ivtt,
bus_walk_tt = j.walk_tt,
bus_wait_tt = j.wait_tt,
bus_xfer_wt = j.xferwt,
bus_dist = j.dist,
bus_fares = j.fares,
bus_faremin = j.faremin,
bus_noxfer = j.noxfer,
bus_distwalk = j.distwalk 
from bus_skim2010 as j
where i.o_taz::smallint  = j.origin and i.d_taz::smallint  = j.dest


--I created a excel sheet of trip purpose OD combos from the 1991 transcad files(MHDTRIPW)
--to get a general trip purpose classification. I then imported this into postgres via
-- MS Access, and code below updates the table. This classification can be used for 
--segmentation for different models. 

alter table place_oda add column gen_purp text;

update place_oda a
set gen_purp = b.purp
from gen_purp b
where a.o_purp91 = b.o_purp and a.d_purp91 = b.d_purp;

--Also update cmode1 to be equal to mode where there were not multiple modes
-- this way we can ignore mode field from here on 
update place_oda set cmode1 = mode 
where cmode1 is null;

--#################################################################
-- Import taz2010 into msAccess then export to Postgres, then lower case columns with code below
create table column_commands as 
SELECT array_to_string(ARRAY(SELECT 'ALTER TABLE ' || quote_ident(c.table_schema) || '.'
  || quote_ident(c.table_name) || ' RENAME "' || c.column_name || '" TO ' || quote_ident(lower(c.column_name)) || ';'
  FROM information_schema.columns As c
  WHERE c.table_schema NOT IN('information_schema', 'pg_catalog') 
      AND c.column_name <> lower(c.column_name) and table_name = 'taz2010'
  ORDER BY c.table_schema, c.table_name, c.column_name
  ) , 
   E'\r') As ddlsql;


--################################################################
-- Add new fields
alter table place_oda add column choice character(50);
alter table place_oda add column desc_choice character(50);
alter table place_oda add column captive smallint;
alter table place_oda add column mp_income numeric;
alter table place_oda add column frst_tr_or smallint;

--################################################################
--I processed multiple mode trips in python - see multiple_mode.py - for updating single modes
--into a choice field the code below was used:
--#Choice Rules
update place_oda 
set choice = case
	when (cmode1 = 1 and (cmode2 is null or cmode2 = 0)) then 'walk'
	when (cmode1 = 2 and (cmode2 is null or cmode2 = 0)) then 'Bike'
	when (cmode1 = 3 and (cmode2 is null or cmode2 = 0)) then 'SOV'
	when (cmode1 = 4 and (cmode2 is null or cmode2 = 0)) then 'Autopax'
	when (cmode1 = 10 and (cmode2 is null or cmode2 = 0)) then 'Schoolbus'
	when (cmode1 = 5 and (cmode2 is null or cmode2 = 0)) then 'WA_Bus'
	when (cmode1 = 6 and (cmode2 is null or cmode2 = 0)) then 'WA_Train'
	when (cmode1 = 7 and (cmode2 is null or cmode2 = 0)) then 'WA_Mix'
	when (choice is null and (cmode2 is null or cmode2 = 0)) then 'NA1'
end;


--After importing the multiple_mode_choice table from python
--update the choice column
update place_oda as i
set 
choice = j.choice
from multiple_mode_transit_or3 as j
where i.sampn = j.sampn and i.perno = j.perno and i.new_plano = j.new_plano

--update desc_choice column
update place_oda as i
set 
desc_choice = j.desc_choice
from multiple_mode_transit_or3 as j
where i.sampn = j.sampn and i.perno = j.perno and i.new_plano = j.new_plano


--Summary Code-- 
select choice, count(*) as c
from place_oda 
group by choice
order by choice 

--Add the transit origin plano
update place_oda as i
set 
frst_tr_or = j.frst_tr_or
from multiple_mode_transit_or  as j
where i.sampn = j.sampn and i.perno = j.perno and i.plano= j.plano

--Now add the transit origin geoid & TAZ
alter table place_oda add column frst_tr_gid character(30);
alter table place_oda add column frst_tr_taz character(4);
		--and then retreive the value for that geoid 
		--FIRST GEOID
update place_oda as i
set 
frst_tr_gid = j.geoid_md
from place  as j
where i.sampn = j.sampn and i.perno = j.perno and i.frst_tr_or = j.plano
		--SECOND TAZ
update place_oda as i
set 
frst_tr_taz = j.taz
from geoid_sumtaz  as j
where i.frst_tr_gid = j.geoid10 


--DISTRIBUTION OF Distances From o_taz to frst_tr_taz((
	select a.sampn, a.perno, a.plano, a.o_taz, a.frst_tr_taz, a.o_taz = a.frst_tr_taz, b.dist
	from place_oda a, auto_skim2010 b
	where frst_tr_taz is not null and a.o_taz::smallint = b.origin and a.frst_tr_taz::smallint = b.dest))
--Then update the multiple mode choice trips First Transit Trip 
--Field. First though, let us add the taz assignment to that multiple_mode_transit_or table(exported from python to access -> postgres)
alter table multiple_mode_transit_or add column o_taz 

--Update mp_income column
update place_oda set mp_income = case
when (income = 1) then 7500
when (income = 2) then 20000
when (income = 3) then 30000
when (income = 4) then 42500
when (income = 5) then 62500
when (income = 6) then 87500
when (income = 7) then 125000
when (income = 8) then 175000
when (income = 99) then -1
end;


--##########################################################################################
--##########################################################################################
--##########################################################################################
--##########################################################################################
--##########################################################################################
--##########################################################################################
--##########################################################################################
--##########################################################################################

--Create Output Table || NOTE some fields are calculated in this query --
create table output_testA as
select 
a.sampn, 
a.perno, 
a.plano, 
a.new_plano, 
a.tpurp, 
a.or_tpurp,
o_purp91, 
a.d_tpurp, 
a.o_desc91,
a.d_desc91,
gen_purp,
b.hhsiz,
b.hhveh,
b.hisp,
b.resty,
b.own,
b.income,
case
when (b.income = 1) then 7500
when (b.income = 2) then 20000
when (b.income = 3) then 30000
when (b.income = 4) then 42500
when (b.income = 5) then 62500
when (b.income = 6) then 87500
when (b.income = 7) then 125000
when (b.income = 8) then 175000
when (b.income = 99) then -1
end mp_income,
b.hhlic,
b.hhwrk,
CASE when b.hhwrk = 0 then 0 else b.hhveh/b.hhwrk end vehpwrk,
b.hhveh/b.hhsiz vehpper,
b.hhwrk/b.hhsiz wrkpper,
a.trpdur,
a.actdur,
a.city,
a.state,
a.zip,
a.town_id,
a.town,
a.cmode1,
a.cmode2,
a.cmode3,
a.cmode4,
a.cmode5,
a.cmode6,
a.cmode7,
a.cmode8,
a.cmode9,
auto_am_tt,
auto_dist,
pt_tot_tt,
pt_ivtt,
pt_walk_tt,
pt_wait_tt,
pt_xfer_wt,
pt_dist,
pt_fares,
pt_faremin,
pt_noxfer,
pt_distwalk,
tr_tot_tt,
tr_ivtt,
tr_walk_tt,
tr_wait_tt,
tr_xfer_wt,
tr_dist,
tr_fares,
tr_faremin,
tr_noxfer,
tr_distwalk,
bus_tot_tt,
bus_ivtt,
bus_walk_tt,
bus_wait_tt,
bus_xfer_wt,
bus_dist,
bus_fares,
bus_faremin,
bus_noxfer,
bus_distwalk,
bus_av,
train_av,
pt_av,
d_geoid,
o_geoid,
d_taz,
o_taz,
hh_geoid,
hh_taz,
choice, 
captive
from place_oda a, hh b
where a.sampn = b.sampn and
o_taz is not null and d_taz is not null and hh_taz is not null
and o_taz <> d_taz;

COPY (SELECT * from output_testA) TO 'C:\Users\mdo\Desktop\RA\Summer2014\ModeChoiceProject\August18andon\output_testA.csv' DELIMITER ',' CSV HEADER;



