WITH instances AS (
  SELECT DISTINCT PKEY AS instance_id
  FROM schema_compare.instances
),
all_columns AS (
  SELECT DISTINCT OWNER, TABLE_NAME, COLUMN_NAME
  FROM schema_compare.columns
  WHERE PKEY IN (SELECT instance_id FROM instances)
),

instance_columns AS (
  SELECT PKEY instance_id, OWNER, TABLE_NAME, COLUMN_NAME
  FROM schema_compare.columns
  WHERE PKEY IN (SELECT instance_id FROM instances)
)

SELECT 
  a.OWNER,
  a.TABLE_NAME,
  a.COLUMN_NAME,
  IF(i1.COLUMN_NAME IS NULL, 'Missing', 'Present') AS instance_1_status,
  IF(i2.COLUMN_NAME IS NULL, 'Missing', 'Present') AS instance_2_status
FROM all_columns a
LEFT JOIN instance_columns i1 ON a.OWNER = i1.OWNER AND a.TABLE_NAME = i1.TABLE_NAME AND a.COLUMN_NAME = i1.COLUMN_NAME  AND i1.instance_id = '<instance_1_id>'
LEFT JOIN instance_columns i2 ON a.OWNER = i2.OWNER AND a.TABLE_NAME = i2.TABLE_NAME AND a.COLUMN_NAME = i2.COLUMN_NAME  AND i2.instance_id = '<instance_2_id>'
WHERE i1.COLUMN_NAME IS NULL OR i2.COLUMN_NAME IS NULL
ORDER BY a.OWNER, a.TABLE_NAME, a.COLUMN_NAME;