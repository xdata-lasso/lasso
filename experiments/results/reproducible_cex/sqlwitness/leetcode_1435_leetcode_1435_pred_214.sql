-- Schema DDL
CREATE TABLE "Sessions" ("session_id" INTEGER PRIMARY KEY, "duration" INTEGER, CHECK ("duration" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO sessions (session_id, duration) VALUES (2147483647, 2147483646), (59, 2147483647), (-1, 5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT '[0-5>' AS bin, COUNT(session_id) AS total FROM sessions WHERE ((CAST(duration AS REAL) / 60) >= 0 AND (CAST(duration AS REAL) / 60) < 5) UNION SELECT '[5-10>' AS bin, COUNT(session_id) AS total FROM sessions WHERE ((CAST(duration AS REAL) / 60) >= 5 AND (CAST(duration AS REAL) / 60) < 10) UNION SELECT '[10-15>' AS bin, COUNT(session_id) AS total FROM sessions WHERE ((CAST(duration AS REAL) / 60) >= 10 AND (CAST(duration AS REAL) / 60) < 15) UNION SELECT '15 or more' AS bin, COUNT(session_id) AS total FROM sessions WHERE (CAST(duration AS REAL) / 60) >= 15;

/*
Gold Result:
('15 or more', 2)
('[0-5>', 1)
('[10-15>', 0)
('[5-10>', 0)
*/

-- Prediction Query
WITH BINS AS (SELECT 0 * 60 AS LB, 5 * 60 AS UB, '[0-5>' AS BIN UNION SELECT 5 * 60 AS LB, 10 * 60 AS UB, '[5-10>' AS BIN UNION SELECT 10 * 60 AS LB, 15 * 60 AS UB, '[10-15>' AS BIN UNION SELECT 15 * 60 AS LB, 2147483647 AS UB, '15 or more' AS BIN) SELECT B.BIN, COALESCE(COUNT(S.SESSION_ID), 0) AS TOTAL FROM BINS AS B LEFT JOIN SESSIONS AS S ON S.DURATION >= B.LB AND S.DURATION < B.UB GROUP BY B.BIN;

/*
Prediction Result:
('15 or more', 1)
('[0-5>', 1)
('[10-15>', 0)
('[5-10>', 0)
*/