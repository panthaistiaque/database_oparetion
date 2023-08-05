-- update joins command
UPDATE department_tmp  
	SET location = department.location,  
	description = department.description,  
	last_update = department.last_update  
FROM  department  
WHERE  department_tmp.Dept_id = department.Dept_id; 


-- Update command through returning condition

UPDATE department  
    SET description = 'Names of departments',  
    location = 'NewYork'  
WHERE  dept_id = 1   
RETURNING dept_id, description, location;  