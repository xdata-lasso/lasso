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
WITH SESSION_TIME AS (SELECT SESSION_ID, CASE WHEN CAST(DURATION AS REAL) / 60.0 < 5 THEN '[0-5>' WHEN CAST(DURATION AS REAL) / 60.0 >= 5 AND CAST(DURATION AS REAL) / 60.0 < 10 THEN '[5-10>' WHEN CAST(DURATION AS REAL) / 60.0 >= 10 AND CAST(DURATION AS REAL) / 60.0 < 15 THEN '[10-15>' ELSE '15 or more' END AS BIN FROM SESSIONS), BINS AS (SELECT '[0-5>' AS BIN UNION SELECT '[5-10>' AS BIN UNION SELECT '[10-15>' AS BIN UNION SELECT '15 or more AS BIN') SELECT B.BIN, COUNT(S.SESSION_ID) AS TOTAL FROM BINS AS B LEFT JOIN SESSION_TIME AS S ON B.BIN = S.BIN GROUP BY B.BIN;

/*
Prediction Result:
('15 or more AS BIN', 0)
('[0-5>', 0)
('[10-15>', 0)
('[5-10>', 0)
*/