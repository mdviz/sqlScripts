
--Create Origin & Destination Coding
-- select c.mode, concat(c.origin,'-', c.dest) od, c.origin origin, c.dest dest, count(c.id) t_count
-- from
-- 	(select concat(a.sampn,'-', a.perno,'-', a.plano) id, lpad(b.tract10::character varying,6,'0') origin, 
-- 	lpad(a.tract10::character varying,6,'0') dest, a.mode,
-- 	from place a Inner JOIN place b ON (a.plano-1 = b.plano)
-- 	where a.sampn = b.sampn AND a.perno = b.perno) c
-- where c.mode in (5,6) 
-- group by c.mode, od
-- order by od, t_count desc
-- 
-- 

--Used to create place_od
-- select a.sampn c_sampn, a.plano c_plano, a.perno c_perno, a.mode c_mode, a.tpurp d_tpurp, b.tpurp or_tpurp, a.*
-- from place a left outer join place b on (a.plano-1 = b.plano)
-- where a.sampn = b.sampn and a.perno = b.perno;


-- drop table type8;
-- create table type8 as
-- select b.sampn bsamp, b.perno bperno, b.plano bplano, b.mode d_mode, b.o_tpurp or_tpurp, b.d_tpurp, a.* from 
-- place a, matched b, changed_trans_people c
-- where a.perno = b.perno and a.sampn = b.sampn and a.plano=b.plano and 
-- c.perno = b.perno and c.sampn = b.sampn 
-- order by b.sampn, b.perno, b.plano;
--###################################################--
--Create changed_trans_people table--
-- create table changed_trans_people  as
-- select sampn, perno, count(plano)
-- from place 
-- where tpurp = 8
-- group by sampn, perno
-- order by sampn

--###################################################--
--Find all record that have people that had no transfer, these do not need to be corrected
-- create table place_not8 as
-- select * from place 
-- where not exists (
-- select b.sampn, b.perno from changed_trans_people b
-- where place.sampn = b.sampn and place.perno = b.perno)
-- and mode is not null;
--###################################################--
-- Find all the records that have people that DO have transfers
-- drop table place_is8;
-- create table place_is8 as
-- select * from place 
-- where exists (
-- select b.sampn, b.perno from changed_trans_people b
-- where place.sampn = b.sampn and place.perno = b.perno)
-- ;-- 
-- 
-- drop table test_a;
-- create table test_a as
-- select sampn, perno, plano, tpurp, mode, city, zip from place_is8 
-- limit 27
-- ;
-- 
-- select * from test_a
-- 

select column_name from information_schema.columns where
table_name='place_not8'