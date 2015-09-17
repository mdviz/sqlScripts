select * from place_oda 
where 
(gen_purp = 'HBW' and o_desc91 = 'At-home' and mode < 20 
and desc_choice = 'DA_Transit'
and frst_tr_gid is not null)



select * from out_feb8 
where gen_purp = 'HBW' and o_desc91 = 'At-home'
	and mp_income > 0