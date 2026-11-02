INSERT INTO sensor_telemetry (telemetry_id, device_id, metric_name, metric_value, reading_seq)
WITH digits(d) AS (
  SELECT 0 UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4
  UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9
)
SELECT
  d1.d + d2.d*10 + d3.d*100 + d4.d*1000 + d5.d*10000 + d6.d*100000 + 1,
  1,
  'PRESSURE',
  101.32,
  d1.d + d2.d*10 + d3.d*100 + d4.d*1000 + d5.d*10000 + d6.d*100000 + 1
FROM digits d1, digits d2, digits d3, digits d4, digits d5, digits d6
WHERE (d1.d + d2.d*10 + d3.d*100 + d4.d*1000 + d5.d*10000 + d6.d*100000 + 1) <= 150001;
