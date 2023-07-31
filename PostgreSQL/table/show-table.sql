-- for get this column value
-- schemaname, tablename, tableowner, tablespace, hasindexes, hasrules, hastriggers, rowsecurity
		
SELECT * FROM pg_catalog.pg_tables  
WHERE schemaname != 'pg_catalog'  
AND schemaname != 'information_schema'; 

--- OR ------

-- for get this column value
-- table_catalog, table_schema, table_name, table_type, self_referencing_column_name, reference_generation, 
-- user_defined_type_catalog, user_defined_type_schema,user_defined_type_name, is_insertable_into, is_typed, commit_action

select *   
from information_schema.tables   
where table_schema='ehos';  