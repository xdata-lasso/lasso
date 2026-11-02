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
WITH DURATION_IN_MINUTE AS (SELECT *, ROUND(CAST(DURATION AS REAL) / 60, 4) AS TIME_IN_MINUTES FROM SESSIONS) SELECT '[0-5>' AS BIN, SUM(CASE WHEN TIME_IN_MINUTES BETWEEN 0 AND 4.9999 THEN 1 ELSE 0 END) AS TOTAL FROM DURATION_IN_MINUTE UNION SELECT '[5-10>' AS BIN, SUM(CASE WHEN TIME_IN_MINUTES BETWEEN 5 AND 9.9999 THEN 1 ELSE 0 END) AS TOTAL FROM DURATION_IN_MINUTE UNION SELECT '[10-15>' AS BIN, SUM(CASE WHEN TIME_IN_MINUTES BETWEEN 10 AND 14.9999 THEN 1 ELSE 0 END) AS TOTAL FROM DURATION_IN_MINUTE UNION SELECT '15 or more' AS BIN, SUM(CASE WHEN TIME_IN_MINUTES >= 15 THEN 1 ELSE 0 END) AS TOTAL FROM DURATION_IN_MINUTE;

/*
Prediction Result:
('15 or more', None)
('[0-5>', None)
('[10-15>', None)
('[5-10>', None)
*/