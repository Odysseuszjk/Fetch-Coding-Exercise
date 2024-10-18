SET SESSION group_concat_max_len = 100000;

SET @sql = NULL;

SELECT
    GROUP_CONCAT(CONCAT('SELECT ', column_name, ' AS topbrand FROM ', table_name,' WHERE dateScanned LIKE ''2021/1%''') SEPARATOR ' UNION ALL ')
INTO @sql
FROM (
    SELECT table_name, column_name
    FROM information_schema.columns
    WHERE table_name LIKE 'receipts1' 
      AND column_name LIKE '%brandCode'
) AS columns_info;

SET @sql = CONCAT('SELECT topbrand, COUNT(*) AS count
                   FROM (', @sql, ') AS topbrands
                   WHERE topbrand IS NOT NULL
                   GROUP BY topbrand
                   ORDER BY count DESC
                   LIMIT 6;');

PREPARE stmt FROM @sql;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;