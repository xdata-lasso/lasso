-- Schema DDL
CREATE TABLE "Sessions" ("session_id" INTEGER PRIMARY KEY, "duration" INTEGER, CHECK ("duration" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT '[0-5>' AS bin, COUNT(session_id) AS total FROM sessions WHERE ((CAST(duration AS REAL) / 60) >= 0 AND (CAST(duration AS REAL) / 60) < 5) UNION SELECT '[5-10>' AS bin, COUNT(session_id) AS total FROM sessions WHERE ((CAST(duration AS REAL) / 60) >= 5 AND (CAST(duration AS REAL) / 60) < 10) UNION SELECT '[10-15>' AS bin, COUNT(session_id) AS total FROM sessions WHERE ((CAST(duration AS REAL) / 60) >= 10 AND (CAST(duration AS REAL) / 60) < 15) UNION SELECT '15 or more' AS bin, COUNT(session_id) AS total FROM sessions WHERE (CAST(duration AS REAL) / 60) >= 15;

/*
Gold Result:
('15 or more', 0)
('[0-5>', 0)
('[10-15>', 0)
('[5-10>', 0)
*/

-- Prediction Query
WITH CTE1 AS (SELECT SESSION_ID, (CASE WHEN DURATION < 5 * 60 THEN 1 ELSE 0 END) AS BIN5, (CASE WHEN DURATION >= 5 * 60 AND DURATION < 10 * 60 THEN 1 ELSE 0 END) AS BIN10, (CASE WHEN DURATION >= 10 * 60 AND DURATION < 15 * 60 THEN 1 ELSE 0 END) AS BIN15, (CASE WHEN DURATION >= 15 * 60 THEN 1 ELSE 0 END) AS BIN20 FROM SESSIONS) SELECT '[0-5>' AS BIN, SUM(BIN5) AS TOTAL FROM CTE1 UNION ALL SELECT '[5-10>' AS BIN, SUM(BIN10) AS TOTAL FROM CTE1 UNION ALL SELECT '[10-15>' AS BIN, SUM(BIN15) AS TOTAL FROM CTE1 UNION ALL SELECT '15 or more' AS BIN, SUM(BIN20) AS TOTAL FROM CTE1;

/*
Prediction Result:
('[0-5>', None)
('[5-10>', None)
('[10-15>', None)
('15 or more', None)
*/