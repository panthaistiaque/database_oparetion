-- find the latest punch_time for each employee on the specified date
SELECT ea.id, ea.employee_id, ea.punch_time, ea.create_on
FROM employee_attendance ea
WHERE ea.machine_no = 'BRWU204360005'
AND DATE(ea.punch_time) = '2024-06-19'
AND ea.punch_time = ( SELECT MAX(punch_time) FROM employee_attendance  WHERE employee_id = ea.employee_id  AND DATE(punch_time) = DATE(ea.punch_time));
-- ----------------------------------------
-- Update the punch_time by adding one hour to the identified records
update employee_attendance att 
inner join (
	SELECT ea.id, ea.employee_id, ea.punch_time, ea.create_on 
	FROM employee_attendance ea
	WHERE ea.machine_no = 'BRWU204360005'
	AND DATE(ea.punch_time) = '2024-06-19'
	AND ea.punch_time = ( SELECT MAX(punch_time) FROM employee_attendance  WHERE employee_id = ea.employee_id  AND DATE(punch_time) = DATE(ea.punch_time))
) as last_record on last_record.id = att.id
set att.punch_time = DATE_ADD(att.punch_time, INTERVAL 1 HOUR);
