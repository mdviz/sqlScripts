-- select * from walk_skim2010 where origin = dest
-- 
-- --Update the Walk Values
-- update place_oda as a
-- set 
-- walktime = b.walktime,
-- walkdist = b.dist
-- from walk_skim2010 as b
-- where a.o_taz::smallint  = b.origin and a.d_taz::smallint = b.dest;
-- 
-- update place_oda set auto_am_tt = null;
-- 
-- select * from place_oda limit 100;



--CLEAR PREVIOUS Values
update place_oda set auto_am_tt = null where auto_am_tt is not null;
update place_oda set auto_dist = null where auto_dist is not null;
update place_oda set walktime = null where walktime is not null;
update place_oda set walkdist = null where walkdist is not null;
update place_oda set biketime = null where biketime is not null;
--Clear PT VALUES
update place_oda set pt_tot_tt = null where pt_tot_tt is not null;
update place_oda set pt_ivtt = null where pt_ivtt is not null;
update place_oda set pt_walk_tt = null where pt_walk_tt is not null;
update place_oda set pt_wait_tt = null where pt_wait_tt is not null;
update place_oda set pt_xfer_wt = null where pt_xfer_wt is not null;
update place_oda set pt_dist = null where pt_dist is not null;
update place_oda set pt_fares = null where pt_fares is not null;
update place_oda set pt_faremin = null where pt_faremin is not null;
update place_oda set pt_noxfer = null where pt_noxfer is not null;
update place_oda set pt_distwalk = null where pt_distwalk is not null;
--CLEAR TRAIN VALUES
update place_oda set tr_tot_tt = null where tr_tot_tt is not null;
update place_oda set tr_ivtt = null where tr_ivtt is not null;
update place_oda set tr_walk_tt = null where tr_walk_tt is not null;
update place_oda set tr_wait_tt = null where tr_wait_tt is not null;
update place_oda set tr_xfer_wt = null where tr_xfer_wt is not null;
update place_oda set tr_dist = null where tr_dist is not null;
update place_oda set tr_fares = null where tr_fares is not null;
update place_oda set tr_faremin = null where tr_faremin is not null;
update place_oda set tr_noxfer = null where tr_noxfer is not null;
update place_oda set tr_distwalk = null where tr_distwalk is not null;
--CLEAR BUS VALUES
update place_oda set bus_tot_tt = null where bus_tot_tt is not null;
update place_oda set bus_ivtt = null where bus_ivtt is not null;
update place_oda set bus_walk_tt = null where bus_walk_tt is not null;
update place_oda set bus_wait_tt = null where bus_wait_tt is not null;
update place_oda set bus_xfer_wt = null where bus_xfer_wt is not null;
update place_oda set bus_dist = null where bus_dist is not null;
update place_oda set bus_fares = null where bus_fares is not null;
update place_oda set bus_faremin = null where bus_faremin is not null;
update place_oda set bus_noxfer = null where bus_noxfer is not null;
update place_oda set bus_distwalk = null where bus_distwalk is not null;
--CLEAR DAT VALUES
update place_oda set dat_am_tt = null where dat_am_tt is not null;
update place_oda set dat_dist = null where dat_dist is not null;
update place_oda set dat_tot_tt = null where dat_tot_tt is not null;
update place_oda set dat_ivtt = null where dat_ivtt is not null;
update place_oda set dat_walk_tt = null where dat_walk_tt is not null;
update place_oda set dat_wait_tt = null where dat_wait_tt is not null;
update place_oda set dat_xfer_wt = null where dat_xfer_wt is not null;
update place_oda set dat_trdist = null where dat_trdist is not null;
update place_oda set dat_fares = null where dat_fares is not null;
update place_oda set dat_faremin = null where dat_faremin is not null;
update place_oda set dat_noxfer = null where dat_noxfer is not null;
update place_oda set dat_distwalk = null where dat_distwalk is not null;


--REGEX Search example = b\.[^>.]+,

--Update the Auto Values
update place_oda as a
set 
auto_am_tt = b.amtime,
auto_dist = b.dist
from auto_skim2010 as b
where a.o_taz::smallint  = b.origin and a.d_taz::smallint = b.dest;

--Update the Walk Values
update place_oda as a
set 
walktime = b.walktime,
walkdist = b.dist
from walk_skim2010 as b
where a.o_taz::smallint  = b.origin and a.d_taz::smallint = b.dest;

--Update the Bike Values
update place_oda set biketime = walktime/3.0;

--Update the PT Values
update place_oda as a
set 
pt_tot_tt = b.tot_time,
pt_ivtt = b.ivtt,
pt_walk_tt = b.walk_tt,
pt_wait_tt = b.wait_tt,
pt_xfer_wt = b.xferwt,
pt_dist = b.dist,
pt_fares = b.fares,
pt_faremin = b.faremin,
pt_noxfer = b.noxfer,
pt_distwalk = b.distwalk
from pt_skim2010 as b
where a.o_taz::smallint  = b.origin and a.d_taz::smallint  = b.dest;

--Update the Train Values
update place_oda as a
set 
tr_tot_tt = b.tot_tim,
tr_ivtt = b.ivtt,
tr_walk_tt = b.walk_tt,
tr_wait_tt = b.wait_tt,
tr_xfer_wt = b.xfer_wt,
tr_dist = b.dist,
tr_fares = b.fares,
tr_faremin = b.faremin,
tr_noxfer = b.noxfer,
tr_distwalk = b.distwalk
from train_skim2010 as b
where a.o_taz::smallint  = b.origin and a.d_taz::smallint  = b.dest;

--Update the Bus Values
update place_oda as a
set 
bus_tot_tt = b.tot_time,
bus_ivtt = b.ivtt,
bus_walk_tt = b.walk_tt,
bus_wait_tt = b.wait_tt,
bus_xfer_wt = b.xferwt,
bus_dist = b.dist,
bus_fares = b.fares,
bus_faremin = b.faremin,
bus_noxfer = b.noxfer,
bus_distwalk = b.distwalk
from bus_skim2010 as b
where a.o_taz::smallint  = b.origin and a.d_taz::smallint  = b.dest;

--Update the DRIVE_ACCESS_TRANSIT Value for the Auto Skims
update place_oda as a
set 
dat_am_tt = b.amtime,
dat_dist = b.dist
from auto_skim2010 as b
where a.o_taz::smallint = b.origin and a.frst_tr_taz::smallint = b.dest and desc_choice in ('DA_Transit', 'DAP_Transit'); 

--Update the DRIVE_ACCESS_TRANSIT Values for PT Skims
update place_oda as a
set 
dat_tot_tt = b.tot_time,
dat_ivtt = b.ivtt,
dat_walk_tt = b.walk_tt,
dat_wait_tt = b.wait_tt,
dat_xfer_wt = b.xferwt,
dat_trdist = b.dist,
dat_fares = b.fares,
dat_faremin = b.faremin,
dat_noxfer = b.noxfer,
dat_distwalk = b.distwalk
from pt_skim2010  as b
where a.frst_tr_taz::smallint = b.origin and a.d_taz::smallint = b.dest and desc_choice in ('DA_Transit', 'DAP_Transit'); 
--Above last condition very important as the trips directionality only applies to "DA..." trips and thus the 
--skims only apply to those trips




--------------------------
--Captive users SKuser1
alter table trip_od add column sk1_pt_tot_tt numeric;
alter table trip_od add column sk1_pt_ivtt numeric;
alter table trip_od add column sk1_pt_walk_tt numeric;
alter table trip_od add column sk1_pt_wait_tt numeric;
alter table trip_od add column sk1_pt_xfer_wt numeric;
alter table trip_od add column sk1_pt_dist numeric;
alter table trip_od add column sk1_pt_fares numeric;
alter table trip_od add column sk1_pt_faremin numeric;
alter table trip_od add column sk1_pt_noxfer numeric;
alter table trip_od add column sk1_pt_distwalk numeric;

--Choice users SKuser 2
alter table trip_od add column sk2_pt_tot_tt numeric;
alter table trip_od add column sk2_pt_ivtt numeric;
alter table trip_od add column sk2_pt_walk_tt numeric;
alter table trip_od add column sk2_pt_wait_tt numeric;
alter table trip_od add column sk2_pt_xfer_wt numeric;
alter table trip_od add column sk2_pt_dist numeric;
alter table trip_od add column sk2_pt_fares numeric;
alter table trip_od add column sk2_pt_faremin numeric;
alter table trip_od add column sk2_pt_noxfer numeric;
alter table trip_od add column sk2_pt_distwalk numeric;

--Park and Ride Users - SKuser3
alter table trip_od add column sk3_pt_tot_tt numeric;
alter table trip_od add column sk3_pt_ivtt numeric;
alter table trip_od add column sk3_pt_walk_tt numeric;
alter table trip_od add column sk3_pt_wait_tt numeric;
alter table trip_od add column sk3_pt_xfer_wt numeric;
alter table trip_od add column sk3_pt_dist numeric;
alter table trip_od add column sk3_pt_fares numeric;
alter table trip_od add column sk3_pt_faremin numeric;
alter table trip_od add column sk3_pt_noxfer numeric;
alter table trip_od add column sk3_pt_distwalk numeric;
