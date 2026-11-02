-- Schema DDL
CREATE TABLE "Sessions" ("session_id" INTEGER PRIMARY KEY, "duration" INTEGER, CHECK ("duration" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO Sessions (session_id, duration) VALUES (1, NULL);
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
WITH SUMMARY AS (SELECT CASE WHEN CAST(DURATION AS REAL) / 60 < 5 THEN '[0-5>' WHEN CAST(DURATION AS REAL) / 60 < 10 THEN '[5-10>' WHEN CAST(DURATION AS REAL) / 60 < 15 THEN '[10-15>' ELSE '15 or more' END AS BIN, COALESCE(COUNT(DISTINCT SESSION_ID), 0) AS TOTAL FROM SESSIONS GROUP BY CASE WHEN CAST(DURATION AS REAL) / 60 < 5 THEN '[0-5>' WHEN CAST(DURATION AS REAL) / 60 < 10 THEN '[5-10>' WHEN CAST(DURATION AS REAL) / 60 < 15 THEN '[10-15>' ELSE '15 or more' END), BINS AS (SELECT '[0-5>' AS BINS UNION SELECT '[5-10>' AS BINS UNION SELECT '[10-15>' AS BINS UNION SELECT '15 or more' AS BINS) SELECT BINS.BINS AS BIN, COALESCE(SUMMARY.TOTAL, 0) AS TOTAL FROM BINS LEFT JOIN SUMMARY ON BINS.BINS = SUMMARY.BIN;

/*
Prediction Result:
('15 or more', 1)
('[0-5>', 0)
('[10-15>', 0)
('[5-10>', 0)
*/