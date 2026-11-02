-- Schema DDL
CREATE TABLE "Sessions" ("session_id" INTEGER PRIMARY KEY, "duration" INTEGER, CHECK ("duration" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO sessions (session_id, duration) VALUES (11, 301), (10, 900), (60, 15), (601, NULL), (1, 599), (0, 10), (-1, 16);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT '[0-5>' AS bin, COUNT(session_id) AS total FROM sessions WHERE ((CAST(duration AS REAL) / 60) >= 0 AND (CAST(duration AS REAL) / 60) < 5) UNION SELECT '[5-10>' AS bin, COUNT(session_id) AS total FROM sessions WHERE ((CAST(duration AS REAL) / 60) >= 5 AND (CAST(duration AS REAL) / 60) < 10) UNION SELECT '[10-15>' AS bin, COUNT(session_id) AS total FROM sessions WHERE ((CAST(duration AS REAL) / 60) >= 10 AND (CAST(duration AS REAL) / 60) < 15) UNION SELECT '15 or more' AS bin, COUNT(session_id) AS total FROM sessions WHERE (CAST(duration AS REAL) / 60) >= 15;

/*
Gold Result:
('15 or more', 1)
('[0-5>', 3)
('[10-15>', 0)
('[5-10>', 2)
*/

-- Prediction Query
WITH T1 AS (SELECT *, CASE WHEN DURATION < 300 AND DURATION >= 0 THEN '[0-5>' WHEN DURATION >= 300 AND DURATION < 600 THEN '[5-10>' WHEN DURATION >= 600 AND DURATION < 900 THEN '[10-15>' ELSE '15 or more' END AS BIN FROM SESSIONS), T2 AS (SELECT '[0-5>' AS BIN UNION SELECT '[5-10>' AS BIN UNION SELECT '[10-15>' AS BIN UNION SELECT '15 or more' AS BIN) SELECT T2.BIN, COUNT(T1.SESSION_ID) AS TOTAL FROM T2 LEFT JOIN T1 ON T2.BIN = T1.BIN GROUP BY T2.BIN;

/*
Prediction Result:
('15 or more', 2)
('[0-5>', 3)
('[10-15>', 0)
('[5-10>', 2)
*/