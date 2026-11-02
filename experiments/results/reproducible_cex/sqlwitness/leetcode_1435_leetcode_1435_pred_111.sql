-- Schema DDL
CREATE TABLE "Sessions" ("session_id" INTEGER PRIMARY KEY, "duration" INTEGER, CHECK ("duration" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO sessions (session_id, duration) VALUES (4, 600), (16, 11), (15, 14), (6, 9), (0, 601);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT '[0-5>' AS bin, COUNT(session_id) AS total FROM sessions WHERE ((CAST(duration AS REAL) / 60) >= 0 AND (CAST(duration AS REAL) / 60) < 5) UNION SELECT '[5-10>' AS bin, COUNT(session_id) AS total FROM sessions WHERE ((CAST(duration AS REAL) / 60) >= 5 AND (CAST(duration AS REAL) / 60) < 10) UNION SELECT '[10-15>' AS bin, COUNT(session_id) AS total FROM sessions WHERE ((CAST(duration AS REAL) / 60) >= 10 AND (CAST(duration AS REAL) / 60) < 15) UNION SELECT '15 or more' AS bin, COUNT(session_id) AS total FROM sessions WHERE (CAST(duration AS REAL) / 60) >= 15;

/*
Gold Result:
('15 or more', 0)
('[0-5>', 3)
('[10-15>', 2)
('[5-10>', 0)
*/

-- Prediction Query
WITH CTE AS (SELECT SESSION_ID, CASE WHEN DURATION BETWEEN 0 AND 5 * 60 THEN '[0-5>' WHEN DURATION BETWEEN 5 * 60 + 1 AND 10 * 60 THEN '[5-10>' WHEN DURATION BETWEEN 601 AND 15 * 60 THEN '[10-15>' ELSE '15 or more' END AS BIN FROM SESSIONS), BINS AS (SELECT '[0-5>' AS BIN UNION SELECT '[5-10>' AS BIN UNION SELECT '[10-15>' AS BIN UNION SELECT '15 or more' AS BIN), SUMMARY AS (SELECT BIN, COUNT(SESSION_ID) AS TOTAL FROM CTE GROUP BY 1) SELECT B.BIN AS BIN, COALESCE(TOTAL, 0) AS TOTAL FROM BINS AS B LEFT JOIN SUMMARY AS S ON B.BIN = S.BIN;

/*
Prediction Result:
('15 or more', 0)
('[0-5>', 3)
('[10-15>', 1)
('[5-10>', 1)
*/