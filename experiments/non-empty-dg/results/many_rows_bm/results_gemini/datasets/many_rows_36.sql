INSERT INTO sensor_telemetry (telemetry_id, device_id, metric_name, metric_value, reading_seq)
WITH RECURSIVE cnt(x) AS (
  SELECT 1
  UNION ALL
  SELECT x + 1 FROM cnt WHERE x < 1001
)
SELECT x, 1, 'TEMP', CASE WHEN x = 1 THEN 10.0 ELSE 100.0 END, x FROM cnt;
