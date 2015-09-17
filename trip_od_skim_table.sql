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

--Add Auto Skim Data
alter table trip_od add column auto_am_tt numeric;
alter table trip_od add column auto_dist numeric;

--Add Walk Skim Data
alter table trip_od add column walktime numeric;
alter table trip_od add column walkdist numeric;

--Add Bike Skim Data
alter table trip_od add column biketime numeric;


--Update PT_Skim1
update trip_od as a
set 
sk1_pt_tot_tt = b.tot_time,
sk1_pt_ivtt = b.ivtt,
sk1_pt_walk_tt = b.walk_tt,
sk1_pt_wait_tt = b.wait_tt,
sk1_pt_xfer_wt = b.xferwt,
sk1_pt_dist = b.dist,
sk1_pt_fares = b.fares,
sk1_pt_faremin = b.faremin,
sk1_pt_noxfer = b.noxfer,
sk1_pt_distwalk = b.distwalk
from pt_skim2010cap as b
where a.o_taz::smallint  = b.origin and a.d_taz::smallint  = b.dest;

--Update PT_Skim1
update trip_od as a
set 
sk2_pt_tot_tt = b.tot_time,
sk2_pt_ivtt = b.ivtt,
sk2_pt_walk_tt = b.walk_tt,
sk2_pt_wait_tt = b.wait_tt,
sk2_pt_xfer_wt = b.xferwt,
sk2_pt_dist = b.dist,
sk2_pt_fares = b.fares,
sk2_pt_faremin = b.faremin,
sk2_pt_noxfer = b.noxfer,
sk2_pt_distwalk = b.distwalk
from pt_skim2010cap as b
where a.o_taz::smallint  = b.origin and a.d_taz::smallint  = b.dest;

update trip_od as a
set 
sk3_pt_tot_tt = b.tot_time,
sk3_pt_ivtt = b.ivtt,
sk3_pt_walk_tt = b.walk_tt,
sk3_pt_wait_tt = b.wait_tt,
sk3_pt_xfer_wt = b.xferwt,
sk3_pt_dist = b.dist,
sk3_pt_fares = b.fares,
sk3_pt_faremin = b.faremin,
sk3_pt_noxfer = b.noxfer,
sk3_pt_distwalk = b.distwalk
from pt_skim2010cap as b
where a.o_taz::smallint  = b.origin and a.d_taz::smallint  = b.dest;

--Update autovalues
update trip_od as a
set 
auto_am_tt = b.fftime,
auto_dist = b.dist
from sk_auto_2010 as b
where a.o_taz::smallint  = b.origin and a.d_taz::smallint = b.dest;

--Update the Walk Values
update trip_od as a
set 
walktime = b.walktime,
walkdist = b.dist
from sk_walk_2010 as b
where a.o_taz::smallint  = b.origin and a.d_taz::smallint = b.dest;

--Update the Bike Values
update trip_od set biketime = walktime/3.0;

select * from trip_od where o_taz <> d_taz
order by o_taz, d_taz::smallint