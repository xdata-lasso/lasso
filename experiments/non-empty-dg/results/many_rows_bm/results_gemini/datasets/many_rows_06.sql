INSERT INTO sensor_telemetry (telemetry_id, device_id, metric_name, metric_value, reading_seq)
WITH digits(d) AS (
    SELECT 0 UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4
    UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9
),
numbers(n) AS (
    SELECT d1.d * 1000 + d2.d * 100 + d3.d * 10 + d4.d + 1
    FROM digits d1, digits d2, digits d3, digits d4
)
SELECT n, 1, 'TEMP', 26.0, n
FROM numbers
WHERE n <= 1005;
