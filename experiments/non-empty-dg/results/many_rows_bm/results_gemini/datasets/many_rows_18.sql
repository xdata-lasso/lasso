INSERT INTO sensor_telemetry (device_id, metric_name, metric_value, reading_seq)
WITH digits AS (
    SELECT 0 AS d UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 
    UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9
),
numbers AS (
    SELECT (d5.d * 10000 + d4.d * 1000 + d3.d * 100 + d2.d * 10 + d1.d + 1) AS seq
    FROM digits d1
    CROSS JOIN digits d2
    CROSS JOIN digits d3
    CROSS JOIN digits d4
    CROSS JOIN digits d5
)
SELECT 1, 'VOLTAGE', 12.0, seq
FROM numbers
WHERE seq <= 15000;
