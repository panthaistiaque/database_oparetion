
-- -- dummy table
CREATE TABLE department (  
    dept_ID serial PRIMARY KEY,  
    Dept_name VARCHAR (255) NOT NULL,  
    description VARCHAR (255),  
    location VARCHAR(50)  
);


-- insert one row 
INSERT INTO department (dept_name, location)  VALUES ('RESEARCH', 'Newyork');    


-- Insert the multiple rows
INSERT INTO department (dept_name, location)  
VALUES ('ACCOUNTING', 'Boston'),  
('OPERATIONS','Florida'),  
('SALES','Chicago'); 



ALTER TABLE department ADD COLUMN last_update Date;  
ALTER TABLE department ALTER COLUMN last_update SET DEFAULT CURRENT_DATE;



INSERT INTO department (Dept_name, last_update)  
VALUES('HR',DEFAULT); 


-- -- dummy table
CREATE TABLE department_tmp (LIKE department); 



-- Insert data from another table
INSERT INTO department_tmp   
SELECT *  
FROM  
department  
WHERE  
last_update IS NOT NULL; 



-- get the last inserted dept_id
INSERT INTO department (dept_name, last_update)  
VALUES('IT',DEFAULT)  
RETURNING Dept_id;  