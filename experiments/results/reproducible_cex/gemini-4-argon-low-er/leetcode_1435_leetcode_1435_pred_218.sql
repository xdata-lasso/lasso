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
WITH BINS AS (SELECT '[0-5>' AS BIN, 0 AS MIN, 300 AS MAX UNION SELECT '[5-10>' AS BIN, 300 AS MIN, 600 AS MAX UNION SELECT '[10-15>' AS BIN, 600 AS MIN, 900 AS MAX UNION SELECT '15 or more' AS BIN, 900 AS MIN, NULL AS MAX) SELECT B.BIN, COUNT(S.SESSION_ID) AS TOTAL FROM BINS AS B LEFT JOIN SESSIONS AS S ON S.DURATION >= B.MIN AND (B.MAX IS NULL OR S.DURATION <= B.MAX) GROUP BY 1;

/*
Prediction Result:
('15 or more', 0)
('[0-5>', 1)
('[10-15>', 0)
('[5-10>', 1)
*/