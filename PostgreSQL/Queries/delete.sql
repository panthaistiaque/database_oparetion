DELETE FROM department  
WHERE dept_id = 6; 

-- DELETE USING command
DELETE FROM department   
USING department_tmp  
WHERE  department.dept_id = department_tmp.dept_id; 


DELETE FROM department  
WHERE dept_id = (SELECT dept_id FROM department_tmp); 

-- DELETE and returning the removed rows
DELETE FROM department_tmp   
RETURNING *;  


 delete from patient 
 where patient_code = 'HH0100013845'
 returning patient.*;