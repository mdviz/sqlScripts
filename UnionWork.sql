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
