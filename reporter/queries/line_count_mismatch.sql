WITH instances AS (
  SELECT DISTINCT PKEY AS instance_id
  FROM schema_compare.sourcecode
),

line_counts AS (
  SELECT
    PKEY as instance_id,
    OWNER,
    TYPE,
    SUM_NR_LINES 
  FROM schema_compare.sourcecode
  WHERE PKEY IN (SELECT instance_id FROM instances)
)

SELECT * FROM (
  SELECT
    OWNER,
    TYPE,
    MAX(IF(instance_id = (SELECT instance_id FROM instances LIMIT 1 OFFSET 0), SUM_NR_LINES, NULL)) AS instance_1_line_count,
    MAX(IF(instance_id = (SELECT instance_id FROM instances LIMIT 1 OFFSET 1), SUM_NR_LINES, NULL)) AS instance_2_line_count
    -- Add more columns for additional instances as needed
  FROM line_counts
  GROUP BY OWNER, TYPE
  ORDER BY OWNER, TYPE)
WHERE instance_1_line_count != instance_2_line_count
;