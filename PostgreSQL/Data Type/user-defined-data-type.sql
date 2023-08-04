-- PostgreSQL user-defined data type is used to generate user-defined data types with the help of 
-- Create DOMAIN and CREATE TYPE



-- CREATE DOMAIN
CREATE DOMAIN person_name AS VARCHAR NOT NULL CHECK (value!~ '\s');


CREATE TABLE Recipients1 (  
    Recipient_ID SERIAL PRIMARY KEY,  
    First_name person_name,  
    Last_name person_name,  
    Email VARCHAR NOT NULL  
);  



-- DROP/ALTER Domain
DROP DOMAIN IF EXISTS person_name ;-- CASCADE;


-- CREATE TYPE Command, we will use the item_details data type as the return type of a function
CREATE TYPE Item_details AS (  
    item_id INT,  
    item_name VARCHAR,  
    item_price Numeric(5,2)  
);  

-- function with return type Item_details
CREATE OR REPLACE FUNCTION get_Item_details (I_id INT)   
    RETURNS Item_details AS   
$$   
SELECT item_id, item_name,  item_price   
FROM items  
WHERE item_id = I_id ;   
$$   
LANGUAGE SQL; 




SELECT * FROM get_Item_details(3);  



-- DROP/ALTER TYPE
DROP TYPE IF EXISTS Item_details; -- CASCADE; 