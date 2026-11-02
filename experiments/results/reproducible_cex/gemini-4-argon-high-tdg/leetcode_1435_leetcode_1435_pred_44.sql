-- Schema DDL
CREATE TABLE "Sessions" ("session_id" INTEGER PRIMARY KEY, "duration" INTEGER, CHECK ("duration" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 7
INSERT INTO Sessions (session_id, duration) VALUES (1, 100);
INSERT INTO Sessions (session_id, duration) VALUES (2, NULL);
INSERT INTO Sessions (session_id, duration) VALUES (3, 400);
INSERT INTO Sessions (session_id, duration) VALUES (4, 700);
INSERT INTO Sessions (session_id, duration) VALUES (5, 1000);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT '[0-5>' AS bin, COUNT(session_id) AS total FROM sessions WHERE ((CAST(duration AS REAL) / 60) >= 0 AND (CAST(duration AS REAL) / 60) < 5) UNION SELECT '[5-10>' AS bin, COUNT(session_id) AS total FROM sessions WHERE ((CAST(duration AS REAL) / 60) >= 5 AND (CAST(duration AS REAL) / 60) < 10) UNION SELECT '[10-15>' AS bin, COUNT(session_id) AS total FROM sessions WHERE ((CAST(duration AS REAL) / 60) >= 10 AND (CAST(duration AS REAL) / 60) < 15) UNION SELECT '15 or more' AS bin, COUNT(session_id) AS total FROM sessions WHERE (CAST(duration AS REAL) / 60) >= 15;

/*
Gold Result:
('15 or more', 1)
('[0-5>', 1)
('[10-15>', 1)
('[5-10>', 1)
*/

-- Prediction Query
WITH CTE1 AS (SELECT '[0-5>' AS BIN UNION SELECT '[5-10>' AS BIN UNION SELECT '[10-15>' AS BIN UNION SELECT '15 or more' AS BIN), CTE2 AS (SELECT AGG.BIN, COUNT(*) AS TOTAL FROM (SELECT SESSION_ID, CASE WHEN ROUND(CAST(DURATION AS REAL) / 60, 3) BETWEEN 0 AND 4.999 THEN '[0-5>' WHEN ROUND(CAST(DURATION AS REAL) / 60, 3) BETWEEN 5 AND 9.999 THEN '[5-10>' WHEN ROUND(CAST(DURATION AS REAL) / 60, 3) BETWEEN 10 AND 14.999 THEN '[10-15>' ELSE '15 or more' END AS BIN, ROUND(CAST(DURATION AS REAL) / 60, 3) FROM SESSIONS) AS AGG GROUP BY 1) SELECT CTE1.BIN, COALESCE(CTE2.TOTAL, 0) AS TOTAL FROM CTE1 LEFT JOIN CTE2 ON CTE1.BIN = CTE2.BIN;

/*
Prediction Result:
('15 or more', 2)
('[0-5>', 1)
('[10-15>', 1)
('[5-10>', 1)
*/