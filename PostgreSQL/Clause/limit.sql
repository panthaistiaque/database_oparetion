-- getting the top and bottom rows using LIMIT Clause
SELECT Car_id, Car_name, Car_Price  
FROM CAR  
ORDER BY Car_Price desc  
LIMIT 5 ; 

-- OFFSET using PostgreSQL LIMIT clause
SELECT Car_id, Car_name, Body_Style  
FROM CAR  
ORDER BY Car_id  
LIMIT 5 OFFSET 2;