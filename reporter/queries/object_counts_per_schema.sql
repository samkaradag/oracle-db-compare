WITH instances AS (
  SELECT DISTINCT PKEY AS instance_id
  FROM schema_compare.dbobjectnames
),

object_counts AS (
  SELECT
    PKEY as instance_id,
    OWNER,
    OBJECT_TYPE,
    STATUS,
    COUNT(*) AS object_count
  FROM schema_compare.dbobjectnames
  WHERE PKEY IN (SELECT instance_id FROM instances)
  GROUP BY instance_id, OWNER, OBJECT_TYPE, STATUS
)

SELECT
  OWNER,
  OBJECT_TYPE,
  STATUS,
  MAX(IF(instance_id = (SELECT instance_id FROM instances LIMIT 1 OFFSET 0), object_count, NULL)) AS instance_1_count,
  MAX(IF(instance_id = (SELECT instance_id FROM instances LIMIT 1 OFFSET 1), object_count, NULL)) AS instance_2_count
  -- Add more columns for additional instances as needed
FROM object_counts
GROUP BY OWNER, OBJECT_TYPE, STATUS
ORDER BY OWNER, OBJECT_TYPE, STATUS;