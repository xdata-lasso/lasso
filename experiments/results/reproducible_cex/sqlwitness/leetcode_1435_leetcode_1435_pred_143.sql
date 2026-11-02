-- Schema DDL
CREATE TABLE "Sessions" ("session_id" INTEGER PRIMARY KEY, "duration" INTEGER, CHECK ("duration" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO sessions (session_id, duration) VALUES (16, 2147483647), (2147483646, 11), (2147483648, 5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT '[0-5>' AS bin, COUNT(session_id) AS total FROM sessions WHERE ((CAST(duration AS REAL) / 60) >= 0 AND (CAST(duration AS REAL) / 60) < 5) UNION SELECT '[5-10>' AS bin, COUNT(session_id) AS total FROM sessions WHERE ((CAST(duration AS REAL) / 60) >= 5 AND (CAST(duration AS REAL) / 60) < 10) UNION SELECT '[10-15>' AS bin, COUNT(session_id) AS total FROM sessions WHERE ((CAST(duration AS REAL) / 60) >= 10 AND (CAST(duration AS REAL) / 60) < 15) UNION SELECT '15 or more' AS bin, COUNT(session_id) AS total FROM sessions WHERE (CAST(duration AS REAL) / 60) >= 15;

/*
Gold Result:
('15 or more', 1)
('[0-5>', 2)
('[10-15>', 0)
('[5-10>', 0)
*/

-- Prediction Query
WITH CTE AS (SELECT '[0-5>' AS BIN, 0 AS START_TIME, 5 * 60 AS END_TIME UNION SELECT '[5-10>' AS BIN, 5 * 60 AS START_TIME, 10 * 60 AS END_TIME UNION SELECT '[10-15>' AS BIN, 10 * 60 AS START_TIME, 15 * 60 AS END_TIME UNION SELECT '15 or more' AS BIN, 15 * 60 AS START_TIME, 2147483647 AS END_TIME), BIN_ASSIGNMENT AS (SELECT * FROM CTE AS C LEFT JOIN SESSIONS AS S ON S.DURATION >= C.START_TIME AND S.DURATION < C.END_TIME ORDER BY DURATION, S.session_id NULLS LAST) SELECT BIN, COUNT(SESSION_ID) AS TOTAL FROM BIN_ASSIGNMENT GROUP BY BIN;

/*
Prediction Result:
('15 or more', 0)
('[0-5>', 2)
('[10-15>', 0)
('[5-10>', 0)
*/