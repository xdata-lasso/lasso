-- Schema DDL
CREATE TABLE "Sessions" ("session_id" INTEGER PRIMARY KEY, "duration" INTEGER, CHECK ("duration" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO sessions (session_id, duration) VALUES (1, NULL), (-1, 901), (0, 16);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT '[0-5>' AS bin, COUNT(session_id) AS total FROM sessions WHERE ((CAST(duration AS REAL) / 60) >= 0 AND (CAST(duration AS REAL) / 60) < 5) UNION SELECT '[5-10>' AS bin, COUNT(session_id) AS total FROM sessions WHERE ((CAST(duration AS REAL) / 60) >= 5 AND (CAST(duration AS REAL) / 60) < 10) UNION SELECT '[10-15>' AS bin, COUNT(session_id) AS total FROM sessions WHERE ((CAST(duration AS REAL) / 60) >= 10 AND (CAST(duration AS REAL) / 60) < 15) UNION SELECT '15 or more' AS bin, COUNT(session_id) AS total FROM sessions WHERE (CAST(duration AS REAL) / 60) >= 15;

/*
Gold Result:
('15 or more', 1)
('[0-5>', 1)
('[10-15>', 0)
('[5-10>', 0)
*/

-- Prediction Query
WITH NEW AS (SELECT '[0-5>' AS BIN UNION ALL SELECT '[5-10>' UNION ALL SELECT '[10-15>' UNION ALL SELECT '15 or more') SELECT N.BIN, COALESCE(TOTAL, 0) AS TOTAL FROM NEW AS N LEFT JOIN (SELECT BIN, COUNT(SESSION_ID) AS TOTAL FROM (SELECT SESSION_ID, CASE WHEN DURATION >= 0 AND DURATION < 300 THEN '[0-5>' WHEN DURATION >= 300 AND DURATION < 600 THEN '[5-10>' WHEN DURATION >= 600 AND DURATION < 900 THEN '[10-15>' ELSE '15 or more' END AS BIN FROM SESSIONS) AS T GROUP BY 1) AS T2 ON N.BIN = T2.BIN;

/*
Prediction Result:
('[0-5>', 1)
('[5-10>', 0)
('[10-15>', 0)
('15 or more', 2)
*/