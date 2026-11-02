-- Schema DDL
CREATE TABLE "Sessions" ("session_id" INTEGER PRIMARY KEY, "duration" INTEGER, CHECK ("duration" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT '[0-5>' AS bin, COUNT(session_id) AS total FROM sessions WHERE ((CAST(duration AS REAL) / 60) >= 0 AND (CAST(duration AS REAL) / 60) < 5) UNION SELECT '[5-10>' AS bin, COUNT(session_id) AS total FROM sessions WHERE ((CAST(duration AS REAL) / 60) >= 5 AND (CAST(duration AS REAL) / 60) < 10) UNION SELECT '[10-15>' AS bin, COUNT(session_id) AS total FROM sessions WHERE ((CAST(duration AS REAL) / 60) >= 10 AND (CAST(duration AS REAL) / 60) < 15) UNION SELECT '15 or more' AS bin, COUNT(session_id) AS total FROM sessions WHERE (CAST(duration AS REAL) / 60) >= 15;

/*
Gold Result:
('15 or more', 0)
('[0-5>', 0)
('[10-15>', 0)
('[5-10>', 0)
*/

-- Prediction Query
SELECT '[0-5>' AS BIN, COUNT(CASE WHEN DURATION >= 0 AND DURATION < 300 THEN '[0-5>' END) AS TOTAL FROM SESSIONS GROUP BY BIN UNION ALL SELECT '[5-10>' AS BIN, COUNT(CASE WHEN DURATION >= 300 AND DURATION < 600 THEN '[5-10>' END) AS TOTAL FROM SESSIONS GROUP BY BIN UNION ALL SELECT '[10-15>' AS BIN, COUNT(CASE WHEN DURATION >= 600 AND DURATION < 900 THEN '[10-15>' END) AS TOTAL FROM SESSIONS GROUP BY BIN UNION ALL SELECT '15 or more' AS BIN, COUNT(CASE WHEN DURATION >= 900 THEN '15 or more' END) AS TOTAL FROM SESSIONS GROUP BY BIN;

/*
Prediction Result:
*/