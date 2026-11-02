-- Schema DDL
CREATE TABLE "Sessions" ("session_id" INTEGER PRIMARY KEY, "duration" INTEGER, CHECK ("duration" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO sessions (session_id, duration) VALUES (9, 61), (2, NULL), (1, 4), (11, 16), (-1, 61), (60, NULL), (61, 3), (14, 60), (0, 60), (6, 6), (3, 59), (4, 9), (5, 5), (10, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT '[0-5>' AS bin, COUNT(session_id) AS total FROM sessions WHERE ((CAST(duration AS REAL) / 60) >= 0 AND (CAST(duration AS REAL) / 60) < 5) UNION SELECT '[5-10>' AS bin, COUNT(session_id) AS total FROM sessions WHERE ((CAST(duration AS REAL) / 60) >= 5 AND (CAST(duration AS REAL) / 60) < 10) UNION SELECT '[10-15>' AS bin, COUNT(session_id) AS total FROM sessions WHERE ((CAST(duration AS REAL) / 60) >= 10 AND (CAST(duration AS REAL) / 60) < 15) UNION SELECT '15 or more' AS bin, COUNT(session_id) AS total FROM sessions WHERE (CAST(duration AS REAL) / 60) >= 15;

/*
Gold Result:
('15 or more', 0)
('[0-5>', 11)
('[10-15>', 0)
('[5-10>', 0)
*/

-- Prediction Query
WITH CTE1 AS (SELECT '[0-5>' AS BIN UNION SELECT '[5-10>' AS BIN UNION SELECT '[10-15>' AS BIN UNION SELECT '15 or more' AS BIN), CTE2 AS (SELECT AGG.BIN, COUNT(*) AS TOTAL FROM (SELECT SESSION_ID, CASE WHEN ROUND(CAST(DURATION AS REAL) / 60, 3) BETWEEN 0 AND 4.999 THEN '[0-5>' WHEN ROUND(CAST(DURATION AS REAL) / 60, 3) BETWEEN 5 AND 9.999 THEN '[5-10>' WHEN ROUND(CAST(DURATION AS REAL) / 60, 3) BETWEEN 10 AND 14.999 THEN '[10-15>' ELSE '15 or more' END AS BIN, ROUND(CAST(DURATION AS REAL) / 60, 3) FROM SESSIONS) AS AGG GROUP BY 1) SELECT CTE1.BIN, COALESCE(CTE2.TOTAL, 0) AS TOTAL FROM CTE1 LEFT JOIN CTE2 ON CTE1.BIN = CTE2.BIN;

/*
Prediction Result:
('15 or more', 3)
('[0-5>', 11)
('[10-15>', 0)
('[5-10>', 0)
*/