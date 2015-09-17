
-- --Correcting Import Issues from Access: Nulls become Zeros
update pt_skim2010 set tot_time = null where tot_time = 0;
update pt_skim2010 set ivtt = null where tot_time is null;
update pt_skim2010 set walk_tt = null where tot_time is null;
update pt_skim2010 set wait_tt = null where tot_time is null;
update pt_skim2010 set xferwt = null where tot_time is null;
update pt_skim2010 set dist = null where tot_time is null;
update pt_skim2010 set fares = null where tot_time is null;
update pt_skim2010 set faremin = null where tot_time is null;
update pt_skim2010 set noxfer = null where tot_time is null;
update pt_skim2010 set distwalk = null where tot_time is null;

update bus_skim2010 set tot_time = null where tot_time = 0;
update bus_skim2010 set ivtt = null where tot_time is null;
update bus_skim2010 set walk_tt = null where tot_time is null;
update bus_skim2010 set wait_tt = null where tot_time is null;
update bus_skim2010 set xferwt = null where tot_time is null;
update bus_skim2010 set dist = null where tot_time is null;
update bus_skim2010 set fares = null where tot_time is null;
update bus_skim2010 set faremin = null where tot_time is null;
update bus_skim2010 set noxfer = null where tot_time is null;
update bus_skim2010 set distwalk = null where tot_time is null;

update train_skim2010 set tot_tim = null where tot_tim = 0;
update train_skim2010 set ivtt = null where tot_tim is null;
update train_skim2010 set walk_tt = null where tot_tim is null;
update train_skim2010 set wait_tt = null where tot_tim is null;
update train_skim2010 set xfer_wt = null where tot_tim is null;
update train_skim2010 set dist = null where tot_tim is null;
update train_skim2010 set fares = null where tot_tim is null;
update train_skim2010 set faremin = null where tot_tim is null;
update train_skim2010 set noxfer = null where tot_tim is null;
update train_skim2010 set distwalk = null where tot_tim is null;
--Fix Autotimes that are 
update auto_skim2010 set amtime = null where origin = dest;
update auto_skim2010 set dist = null where origin = dest;


--CLEAR PREVIOUS Values
update place_oda set auto_am_tt = null;
update place_oda set auto_dist = null;
update place_oda set walktime = null;
update place_oda set walkdist = null;
update place_oda set biketime = null;
--Clear PT VALUES
update place_oda set pt_tot_tt = null;
update place_oda set pt_ivtt = null;
update place_oda set pt_walk_tt = null;
update place_oda set pt_wait_tt = null;
update place_oda set pt_xfer_wt = null;
update place_oda set pt_dist = null;
update place_oda set pt_fares = null;
update place_oda set pt_faremin = null;
update place_oda set pt_noxfer = null;
update place_oda set pt_distwalk = null;
--CLEAR TRAIN VALUES
update place_oda set tr_tot_tt = null;
update place_oda set tr_ivtt = null;
update place_oda set tr_walk_tt = null;
update place_oda set tr_wait_tt = null;
update place_oda set tr_xfer_wt = null;
update place_oda set tr_dist = null;
update place_oda set tr_fares = null;
update place_oda set tt_faremin = null;
update place_oda set tr_noxfer = null;
update place_oda set tr_distwalk = null;
--CLEAR BUS VALUES
update place_oda set bus_tot_tt = null;
update place_oda set bus_ivtt = null;
update place_oda set bus_walk_tt = null;
update place_oda set bus_wait_tt = null;
update place_oda set bus_xfer_wt = null;
update place_oda set bus_dist = null;
update place_oda set bus_fares = null;
update place_oda set bus_faremin = null;
update place_oda set bus_noxfer = null;
update place_oda set bus_distwalk = null;
--CLEAR DAT VALUES
update place_oda set dat_am_tt = null;
update place_oda set dat_dist = null
update place_oda set dat_tot_tt = null;
update place_oda set dat_ivtt = null;
update place_oda set dat_walk_tt = null;
update place_oda set dat_wait_tt = null;
update place_oda set dat_xfer_wt = null;
update place_oda set dat_trdist = null;
update place_oda set dat_fares = null;
update place_oda set dat_faremin = null;
update place_oda set dat_noxfer = null;
update place_oda set dat_distwalk = null;

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
pt_tot_tt = b.tot_tim,
pt_ivtt = b.ivtt,
pt_walk_tt = b.walk_tt,
pt_wait_tt = b.wait_tt,
pt_xfer_wt = b.xfer_wt,
pt_dist = b.dist,
pt_fares = b.fares,
pt_faremin = b.faremin,
pt_noxfer = b.noxfer,
pt_distwalk = b.distwalk
from train_skim2010 as b
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
bus_xfer_wt = b.xfer_wt,
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
