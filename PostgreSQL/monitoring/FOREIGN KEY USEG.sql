-- ----------------------------key useg---------------------------------------------

SELECT *--column_name, COUNT(*) AS fk_count
FROM information_schema.key_column_usage
WHERE constraint_name IN (
    SELECT constraint_name
    FROM information_schema.table_constraints
    WHERE constraint_type = 'FOREIGN KEY'
)
  AND column_name = 'specimen_id';