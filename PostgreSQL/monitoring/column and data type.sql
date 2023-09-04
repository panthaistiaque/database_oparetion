-- -- ------------------------ all column and data type ---------------------------
select table_name, column_name,
case 
    when domain_name is not null then domain_name
    when data_type='character varying' THEN 'varchar('||character_maximum_length||')'
    when data_type='numeric' THEN 'numeric('||numeric_precision||','||numeric_scale||')'
    when data_type='USER-DEFINED' then udt_catalog||'.'|| udt_name
    else data_type
end as myType
from information_schema.columns
where table_catalog ='ehospital_1_3_1'  --and column_name in ('expire_date', 'batch_no')
--and table_name = 'service_provider'
and table_schema = 'ehospital'
and udt_name = 'enum_payment_method'
order by table_name, ordinal_position;