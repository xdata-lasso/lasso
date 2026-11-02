-- Schema DDL
CREATE TABLE "Sessions" ("session_id" INTEGER PRIMARY KEY, "duration" INTEGER, CHECK ("duration" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO sessions (session_id, duration) VALUES (600, 9), (10, 59), (16, 601), (11, 59), (300, 300), (-1, 301), (59, 599), (599, 60), (4, NULL), (900, 4), (301, 301), (0, 9), (1, 300), (899, 900), (901, 5), (5, 6), (6, 900);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT '[0-5>' AS bin, COUNT(session_id) AS total FROM sessions WHERE ((CAST(duration AS REAL) / 60) >= 0 AND (CAST(duration AS REAL) / 60) < 5) UNION SELECT '[5-10>' AS bin, COUNT(session_id) AS total FROM sessions WHERE ((CAST(duration AS REAL) / 60) >= 5 AND (CAST(duration AS REAL) / 60) < 10) UNION SELECT '[10-15>' AS bin, COUNT(session_id) AS total FROM sessions WHERE ((CAST(duration AS REAL) / 60) >= 10 AND (CAST(duration AS REAL) / 60) < 15) UNION SELECT '15 or more' AS bin, COUNT(session_id) AS total FROM sessions WHERE (CAST(duration AS REAL) / 60) >= 15;

/*
Gold Result:
('15 or more', 2)
('[0-5>', 8)
('[10-15>', 1)
('[5-10>', 5)
*/

-- Prediction Query
SELECT OPTIONS.BIN, COALESCE(RESWITHOUTNULL.TOTAL, 0) AS TOTAL FROM (SELECT '[0-5>' AS BIN UNION SELECT '[5-10>' AS BIN UNION SELECT '[10-15>' AS BIN UNION SELECT '15 or more' AS BIN) AS OPTIONS LEFT JOIN (SELECT BIN, COUNT(*) AS TOTAL FROM (SELECT (CASE WHEN DURATION < 300 THEN '[0-5>' WHEN DURATION < 600 THEN '[5-10>' WHEN DURATION < 900 THEN '[10-15>' ELSE '15 or more' END) AS BIN FROM SESSIONS) AS RESWITHOUTGROUP GROUP BY BIN) AS RESWITHOUTNULL ON OPTIONS.BIN = RESWITHOUTNULL.BIN;

/*
Prediction Result:
('15 or more', 3)
('[0-5>', 8)
('[10-15>', 1)
('[5-10>', 5)
*/