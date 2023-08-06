
-- FETCH Clause
SELECT car_id, car_name, car_model  
FROM Car  
ORDER BY car_name   
FETCH FIRST ROW ONLY; 



SELECT car_id, car_name, car_model  
FROM Car  
ORDER BY car_name   
FETCH first 1 ROW ONLY;  




SELECT car_id, car_name, car_model  
FROM Car  
ORDER BY car_name  
OFFSET 4 ROWS   
FETCH first 4 ROW ONLY;  