-- Schema DDL
CREATE TABLE "Sessions" ("session_id" INTEGER PRIMARY KEY, "duration" INTEGER, CHECK ("duration" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO Sessions (session_id, duration) VALUES (1, 300);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT '[0-5>' AS bin, COUNT(session_id) AS total FROM sessions WHERE ((CAST(duration AS REAL) / 60) >= 0 AND (CAST(duration AS REAL) / 60) < 5) UNION SELECT '[5-10>' AS bin, COUNT(session_id) AS total FROM sessions WHERE ((CAST(duration AS REAL) / 60) >= 5 AND (CAST(duration AS REAL) / 60) < 10) UNION SELECT '[10-15>' AS bin, COUNT(session_id) AS total FROM sessions WHERE ((CAST(duration AS REAL) / 60) >= 10 AND (CAST(duration AS REAL) / 60) < 15) UNION SELECT '15 or more' AS bin, COUNT(session_id) AS total FROM sessions WHERE (CAST(duration AS REAL) / 60) >= 15;

/*
Gold Result:
('15 or more', 0)
('[0-5>', 0)
('[10-15>', 0)
('[5-10>', 1)
*/

-- Prediction Query
SELECT '[0-5>' AS BIN, COUNT(CASE WHEN CAST(DURATION AS REAL) / 60 BETWEEN 0 AND 5 THEN SESSION_ID END) AS TOTAL FROM SESSIONS UNION SELECT '[5-10>' AS BIN, COUNT(CASE WHEN CAST(DURATION AS REAL) / 60 BETWEEN 5 AND 10 THEN SESSION_ID END) AS TOTAL FROM SESSIONS UNION SELECT '[10-15>' AS BIN, COUNT(CASE WHEN CAST(DURATION AS REAL) / 60 BETWEEN 10 AND 15 THEN SESSION_ID END) AS TOTAL FROM SESSIONS UNION SELECT '15 or more' AS BIN, COUNT(CASE WHEN CAST(DURATION AS REAL) / 60 > 15 THEN SESSION_ID END) AS TOTAL FROM SESSIONS;

/*
Prediction Result:
('15 or more', 0)
('[0-5>', 1)
('[10-15>', 0)
('[5-10>', 1)
*/