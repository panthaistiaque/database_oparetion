--        CREATE SEQUENCE [ IF NOT EXISTS ] sequence_name  
--        [ AS { SMALLINT | INT | BIGINT } ]  
--        [ INCREMENT [ BY ] increment ]  
--        [ MINVALUE minvalue | NO MINVALUE ]   
--        [ MAXVALUE maxvalue | NO MAXVALUE ]  
--        [ START [ WITH ] start ]   
--        [ CACHE cache ]   
--        [ [ NO ] CYCLE ]  
--        [ OWNED BY { table_name.column_name | NONE } ]  


-- dummy table
    CREATE TABLE Purchase_details(  
        Purchase_id SERIAL,  
        Module_id INT NOT NULL,  
        Module_text VARCHAR NOT NULL,  
        Cost DEC(10,2) NOT NULL,  
        PRIMARY KEY(Purchase_id, Module_id)  
    );  
	
-- Creating a new sequence
	
	CREATE SEQUENCE Purchase_module_id  
	START 5  
	INCREMENT 5  
	MINVALUE 5  
	OWNED BY Purchase_details.Module_id; 
	
-- get next sequence value

	SELECT nextval('Purchase_module_id');  	
	
-- Listing all sequences in a database
	
	SELECT relname sequence_name  
	FROM  pg_class   
	WHERE  relkind = 'S';  