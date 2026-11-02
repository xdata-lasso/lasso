-- Schema DDL
CREATE TABLE "Sessions" ("session_id" INTEGER PRIMARY KEY, "duration" INTEGER, CHECK ("duration" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO sessions (session_id, duration) VALUES (300, 4), (301, 16), (0, 60), (11, 6), (59, 900), (15, 5), (6, 600), (-1, 11), (901, 14), (10, 10), (5, 1), (9, 301), (1, 5), (900, 15), (899, 60);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT '[0-5>' AS bin, COUNT(session_id) AS total FROM sessions WHERE ((CAST(duration AS REAL) / 60) >= 0 AND (CAST(duration AS REAL) / 60) < 5) UNION SELECT '[5-10>' AS bin, COUNT(session_id) AS total FROM sessions WHERE ((CAST(duration AS REAL) / 60) >= 5 AND (CAST(duration AS REAL) / 60) < 10) UNION SELECT '[10-15>' AS bin, COUNT(session_id) AS total FROM sessions WHERE ((CAST(duration AS REAL) / 60) >= 10 AND (CAST(duration AS REAL) / 60) < 15) UNION SELECT '15 or more' AS bin, COUNT(session_id) AS total FROM sessions WHERE (CAST(duration AS REAL) / 60) >= 15;

/*
Gold Result:
('15 or more', 1)
('[0-5>', 12)
('[10-15>', 1)
('[5-10>', 1)
*/

-- Prediction Query
SELECT '[0-5>' AS BIN, COUNT(CASE WHEN DURATION < 300 THEN SESSION_ID ELSE NULL END) AS TOTAL FROM SESSIONS UNION SELECT '[5-10>' AS BIN, COUNT(CASE WHEN DURATION >= 300 AND DURATION < 600 THEN SESSION_ID ELSE NULL END) AS TOTAL FROM SESSIONS UNION SELECT '[10-15>' AS BIN, COUNT(CASE WHEN DURATION >= 600 AND DURATION < 900 THEN SESSION_ID ELSE NULL END) AS TOTAL FROM SESSIONS UNION SELECT '15 or more' AS BIN, COUNT(CASE WHEN DURATION > 900 THEN SESSION_ID ELSE NULL END) AS TOTAL FROM SESSIONS;

/*
Prediction Result:
('15 or more', 0)
('[0-5>', 12)
('[10-15>', 1)
('[5-10>', 1)
*/