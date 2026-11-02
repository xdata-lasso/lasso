-- Schema DDL
CREATE TABLE "Sessions" ("session_id" INTEGER PRIMARY KEY, "duration" INTEGER, CHECK ("duration" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO sessions (session_id, duration) VALUES (9, 10), (5, 14), (15, 14), (6, NULL), (4, 1), (59, 4), (60, 4), (11, 60), (16, 2), (0, 10), (-1, 16), (1, 60);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT '[0-5>' AS bin, COUNT(session_id) AS total FROM sessions WHERE ((CAST(duration AS REAL) / 60) >= 0 AND (CAST(duration AS REAL) / 60) < 5) UNION SELECT '[5-10>' AS bin, COUNT(session_id) AS total FROM sessions WHERE ((CAST(duration AS REAL) / 60) >= 5 AND (CAST(duration AS REAL) / 60) < 10) UNION SELECT '[10-15>' AS bin, COUNT(session_id) AS total FROM sessions WHERE ((CAST(duration AS REAL) / 60) >= 10 AND (CAST(duration AS REAL) / 60) < 15) UNION SELECT '15 or more' AS bin, COUNT(session_id) AS total FROM sessions WHERE (CAST(duration AS REAL) / 60) >= 15;

/*
Gold Result:
('15 or more', 0)
('[0-5>', 11)
('[10-15>', 0)
('[5-10>', 0)
*/

-- Prediction Query
WITH ALL_BIN AS (SELECT '[0-5>' AS BIN UNION SELECT '[5-10>' AS BIN UNION SELECT '[10-15>' AS BIN UNION SELECT '15 or more' AS BIN) SELECT ALL_BIN.BIN, COALESCE(C.TOTAL, 0) AS TOTAL FROM ALL_BIN LEFT JOIN (SELECT BIN, COUNT(*) AS TOTAL FROM (SELECT SESSION_ID, CASE WHEN CAST(DURATION AS REAL) / 60 < 5 THEN '[0-5>' WHEN CAST(DURATION AS REAL) / 60 < 10 THEN '[5-10>' WHEN CAST(DURATION AS REAL) / 60 < 15 THEN '[10-15>' ELSE '15 or more' END AS BIN FROM SESSIONS) AS A GROUP BY 1) AS C USING (BIN);

/*
Prediction Result:
('15 or more', 1)
('[0-5>', 11)
('[10-15>', 0)
('[5-10>', 0)
*/