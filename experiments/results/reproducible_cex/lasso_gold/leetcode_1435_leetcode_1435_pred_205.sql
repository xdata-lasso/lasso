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
SELECT T1.BIN, COALESCE(T2.TOTAL, 0) AS TOTAL FROM (SELECT '[0-5>' AS BIN UNION SELECT '[5-10>' AS BIN UNION SELECT '[10-15>' AS BIN UNION SELECT '15 or more' AS BIN) AS T1 LEFT JOIN (SELECT CASE WHEN DURATION < 300 THEN '[0-5>' WHEN DURATION < 600 THEN '[5-10>' WHEN DURATION < 900 THEN '[10-15>' ELSE '15 or more' END AS BIN, COUNT(*) AS TOTAL FROM SESSIONS GROUP BY 1) AS T2 ON T1.BIN = T2.BIN;

/*
Prediction Result:
('15 or more', 2)
('[0-5>', 0)
('[10-15>', 0)
('[5-10>', 0)
*/