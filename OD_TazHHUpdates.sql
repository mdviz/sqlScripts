/*Selects ones that have a valid model O & D*/
-- select a.*, b.taz otaz, c.taz dtaz
-- from place_new3 a, geoid_sumtaz b, 
-- 	(select a.sampn, a.perno, a.new_plano, b.taz
-- 	from place_new3 a, geoid_sumtaz b
-- 	where a.d_geoid = b.geoid10
-- 	) c
-- where a.o_geoid = b.geoid10 and c.sampn = a.sampn and c.perno = a.perno and c.new_plano = a.new_plano
-- order by a.sampn, a.perno, a.plano

-- select a.*, b.taz dtaz
-- from place_new3 a, geoid_sumtaz b
-- where a.d_geoid = b.geoid10
-- order by a.sampn, a.perno, a.plano-- 
-- 
-- 
-- (select  b.tpurp or_tpurp, a.tpurp d_tpurp, b.*, b.geoid_md o_geoid
-- from place_new2 a inner join place_new2 b on (a.new_plano = b.new_plano-1)
-- where  a.sampn = 2000017 and a.sampn = b.sampn and a.perno = b.perno 
-- order by a.sampn, a.perno, a.plano);



--update place_oda add column train_tt numeric;
-- select a.*, b.tot_tim tr_tot_tt, b.ivtt tr_ivtt, b.walk_tt tr_walk_tt, b.wait_tt tr_wait_tt, b.xfer_wt tr_xfer_wt, b.dist tr_dist, 
-- b.fares tr_fares, b.faremin tt_faremin, b.noxfer tr_noxfer, b.distwalk tr_distwalk
-- from place_oda a, train_skim2010 b
-- where a.o_taz::smallint  = b.origin and a.d_taz::smallint  = b.dest

-- alter table place_oda add column tr_tot_tt numeric;
-- alter table place_oda add column tr_ivtt numeric;
-- alter table place_oda add column tr_walk_tt numeric;
-- alter table place_oda add column tr_wait_tt numeric;
-- alter table place_oda add column tr_xfer_wt numeric;
-- alter table place_oda add column tr_dist numeric;
-- alter table place_oda add column tr_fares numeric;
-- alter table place_oda add column tt_faremin numeric;
-- alter table place_oda add column tr_noxfer numeric;
-- alter table place_oda add column tr_distwalk numeric;

select * from place_oda 
where tr_tot_tt > 0 or bus_tot_tt > 0