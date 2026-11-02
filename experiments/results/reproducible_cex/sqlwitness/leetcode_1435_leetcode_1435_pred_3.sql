-- Schema DDL
CREATE TABLE "Sessions" ("session_id" INTEGER PRIMARY KEY, "duration" INTEGER, CHECK ("duration" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO sessions (session_id, duration) VALUES (901, 15), (59, 10), (2, 299), (599, 2), (600, 6), (0, 15), (1, 599), (4, 15), (601, 11), (301, 301), (-1, 10), (900, 900);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT '[0-5>' AS bin, COUNT(session_id) AS total FROM sessions WHERE ((CAST(duration AS REAL) / 60) >= 0 AND (CAST(duration AS REAL) / 60) < 5) UNION SELECT '[5-10>' AS bin, COUNT(session_id) AS total FROM sessions WHERE ((CAST(duration AS REAL) / 60) >= 5 AND (CAST(duration AS REAL) / 60) < 10) UNION SELECT '[10-15>' AS bin, COUNT(session_id) AS total FROM sessions WHERE ((CAST(duration AS REAL) / 60) >= 10 AND (CAST(duration AS REAL) / 60) < 15) UNION SELECT '15 or more' AS bin, COUNT(session_id) AS total FROM sessions WHERE (CAST(duration AS REAL) / 60) >= 15;

/*
Gold Result:
('15 or more', 1)
('[0-5>', 9)
('[10-15>', 0)
('[5-10>', 2)
*/

-- Prediction Query
SELECT '[0-5>' AS BIN, SUM(CASE WHEN DURATION >= 0 AND DURATION < 300 THEN 1 ELSE 0 END) AS TOTAL FROM SESSIONS GROUP BY 1 UNION SELECT '[5-10>' AS BIN, SUM(CASE WHEN DURATION >= 300 AND DURATION < 600 THEN 1 ELSE 0 END) AS TOTAL FROM SESSIONS GROUP BY 1 UNION SELECT '[10-15>' AS BIN, SUM(CASE WHEN DURATION >= 600 AND DURATION < 900 THEN 1 ELSE 0 END) AS TOTAL FROM SESSIONS GROUP BY 1 UNION SELECT '15 or more' AS BIN, SUM(CASE WHEN DURATION > 900 THEN 1 ELSE 0 END) AS TOTAL FROM SESSIONS GROUP BY 1;

/*
Prediction Result:
('15 or more', 0)
('[0-5>', 9)
('[10-15>', 0)
('[5-10>', 2)
*/