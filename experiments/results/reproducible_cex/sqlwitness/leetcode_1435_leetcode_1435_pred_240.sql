-- Schema DDL
CREATE TABLE "Sessions" ("session_id" INTEGER PRIMARY KEY, "duration" INTEGER, CHECK ("duration" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO sessions (session_id, duration) VALUES (2, NULL), (15, 15), (11, 61), (0, 15), (16, 2), (5, 2), (6, 2), (-1, NULL), (1, 15), (4, NULL), (10, 60);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT '[0-5>' AS bin, COUNT(session_id) AS total FROM sessions WHERE ((CAST(duration AS REAL) / 60) >= 0 AND (CAST(duration AS REAL) / 60) < 5) UNION SELECT '[5-10>' AS bin, COUNT(session_id) AS total FROM sessions WHERE ((CAST(duration AS REAL) / 60) >= 5 AND (CAST(duration AS REAL) / 60) < 10) UNION SELECT '[10-15>' AS bin, COUNT(session_id) AS total FROM sessions WHERE ((CAST(duration AS REAL) / 60) >= 10 AND (CAST(duration AS REAL) / 60) < 15) UNION SELECT '15 or more' AS bin, COUNT(session_id) AS total FROM sessions WHERE (CAST(duration AS REAL) / 60) >= 15;

/*
Gold Result:
('15 or more', 0)
('[0-5>', 8)
('[10-15>', 0)
('[5-10>', 0)
*/

-- Prediction Query
WITH BIN AS (SELECT '[0-5>' AS BIN UNION SELECT '[5-10>' AS BIN UNION SELECT '[10-15>' AS BIN UNION SELECT '15 or more' AS BIN), TMP AS (SELECT *, CASE WHEN (CAST(DURATION AS REAL) / 60) < 5 THEN '[0-5>' WHEN (CAST(DURATION AS REAL) / 60) >= 5 AND (CAST(DURATION AS REAL) / 60) < 10 THEN '[5-10>' WHEN (CAST(DURATION AS REAL) / 60) >= 10 AND (CAST(DURATION AS REAL) / 60) < 15 THEN '[10-15>' ELSE '15 or more' END AS BIN FROM SESSIONS) SELECT BIN.BIN, COALESCE(COUNT(TMP.SESSION_ID), 0) AS TOTAL FROM BIN LEFT JOIN TMP USING (BIN) GROUP BY 1;

/*
Prediction Result:
('15 or more', 3)
('[0-5>', 8)
('[10-15>', 0)
('[5-10>', 0)
*/