UPDATE place_oda SET o_taz = null;
UPDATE place_oda SET d_taz = null;
UPDATE place_oda SET hh_taz = null;


--Get Destination TAZ
update place_oda  as a
set d_taz = b.taz
from block_to986taz  as b
where a.d_geoid = b.geoid10;

--Get Origin TAZ
update place_oda  as a
set o_taz = b.taz
from block_to986taz as b
where a.o_geoid = b.geoid10;

--Get HH Location (GEOID)
update place_oda as a
set hh_geoid = b.geoid_md
from hh as b
where a.sampn = b.sampn;

--Get HH TAZ
update place_oda  as a
set hh_taz = b.taz
from block_to986taz  as b
where a.hh_geoid = b.geoid10;


--Origin Job Density
update place_oda as a
set o_jobden = b.jobdensity
from taz2010 as b
where a.o_taz::smallint = b.z;

--Dest Job Density
update place_oda as a
set d_jobden = b.jobdensity
from taz2010 as b
where a.d_taz::smallint = b.z;

--Origin Job Density
update place_oda as a
set o_cbd = b.cbd
from taz2010 as b
where a.o_taz::smallint = b.z;

--Dest Job Density
update place_oda as a
set d_cbd = b.cbd
from taz2010 as b
where a.d_taz::smallint = b.z;

--H
--Origin RES Density
update place_oda as a
set o_resden = b.residentde
from taz2010 as b
where a.o_taz::smallint = b.z;

--Dest RES Density
update place_oda as a
set d_resden = b.residentde
from taz2010 as b
where a.d_taz::smallint = b.z;

--Terminal Time Stuff
alter table place_oda  add column term_i numeric;
alter table place_oda  add column term_j numeric;



--Set Terminal Time i, this would be if walk to car at beginning of trip
update place_oda as a
set term_i = b.termi
from taz2010 as b
where a.o_taz::smallint = b.z;
--Now walk from Car
update place_oda as a
set term_j = b.termj
from taz2010 as b
where a.d_taz::smallint = b.z;

--Parking Time Stuff
alter table place_oda  add column parkhbw_i numeric;
alter table place_oda  add column parkhbw_j numeric;

--Set Parking Cost
update place_oda as a
set parkhbw_i = b.parkhbw
from taz2010 as b
where a.o_taz::smallint = b.z;

--Now walk from Car
update place_oda as a
set parkhbw_j = b.parkhbw
from taz2010 as b
where a.d_taz::smallint = b.z;


select * from place_oda 
LIMIT 1000