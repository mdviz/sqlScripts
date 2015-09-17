COPY (select * from out_feb8 
where gen_purp = 'HBW' and o_desc91 = 'At-home'
	and mp_income > 0)

TO 'C:\temp\hbw_feb8.csv' DELIMITER ',' CSV HEADER;
