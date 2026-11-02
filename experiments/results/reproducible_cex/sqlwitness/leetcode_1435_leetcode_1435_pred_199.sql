-- Schema DDL
CREATE TABLE "Sessions" ("session_id" INTEGER PRIMARY KEY, "duration" INTEGER, CHECK ("duration" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO sessions (session_id, duration) VALUES (0, 10), (11, 11), (899, NULL), (59, 6), (4, 61), (-1, 59);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT '[0-5>' AS bin, COUNT(session_id) AS total FROM sessions WHERE ((CAST(duration AS REAL) / 60) >= 0 AND (CAST(duration AS REAL) / 60) < 5) UNION SELECT '[5-10>' AS bin, COUNT(session_id) AS total FROM sessions WHERE ((CAST(duration AS REAL) / 60) >= 5 AND (CAST(duration AS REAL) / 60) < 10) UNION SELECT '[10-15>' AS bin, COUNT(session_id) AS total FROM sessions WHERE ((CAST(duration AS REAL) / 60) >= 10 AND (CAST(duration AS REAL) / 60) < 15) UNION SELECT '15 or more' AS bin, COUNT(session_id) AS total FROM sessions WHERE (CAST(duration AS REAL) / 60) >= 15;

/*
Gold Result:
('15 or more', 0)
('[0-5>', 5)
('[10-15>', 0)
('[5-10>', 0)
*/

-- Prediction Query
WITH CTE AS (SELECT '[0-5>' AS BIN UNION SELECT '[5-10>' AS BIN UNION SELECT '[10-15>' AS BIN UNION SELECT '15 or more' AS BIN) SELECT BIN, COALESCE(TOTAL, 0) AS TOTAL FROM CTE LEFT JOIN (SELECT CASE WHEN DURATION < 300 THEN '[0-5>' WHEN DURATION >= 300 AND DURATION < 600 THEN '[5-10>' WHEN DURATION >= 600 AND DURATION < 900 THEN '[10-15>' ELSE '15 or more' END AS BIN, COUNT(*) AS TOTAL FROM SESSIONS GROUP BY BIN) AS T USING (BIN);

/*
Prediction Result:
('15 or more', 1)
('[0-5>', 5)
('[10-15>', 0)
('[5-10>', 0)
*/