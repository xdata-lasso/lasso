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
WITH CTE AS (SELECT SUM((CAST(DURATION AS REAL) / 60) < 5) AS BIN1, SUM((CAST(DURATION AS REAL) / 60) >= 5 AND (CAST(DURATION AS REAL) / 60) <= 10) AS BIN2, SUM((CAST(DURATION AS REAL) / 60) >= 10 AND (CAST(DURATION AS REAL) / 60) <= 15) AS BIN3, SUM((CAST(DURATION AS REAL) / 60) > 15) AS BIN4 FROM SESSIONS) SELECT '[0-5>' AS BIN, BIN1 AS TOTAL FROM CTE UNION SELECT '[5-10>' AS BIN, BIN2 AS TOTAL FROM CTE UNION SELECT '[10-15>' AS BIN, BIN3 AS TOTAL FROM CTE UNION SELECT '15 or more' AS BIN, BIN4 AS TOTAL FROM CTE;

/*
Prediction Result:
('15 or more', None)
('[0-5>', None)
('[10-15>', None)
('[5-10>', None)
*/