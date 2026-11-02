-- Schema DDL
CREATE TABLE "Sessions" ("session_id" INTEGER PRIMARY KEY, "duration" INTEGER, CHECK ("duration" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "sessions" ("session_id", "duration") VALUES (1009, 1010);
INSERT INTO "sessions" ("session_id", "duration") VALUES (1011, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT '[0-5>' AS bin, COUNT(session_id) AS total FROM sessions WHERE ((CAST(duration AS REAL) / 60) >= 0 AND (CAST(duration AS REAL) / 60) < 5) UNION SELECT '[5-10>' AS bin, COUNT(session_id) AS total FROM sessions WHERE ((CAST(duration AS REAL) / 60) >= 5 AND (CAST(duration AS REAL) / 60) < 10) UNION SELECT '[10-15>' AS bin, COUNT(session_id) AS total FROM sessions WHERE ((CAST(duration AS REAL) / 60) >= 10 AND (CAST(duration AS REAL) / 60) < 15) UNION SELECT '15 or more' AS bin, COUNT(session_id) AS total FROM sessions WHERE (CAST(duration AS REAL) / 60) >= 15;

/*
Gold Result:
('15 or more', 1)
('[0-5>', 0)
('[10-15>', 0)
('[5-10>', 0)
*/

-- Prediction Query
WITH CTE AS (SELECT '[0-5>' AS BIN UNION ALL SELECT '[5-10>' AS BIN UNION ALL SELECT '[10-15>' AS BIN UNION ALL SELECT '15 or more' AS BIN) SELECT CTE.BIN AS BIN, COALESCE(B.TOTAL, 0) AS TOTAL FROM CTE LEFT JOIN (SELECT BIN, COUNT(*) AS TOTAL FROM (SELECT CASE WHEN DURATION BETWEEN 0 AND 299 THEN '[0-5>' WHEN DURATION BETWEEN 300 AND 599 THEN '[5-10>' WHEN DURATION BETWEEN 600 AND 899 THEN '[10-15>' ELSE '15 or more' END AS BIN FROM SESSIONS) AS T GROUP BY BIN) AS B ON CTE.BIN = B.BIN;

/*
Prediction Result:
('[0-5>', 0)
('[5-10>', 0)
('[10-15>', 0)
('15 or more', 2)
*/