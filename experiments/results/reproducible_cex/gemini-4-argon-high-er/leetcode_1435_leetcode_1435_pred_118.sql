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
WITH CTE_BINS AS (SELECT '[0-5>' AS BIN UNION SELECT '[5-10>' UNION SELECT '[10-15>' UNION SELECT '15 or more'), CTE_JOIN AS (SELECT SESSION_ID, CASE WHEN DURATION BETWEEN 0 AND 300 THEN '[0-5>' WHEN DURATION BETWEEN 300 AND 600 THEN '[5-10>' WHEN DURATION BETWEEN 600 AND 900 THEN '[10-15>' WHEN DURATION BETWEEN 600 AND 900 THEN '[10-15>' WHEN DURATION > 900 THEN '15 or more' ELSE 0 END AS BIN FROM SESSIONS) SELECT CB.BIN, COALESCE(COUNT(SESSION_ID), 0) AS TOTAL FROM CTE_BINS AS CB LEFT JOIN CTE_JOIN AS CJ ON CB.BIN = CJ.BIN GROUP BY CB.BIN;

/*
Prediction Result:
('15 or more', 0)
('[0-5>', 1)
('[10-15>', 0)
('[5-10>', 0)
*/