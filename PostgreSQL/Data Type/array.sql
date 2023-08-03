-- PostgreSQL allows us to specify a column as an array of any valid data type, which involves user-defined data type, enumerated data type, and built-in datatype.

-- -- dummy table 
CREATE TABLE person_details (  
    id serial PRIMARY KEY,  
    person_name VARCHAR (200) ,  
    mobile_numbers TEXT []  
);  

-- Inserting PostgreSQL array values
INSERT INTO person_details (person_name, mobile_number)  VALUES('Maria Smith',ARRAY [ '(444)-333-1234','(555)-333-5432' ]); 

INSERT INTO person_details (person_name, mobile_number) VALUES
	('Mike Taylor','{"(444)-333-1234"}'),  
    ('Emma Garcia','{"(568)-333-5678"}'),  
    ('David Smith','{"(444)-333-7658","(308)-589-23458"}');  
	
	

-- select 
SELECT person_name, mobile_number[1]  FROM person_details; 
SELECT person_name FROM person_details WHERE mobile_number[2]='(308)-589-23458';  


-- UPDATE
UPDATE person_details  SET mobile_number [2] = '(308)-859-54378'  
WHERE ID = 4; 

UPDATE person_details SET mobile_number = '{"(308)-859-54378"}'  
WHERE ID = 4;  

-- Expand Arrays data type
SELECT person_name,  unnest(mobile_number)  FROM person_details;


-- -- Search in Array
SELECT person_name, mobile_number FROM person_details  
WHERE '(555)-333-5432' = ANY (mobile_number);  