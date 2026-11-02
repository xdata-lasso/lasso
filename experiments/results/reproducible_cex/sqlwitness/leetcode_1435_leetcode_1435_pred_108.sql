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
WITH BINS AS (SELECT '[0-5>' AS BIN, 0 AS MIN, 5 AS MAX, 1 AS OD UNION ALL SELECT '15 or more' AS BIN, 15 AS MIN, NULL AS MAX, 4 AS OD UNION ALL SELECT '[5-10>' AS BIN, 5 AS MIN, 10 AS MAX, 2 AS OD UNION ALL SELECT '[10-15>' AS BIN, 10 AS MIN, 15 AS MAX, 3 AS OD) SELECT BIN AS BIN, COUNT(SESSION_ID) AS TOTAL FROM BINS AS B LEFT JOIN SESSIONS AS S ON CAST(S.DURATION AS REAL) / 60.0 >= B.MIN AND (B.MAX IS NULL OR CAST(S.DURATION AS REAL) / 60.0 < B.MAX) GROUP BY 1 ORDER BY OD, BIN NULLS LAST, TOTAL NULLS LAST;

/*
Prediction Result:
('[0-5>', 0)
('[5-10>', 0)
('[10-15>', 0)
('15 or more', 0)
*/