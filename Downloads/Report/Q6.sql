SET SESSION group_concat_max_len = 100000;

SET @sql = NULL;

SELECT
    GROUP_CONCAT(CONCAT('SELECT ', column_name, ' AS topbrand FROM ', table_name, ' r WHERE r.userID IN (SELECT u._ID FROM users u WHERE u.createdDate LIKE ''2021/3%'' OR u.createdDate LIKE ''2021/2%'' OR u.createdDate LIKE ''2021/1%'' OR u.createdDate LIKE ''2020/12%'' OR u.createdDate LIKE ''2020/11%'' OR u.createdDate LIKE ''2020/10%'')') SEPARATOR ' UNION ALL ')
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
