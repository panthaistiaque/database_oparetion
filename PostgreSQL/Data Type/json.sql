-- -- dummy table 
CREATE TABLE Purchase (  
    Purchase_id serial NOT NULL PRIMARY KEY,  
    Purchase_description json NOT NULL  
);

-- -- dummy data
INSERT INTO Purchase (Purchase_description)  VALUES
('{ "purchaser": "Maria Rodriguez", "items": {"product": "Hair shampoo","qty": 2}}'),  
('{ "purchaser": "Thomas Jones", "items": {"product": "Belgium chocolate ice cream","qty": 7}}'),  
('{ "purchaser": "Margaret Davis", "items": {"product": "Barbie doll","qty": 3}}'),  
('{ "purchaser": "Elizabeth Brown", "items": {"product": "puzzle set","qty": 10}}');  

-- JSON query

SELECT Purchase_description  ->> 'purchaser' AS pruchaser  
FROM Purchase; 



SELECT Purchase_description -> 'items' ->> 'product' as Product  
FROM Purchase  
ORDER BY Product;  


-- --- --- -- JSON data using aggregate functions

SELECT   
   MAX (CAST (Purchase_description-> 'items' ->> 'qty' AS INTEGER)),  
   MIN (CAST (Purchase_description -> 'items' ->> 'qty' AS INTEGER)),  
   AVG (CAST (Purchase_description -> 'items' ->> 'qty' AS INTEGER)),  
   SUM (CAST (Purchase_description -> 'items' ->> 'qty' AS INTEGER))  
FROM Purchase; 

-- -- JSON operator in WHERE clause (who bought three products) ----

SELECT Purchase_description  ->> 'purchaser' AS Purchaser,  
Purchase_description -> 'items' ->> 'product' AS product  
FROM Purchase  
WHERE CAST ( Purchase_description-> 'items' ->> 'qty' AS INTEGER) = 3 ;


