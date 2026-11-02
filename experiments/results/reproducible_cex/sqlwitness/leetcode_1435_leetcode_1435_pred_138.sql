-- Schema DDL
CREATE TABLE "Sessions" ("session_id" INTEGER PRIMARY KEY, "duration" INTEGER, CHECK ("duration" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO sessions (session_id, duration) VALUES (4, 16), (6, 9), (-1, NULL), (10, 9);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT '[0-5>' AS bin, COUNT(session_id) AS total FROM sessions WHERE ((CAST(duration AS REAL) / 60) >= 0 AND (CAST(duration AS REAL) / 60) < 5) UNION SELECT '[5-10>' AS bin, COUNT(session_id) AS total FROM sessions WHERE ((CAST(duration AS REAL) / 60) >= 5 AND (CAST(duration AS REAL) / 60) < 10) UNION SELECT '[10-15>' AS bin, COUNT(session_id) AS total FROM sessions WHERE ((CAST(duration AS REAL) / 60) >= 10 AND (CAST(duration AS REAL) / 60) < 15) UNION SELECT '15 or more' AS bin, COUNT(session_id) AS total FROM sessions WHERE (CAST(duration AS REAL) / 60) >= 15;

/*
Gold Result:
('15 or more', 0)
('[0-5>', 3)
('[10-15>', 0)
('[5-10>', 0)
*/

-- Prediction Query
WITH CTE1 AS (SELECT '[0-5>' AS BIN UNION ALL SELECT '[5-10>' AS BIN UNION ALL SELECT '[10-15>' AS BIN UNION ALL SELECT '15 or more' AS BIN), CTE2 AS (SELECT SESSION_ID, DURATION, (CASE WHEN CAST(DURATION AS REAL) / 60 < 5 THEN '[0-5>' WHEN CAST(DURATION AS REAL) / 60 >= 5 AND CAST(DURATION AS REAL) / 60 < 10 THEN '[5-10>' WHEN CAST(DURATION AS REAL) / 60 >= 10 AND CAST(DURATION AS REAL) / 60 < 15 THEN '[10-15>' ELSE '15 or more' END) AS BIN FROM SESSIONS) SELECT CTE1.BIN, COUNT(CTE2.BIN) AS TOTAL FROM CTE1 LEFT OUTER JOIN CTE2 ON CTE1.BIN = CTE2.BIN GROUP BY CTE1.BIN;

/*
Prediction Result:
('15 or more', 1)
('[0-5>', 3)
('[10-15>', 0)
('[5-10>', 0)
*/