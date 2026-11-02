INSERT INTO sensor_telemetry (telemetry_id, device_id, metric_name, metric_value, reading_seq)
WITH digits(d) AS (
    SELECT 0 UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4
    UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9
),
numbers(n) AS (
    SELECT d1.d + d2.d * 10 + d3.d * 100 + d4.d * 1000 + d5.d * 10000 + 1
    FROM digits d1
    CROSS JOIN digits d2
    CROSS JOIN digits d3
    CROSS JOIN digits d4
    CROSS JOIN digits d5
)
SELECT n, 1, 'TEMP', CAST(n AS REAL), n
FROM numbers
WHERE n <= 50000;
