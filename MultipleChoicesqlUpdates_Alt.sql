-- --After importing the multiple_mode_choice table from python
-- --update the choice column
-- update place_oda as i
-- set 
-- choice = j.choice
-- from multiple_mode_transit_or3 as j
-- where i.sampn = j.sampn and i.perno = j.perno and i.new_plano = j.new_plano;
-- 
-- --update desc_choice column
-- update place_oda as i
-- set 
-- desc_choice = j.desc_choice
-- from multiple_mode_transit_or3 as j
-- where i.sampn = j.sampn and i.perno = j.perno and i.new_plano = j.new_plano;
-- 
-- update place_oda as i
-- set 
-- frst_tr_or = j.frst_tr_or
-- from multiple_mode_transit_or3 as j
-- where i.sampn = j.sampn and i.perno = j.perno and i.plano= j.plano;
-- 
-- update place_oda as i
-- set 
-- frst_tr_gid = j.geoid_md
-- from place  as j
-- where i.sampn = j.sampn and i.perno = j.perno and i.frst_tr_or = j.plano;
-- 
-- update place_oda as i
-- set 
-- frst_tr_gid = j.geoid_md
-- from place  as j
-- where i.sampn = j.sampn and i.perno = j.perno and i.frst_tr_or = j.plano;
-- 
-- update place_oda as i
-- set 
-- frst_tr_taz = j.taz
-- from geoid_sumtaz  as j
-- where i.frst_tr_gid = j.geoid10;
-- 
-- select * from place_oda where frst_tr_or is not null;

select desc_choice,frst_tr_taz, count(*) from place_oda
where choice in ('DA_Mix', 'DA_Train','DA_Bus') and desc_choice = 'DAP_Transit'
group by desc_choice, frst_tr_taz
order by frst_tr_taz::numeric

select sampn, perno, plano,new_plano, o_taz, d_taz, frst_tr_or, frst_tr_taz, desc_choice, cmode1, cmode2, cmode3, cmode4, cmode5, cmode6, cmode7
from place_oda
where desc_choice = 'DA_Transit' and frst_tr_taz = '10'
order by sampn, perno, plano
