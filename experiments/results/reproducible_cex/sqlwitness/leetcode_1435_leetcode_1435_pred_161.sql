-- Schema DDL
CREATE TABLE "Sessions" ("session_id" INTEGER PRIMARY KEY, "duration" INTEGER, CHECK ("duration" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO sessions (session_id, duration) VALUES (300, 11), (10, 60), (600, 901), (1, 601), (9, 9), (11, NULL), (900, 14), (0, 60), (-1, 900);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT '[0-5>' AS bin, COUNT(session_id) AS total FROM sessions WHERE ((CAST(duration AS REAL) / 60) >= 0 AND (CAST(duration AS REAL) / 60) < 5) UNION SELECT '[5-10>' AS bin, COUNT(session_id) AS total FROM sessions WHERE ((CAST(duration AS REAL) / 60) >= 5 AND (CAST(duration AS REAL) / 60) < 10) UNION SELECT '[10-15>' AS bin, COUNT(session_id) AS total FROM sessions WHERE ((CAST(duration AS REAL) / 60) >= 10 AND (CAST(duration AS REAL) / 60) < 15) UNION SELECT '15 or more' AS bin, COUNT(session_id) AS total FROM sessions WHERE (CAST(duration AS REAL) / 60) >= 15;

/*
Gold Result:
('15 or more', 2)
('[0-5>', 5)
('[10-15>', 1)
('[5-10>', 0)
*/

-- Prediction Query
WITH TMP1 AS (SELECT *, CASE WHEN DURATION < 300 THEN '[0-5>' WHEN DURATION >= 300 AND DURATION < 600 THEN '[5-10>' WHEN DURATION >= 600 AND DURATION < 900 THEN '[10-15>' ELSE '15 or more' END AS BIN FROM SESSIONS), TMP2 AS (SELECT '[0-5>' AS BIN UNION ALL SELECT '[5-10>' AS BIN UNION ALL SELECT '[10-15>' AS BIN UNION ALL SELECT '15 or more' AS BIN) SELECT TMP2.BIN, SUM(IIF(SESSION_ID IS NULL, 0, 1)) AS TOTAL FROM TMP2 LEFT JOIN TMP1 ON TMP2.BIN = TMP1.BIN GROUP BY TMP2.BIN;

/*
Prediction Result:
('15 or more', 3)
('[0-5>', 5)
('[10-15>', 1)
('[5-10>', 0)
*/