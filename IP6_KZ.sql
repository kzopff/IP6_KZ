USE crime_data;

#1
SELECT COUNT(DISTINCT crime_type) AS unique_crimes FROM incident_reports;

#2
SELECT crime_type,COUNT(*) AS num_crimes
FROM incident_reports
GROUP BY crime_type
ORDER BY crime_type;

#3
SELECT COUNT(incident_number) AS incidents
FROM incident_reports
WHERE DATEDIFF(date_reported, date_occured) = 0;

#4
SELECT date_reported, date_occured, crime_type, (DATEDIFF(date_reported, date_occured))/365 as date_difference
FROM incident_reports
WHERE DATEDIFF(date_reported, date_occured) >= 365
ORDER BY DATEDIFF(date_reported, date_occured) DESC;

#5
SELECT YEAR(date_occured) AS year_occured, COUNT(incident_number) AS num_incidents
FROM incident_reports
WHERE YEAR(date_occured) >=2012
GROUP BY YEAR(date_occured)
ORDER BY YEAR(date_occured) DESC;

#6
SELECT * FROM incident_reports
WHERE crime_type = 'robbery';

#7
SELECT lmpd_division, incident_number, date_occured
FROM incident_reports
WHERE crime_type = 'robbery' AND att_comp = 'attempted'
ORDER BY lmpd_division, date_occured;

#8
SELECT date_occured, crime_type
FROM incident_reports
WHERE zip_code = 40202
ORDER BY crime_type, date_occured;

#9
SELECT zip_code, COUNT(crime_type) as num_thefts
FROM incident_reports
WHERE crime_type = 'MOTOR VEHICLE THEFT'
GROUP BY zip_code
ORDER BY COUNT(crime_type) DESC;
#The zip code 40214 has the ighest number of motor vehicle thefts. 

#10
SELECT COUNT(DISTINCT city) as unique_cities
FROM incident_reports;

#11
SELECT city, COUNT(incident_number) AS num_of_incidents
FROM incident_reports
GROUP BY city
ORDER BY COUNT(incident_number) DESC;
#The city with the second largest number of incidents is Lyndon. LVIL is second on the list, but we can assume this is an abbreviation for Louisville. 

#12
SELECT uor_desc, crime_type
FROM incident_reports
WHERE crime_type != 'OTHER'
ORDER BY uor_desc, crime_type;
#The UOR description column describes the manner of the type of crime that occured. 

#13
SELECT COUNT(DISTINCT lmpd_beat) AS lmpd_beats
FROM incident_reports;

#14
SELECT COUNT(DISTINCT offense_code) as unique_code
FROM nibrs_codes;

#15
SELECT COUNT(DISTINCT nibrs_code) as unique_code
FROM incident_reports;

#16
SELECT date_occured, block_address, zip_code, offense_description
FROM incident_reports, nibrs_codes
WHERE incident_reports.nibrs_code = nibrs_codes.offense_code AND nibrs_code IN (240, 250, 270, 280)
ORDER BY block_address;

#17
SELECT zip_code, offense_against
FROM incident_reports, nibrs_codes
WHERE incident_reports.nibrs_code = nibrs_codes.offense_code AND LENGTH(zip_code) >= 5 AND nibrs_code != '999'
ORDER BY zip_code;

#18
SELECT offense_against, COUNT(offense_against)
FROM incident_reports, nibrs_codes
WHERE incident_reports.nibrs_code = nibrs_codes.offense_code AND offense_against != ''
GROUP BY offense_against
ORDER BY offense_against;

#19
SELECT zip_code, COUNT(incident_number) AS total_incidents
FROM incident_reports
WHERE zip_code != ''
GROUP BY zip_code
HAVING COUNT(incident_number) > 1000
ORDER BY zip_code;

#20
SELECT premise_type, offense_description
FROM incident_reports, nibrs_codes
WHERE incident_reports.nibrs_code = nibrs_codes.offense_code AND crime_type = 'ASSAULT' AND premise_type != ''
ORDER BY premise_type;
