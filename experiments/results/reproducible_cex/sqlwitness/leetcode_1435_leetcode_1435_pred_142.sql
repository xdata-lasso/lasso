-- Schema DDL
CREATE TABLE "Sessions" ("session_id" INTEGER PRIMARY KEY, "duration" INTEGER, CHECK ("duration" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO sessions (session_id, duration) VALUES (1, 59), (61, NULL), (2, 10), (5, 14), (16, 10), (0, 15);
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
SELECT A.BIN, SUM(CASE WHEN NOT B.BIN IS NULL THEN 1 ELSE 0 END) AS TOTAL FROM (SELECT '[0-5>' AS BIN UNION SELECT '[5-10>' AS BIN UNION SELECT '[10-15>' AS BIN UNION SELECT '15 or more' AS BIN) AS A LEFT JOIN (SELECT CASE WHEN (CAST(DURATION AS REAL) / 60) >= 0 AND (CAST(DURATION AS REAL) / 60) < 5 THEN '[0-5>' WHEN (CAST(DURATION AS REAL) / 60) AND (CAST(DURATION AS REAL) / 60) < 10 THEN '[5-10>' WHEN (CAST(DURATION AS REAL) / 60) >= 10 AND (CAST(DURATION AS REAL) / 60) < 15 THEN '[10-15>' ELSE '15 or more' END AS BIN FROM SESSIONS) AS B ON A.BIN = B.BIN GROUP BY A.BIN;

/*
Prediction Result:
('15 or more', 1)
('[0-5>', 5)
('[10-15>', 0)
('[5-10>', 0)
*/