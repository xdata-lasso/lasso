-- Schema DDL
CREATE TABLE "Sessions" ("session_id" INTEGER PRIMARY KEY, "duration" INTEGER, CHECK ("duration" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO sessions (session_id, duration) VALUES (4, 600), (10, 16), (5, 61);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT '[0-5>' AS bin, COUNT(session_id) AS total FROM sessions WHERE ((CAST(duration AS REAL) / 60) >= 0 AND (CAST(duration AS REAL) / 60) < 5) UNION SELECT '[5-10>' AS bin, COUNT(session_id) AS total FROM sessions WHERE ((CAST(duration AS REAL) / 60) >= 5 AND (CAST(duration AS REAL) / 60) < 10) UNION SELECT '[10-15>' AS bin, COUNT(session_id) AS total FROM sessions WHERE ((CAST(duration AS REAL) / 60) >= 10 AND (CAST(duration AS REAL) / 60) < 15) UNION SELECT '15 or more' AS bin, COUNT(session_id) AS total FROM sessions WHERE (CAST(duration AS REAL) / 60) >= 15;

/*
Gold Result:
('15 or more', 0)
('[0-5>', 2)
('[10-15>', 1)
('[5-10>', 0)
*/

-- Prediction Query
SELECT '[0-5>' AS BIN, COUNT(DURATION) AS TOTAL FROM SESSIONS WHERE DURATION < 300 UNION SELECT '[5-10>' AS BIN, COUNT(DURATION) AS TOTAL FROM SESSIONS WHERE DURATION BETWEEN 300 AND 600 UNION SELECT '[10-15>' AS BIN, COUNT(DURATION) AS TOTAL FROM SESSIONS WHERE DURATION BETWEEN 600 AND 900 UNION SELECT '15 or more' AS BIN, COUNT(DURATION) AS TOTAL FROM SESSIONS WHERE DURATION >= 900;

/*
Prediction Result:
('15 or more', 0)
('[0-5>', 2)
('[10-15>', 1)
('[5-10>', 1)
*/