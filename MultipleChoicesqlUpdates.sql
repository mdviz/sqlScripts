--After importing the multiple_mode_choice table from python
--update the choice column
update place_oda as i
set 
choice = j.choice
from multiple_mode_transit_or3 as j
where i.sampn = j.sampn and i.perno = j.perno and i.new_plano = j.new_plano;

--update desc_choice column
update place_oda as i
set 
desc_choice = j.desc_choice
from multiple_mode_transit_or3 as j
where i.sampn = j.sampn and i.perno = j.perno and i.new_plano = j.new_plano;

alter table place_oda add column frst_tr_dest character(4)

--in the multiple mode table the frst_tr_or is not the transit origin it is the trip where
-- it was first used, the actual access point of transit is one before, so frst_tr_or is actually 
-- the destination in this case
update place_oda as i
set 
frst_tr_dest = j.frst_tr_or
from multiple_mode_transit_or3 as j
where i.sampn = j.sampn and i.perno = j.perno and i.plano= j.plano;

--this column will hold the transit access
alter table place_oda add column transit_acc character(4)
update place_oda set transit_acc = ((frst_tr_dest::smallint)-1)::character(4) 

update place_oda as i
set 
frst_tr_gid = j.geoid_md
from place  as j
where i.sampn = j.sampn and i.perno = j.perno and i.transit_acc::smallint = j.plano and i.transit_acc is not null;


update place_oda as i
set 
frst_tr_taz = j.taz
from geoid_sumtaz  as j
where i.frst_tr_gid = j.geoid10;


select desc_choice,frst_tr_taz, count(*) from place_oda
where choice in ('DA_Mix', 'DA_Train','DA_Bus') and desc_choice = 'DA_Transit'
group by desc_choice, frst_tr_taz
order by count(*) desc;

select * from place_oda where frst_tr_dest is not null;

--####FIXING
select *
(select  a.sampn, a.perno,a.plano d_plano, b.plano o_plano,b.tpurp or_tpurp, a.tpurp d_tpurp, a.mode, b.geoid_md o_geoid, a.geoid_md d_geoid, b.city, a.city
from place a, place b 
where  a.plano-1 = b.plano and a.sampn = b.sampn and a.perno = b.perno 
and a.sampn = 2004535 and a.perno = 1
order by a.sampn, a.perno, a.plano) as od_place
;

