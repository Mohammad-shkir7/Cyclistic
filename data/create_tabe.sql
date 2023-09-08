-- create raw table to include raw data (imported from CSV files using pgAdmin4)
-- DROP TABLE year_2019_raw
CREATE TABLE IF NOT EXISTS year_2019_raw
(
	trip_id varchar(15) PRIMARY KEY,
	start_time timestamp,
	end_time timestamp,
	bikeid varchar(10),
	trip_duration varchar(20),
	from_station_id varchar(10),
	from_station_name varchar(60),
	to_station_id varchar(10),
	to_station_name varchar(60),
	user_type varchar(15),
	gender varchar(10),
	birth_year numeric(4,0)
	 
	--CONSTRAINT CHK_birth_year CHECK(birth_year >= 1800 AND birth_year<= date_part('year', current_date)::int + 20)
	--CONSTRAINT CHK_trip_duration CHECK(trip_duration >= 0)
)


-- CREATE filtered table (ready to analyze)

-- DROP TABLE year_2019
CREATE TABLE year_2019_b AS 
SELECT	
	trip_id,
	start_time,
	end_time,
	CAST (bikeid AS float),
	CAST (LEFT(REPLACE (trip_duration, ',',''), POSITION('.' IN REPLACE (trip_duration, ',',''))-1) AS float) AS trip_duration_mm,
	CAST (from_station_id AS float),
	from_station_name,
	CAST (to_station_id AS float),
	to_station_name,
	user_type,
	gender,
	birth_year,
	EXTRACT(dow FROM start_time) AS day_of_week -- 0 = sunday, 6 = saturday
FROM
	year_2019_raw yr 
WHERE 1=1 
	AND birth_year > 1900 
	AND birth_year IS NOT NULL 
	AND gender IS NOT NULL 
	AND start_time < end_time
;	


	
	
	