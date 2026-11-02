-- Schema DDL
CREATE TABLE "Sessions" ("session_id" INTEGER PRIMARY KEY, "duration" INTEGER, CHECK ("duration" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO sessions (session_id, duration) VALUES (60, 60), (0, 6), (11, NULL), (9, NULL), (16, 4), (-1, 10), (15, 61), (10, 59), (1, 10), (5, 11), (4, 15), (6, 14), (14, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT '[0-5>' AS bin, COUNT(session_id) AS total FROM sessions WHERE ((CAST(duration AS REAL) / 60) >= 0 AND (CAST(duration AS REAL) / 60) < 5) UNION SELECT '[5-10>' AS bin, COUNT(session_id) AS total FROM sessions WHERE ((CAST(duration AS REAL) / 60) >= 5 AND (CAST(duration AS REAL) / 60) < 10) UNION SELECT '[10-15>' AS bin, COUNT(session_id) AS total FROM sessions WHERE ((CAST(duration AS REAL) / 60) >= 10 AND (CAST(duration AS REAL) / 60) < 15) UNION SELECT '15 or more' AS bin, COUNT(session_id) AS total FROM sessions WHERE (CAST(duration AS REAL) / 60) >= 15;

/*
Gold Result:
('15 or more', 0)
('[0-5>', 10)
('[10-15>', 0)
('[5-10>', 0)
*/

-- Prediction Query
SELECT T_TOP.BIN, COALESCE(T2.TOTAL, 0) AS TOTAL FROM (SELECT '[0-5>' AS BIN UNION ALL SELECT '[5-10>' AS BIN UNION ALL SELECT '[10-15>' AS BIN UNION ALL SELECT '15 or more' AS BIN) AS T_TOP LEFT JOIN (SELECT T.BIN, COALESCE(COUNT(*), 0) AS TOTAL FROM (SELECT SESSION_ID, CASE WHEN CAST(DURATION AS REAL) / 60 >= 0 AND CAST(DURATION AS REAL) / 60 < 5 THEN '[0-5>' WHEN CAST(DURATION AS REAL) / 60 >= 5 AND CAST(DURATION AS REAL) / 60 < 10 THEN '[5-10>' WHEN CAST(DURATION AS REAL) / 60 >= 10 AND CAST(DURATION AS REAL) / 60 < 15 THEN '[10-15>' ELSE '15 or more' END AS BIN FROM SESSIONS) AS T GROUP BY T.BIN) AS T2 ON T_TOP.BIN = T2.BIN;

/*
Prediction Result:
('[0-5>', 10)
('[5-10>', 0)
('[10-15>', 0)
('15 or more', 3)
*/