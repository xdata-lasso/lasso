-- Schema DDL
CREATE TABLE "Sessions" ("session_id" INTEGER PRIMARY KEY, "duration" INTEGER, CHECK ("duration" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Sessions" ("session_id", "duration") VALUES (0, NULL);
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
SELECT '[0-5>' AS BIN, SUM(DURATION < 300) AS TOTAL FROM SESSIONS UNION ALL SELECT '[5-10>' AS BIN, SUM(DURATION >= 300 AND DURATION < 600) AS TOTAL FROM SESSIONS UNION ALL SELECT '[10-15>' AS BIN, SUM(DURATION >= 600 AND DURATION < 900) AS TOTAL FROM SESSIONS UNION ALL SELECT '15 or more' AS BIN, SUM(DURATION >= 900) AS TOTAL FROM SESSIONS;

/*
Prediction Result:
('[0-5>', None)
('[5-10>', None)
('[10-15>', None)
('15 or more', None)
*/