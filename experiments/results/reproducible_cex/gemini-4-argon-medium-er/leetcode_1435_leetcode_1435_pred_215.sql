-- Schema DDL
CREATE TABLE "Sessions" ("session_id" INTEGER PRIMARY KEY, "duration" INTEGER, CHECK ("duration" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Sessions" ("session_id", "duration") VALUES (1, 100);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT '[0-5>' AS bin, COUNT(session_id) AS total FROM sessions WHERE ((CAST(duration AS REAL) / 60) >= 0 AND (CAST(duration AS REAL) / 60) < 5) UNION SELECT '[5-10>' AS bin, COUNT(session_id) AS total FROM sessions WHERE ((CAST(duration AS REAL) / 60) >= 5 AND (CAST(duration AS REAL) / 60) < 10) UNION SELECT '[10-15>' AS bin, COUNT(session_id) AS total FROM sessions WHERE ((CAST(duration AS REAL) / 60) >= 10 AND (CAST(duration AS REAL) / 60) < 15) UNION SELECT '15 or more' AS bin, COUNT(session_id) AS total FROM sessions WHERE (CAST(duration AS REAL) / 60) >= 15;

/*
Gold Result:
('15 or more', 0)
('[0-5>', 1)
('[10-15>', 0)
('[5-10>', 0)
*/

-- Prediction Query
SELECT SUM(CASE WHEN DURATION < 300 THEN 1 ELSE 0 END) AS TOTAL, '[0-5>' AS BIN FROM SESSIONS UNION SELECT SUM(CASE WHEN DURATION >= 300 AND DURATION < 600 THEN 1 ELSE 0 END) AS TOTAL, '[5-10>' AS BIN FROM SESSIONS UNION SELECT SUM(CASE WHEN DURATION >= 600 AND DURATION < 900 THEN 1 ELSE 0 END) AS TOTAL, '[10-15>' AS BIN FROM SESSIONS UNION SELECT SUM(CASE WHEN DURATION >= 900 THEN 1 ELSE 0 END) AS TOTAL, '15 or more' AS BIN FROM SESSIONS;

/*
Prediction Result:
(0, '15 or more')
(0, '[10-15>')
(0, '[5-10>')
(1, '[0-5>')
*/