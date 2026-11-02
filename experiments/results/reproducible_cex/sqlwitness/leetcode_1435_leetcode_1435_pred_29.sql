-- Schema DDL
CREATE TABLE "Sessions" ("session_id" INTEGER PRIMARY KEY, "duration" INTEGER, CHECK ("duration" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO sessions (session_id, duration) VALUES (6, 60), (899, 4), (599, 6), (10, 600), (2, 301), (301, 599), (300, 1), (16, 16), (14, 301), (0, 900), (4, 14), (-1, 16), (1, 4);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT '[0-5>' AS bin, COUNT(session_id) AS total FROM sessions WHERE ((CAST(duration AS REAL) / 60) >= 0 AND (CAST(duration AS REAL) / 60) < 5) UNION SELECT '[5-10>' AS bin, COUNT(session_id) AS total FROM sessions WHERE ((CAST(duration AS REAL) / 60) >= 5 AND (CAST(duration AS REAL) / 60) < 10) UNION SELECT '[10-15>' AS bin, COUNT(session_id) AS total FROM sessions WHERE ((CAST(duration AS REAL) / 60) >= 10 AND (CAST(duration AS REAL) / 60) < 15) UNION SELECT '15 or more' AS bin, COUNT(session_id) AS total FROM sessions WHERE (CAST(duration AS REAL) / 60) >= 15;

/*
Gold Result:
('15 or more', 1)
('[0-5>', 8)
('[10-15>', 1)
('[5-10>', 3)
*/

-- Prediction Query
SELECT '[0-5>' AS BIN, COUNT(IIF(DURATION < 300, 1, NULL)) AS TOTAL FROM SESSIONS UNION SELECT '[5-10>' AS BIN, COUNT(IIF(DURATION >= 300 AND DURATION < 600, 1, NULL)) AS TOTAL FROM SESSIONS UNION SELECT '[10-15>' AS BIN, COUNT(IIF(DURATION >= 600 AND DURATION < 900, 1, NULL)) AS TOTAL FROM SESSIONS UNION SELECT '15 or more' AS BIN, COUNT(IIF(DURATION > 900, 1, NULL)) AS TOTAL FROM SESSIONS;

/*
Prediction Result:
('15 or more', 0)
('[0-5>', 8)
('[10-15>', 1)
('[5-10>', 3)
*/