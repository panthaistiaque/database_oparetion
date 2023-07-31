SELECT *  
FROM information_schema.COLUMNS  
WHERE TABLE_NAME = 'hospital';
-- - --- ---- --- --- --- ---- ---- ---- --- ---
select table_schema,table_name, column_name,
case 
    when domain_name is not null then domain_name
    when data_type='character varying' THEN 'varchar('||character_maximum_length||')'
    when data_type='numeric' THEN 'numeric('||numeric_precision||','||numeric_scale||')'
    when data_type='USER-DEFINED' then udt_catalog||'.'|| udt_name
    else data_type
end as myType
, replace(column_default,'::character varying','') column_default
, is_nullable
, is_identity
from information_schema.columns
where  TABLE_NAME = 'hospital'
-- and table_schema = 'ehosp'
order by table_name, ordinal_position;


    
