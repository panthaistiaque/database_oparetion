-- -----------------------------All FOREIGN KEY------------------------------------------

SELECT *
FROM information_schema.table_constraints
WHERE constraint_type = 'FOREIGN KEY'
and constraint_name ilike '%specimen_id%';