-- Schema DDL
CREATE TABLE "Sessions" ("session_id" INTEGER PRIMARY KEY, "duration" INTEGER, CHECK ("duration" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Sessions" ("session_id", "duration") VALUES (18, 47820);
INSERT INTO "Sessions" ("session_id", "duration") VALUES (17, 840);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT '[0-5>' AS bin, COUNT(session_id) AS total FROM sessions WHERE ((CAST(duration AS REAL) / 60) >= 0 AND (CAST(duration AS REAL) / 60) < 5) UNION SELECT '[5-10>' AS bin, COUNT(session_id) AS total FROM sessions WHERE ((CAST(duration AS REAL) / 60) >= 5 AND (CAST(duration AS REAL) / 60) < 10) UNION SELECT '[10-15>' AS bin, COUNT(session_id) AS total FROM sessions WHERE ((CAST(duration AS REAL) / 60) >= 10 AND (CAST(duration AS REAL) / 60) < 15) UNION SELECT '15 or more' AS bin, COUNT(session_id) AS total FROM sessions WHERE (CAST(duration AS REAL) / 60) >= 15;

/*
Gold Result:
('15 or more', 1)
('[0-5>', 0)
('[10-15>', 1)
('[5-10>', 0)
*/

-- Prediction Query
SELECT (CASE WHEN CAST(DURATION AS REAL) / 60 < 5 THEN '[0-5>' ELSE '[0-5>' END) AS BIN, COALESCE(SUM(CASE WHEN CAST(DURATION AS REAL) / 60 < 5 THEN 1 END), 0) AS TOTAL FROM SESSIONS UNION SELECT (CASE WHEN CAST(DURATION AS REAL) / 60 >= 5 AND CAST(DURATION AS REAL) / 60 < 10 THEN '[5-10>' ELSE '[5-10>' END) AS BIN, COALESCE(SUM(CASE WHEN CAST(DURATION AS REAL) / 60 >= 5 AND CAST(DURATION AS REAL) / 60 < 10 THEN 1 END), 0) AS TOTAL FROM SESSIONS UNION SELECT (CASE WHEN CAST(DURATION AS REAL) / 60 >= 10 AND CAST(DURATION AS REAL) / 60 < 15 THEN '[10-15>' ELSE '[10-15>' END) AS BIN, COALESCE(SUM(CASE WHEN CAST(DURATION AS REAL) / 60 >= 10 AND CAST(DURATION AS REAL) / 60 < 15 THEN 1 END), 0) AS TOTAL FROM SESSIONS UNION SELECT (CASE WHEN CAST(DURATION AS REAL) / 60 >= 15 THEN '15 or more ELSE 15 or more' END) AS BIN, COALESCE(SUM(CASE WHEN CAST(DURATION AS REAL) / 60 >= 15 THEN 1 END), 0) AS TOTAL FROM SESSIONS;

/*
Prediction Result:
(None, 1)
('[0-5>', 0)
('[10-15>', 1)
('[5-10>', 0)
*/