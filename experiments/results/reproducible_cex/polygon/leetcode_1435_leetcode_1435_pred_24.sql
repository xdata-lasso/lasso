-- Schema DDL
CREATE TABLE "Sessions" ("session_id" INTEGER PRIMARY KEY, "duration" INTEGER, CHECK ("duration" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Sessions" ("session_id", "duration") VALUES (21, 540);
INSERT INTO "Sessions" ("session_id", "duration") VALUES (20, 900);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT '[0-5>' AS bin, COUNT(session_id) AS total FROM sessions WHERE ((CAST(duration AS REAL) / 60) >= 0 AND (CAST(duration AS REAL) / 60) < 5) UNION SELECT '[5-10>' AS bin, COUNT(session_id) AS total FROM sessions WHERE ((CAST(duration AS REAL) / 60) >= 5 AND (CAST(duration AS REAL) / 60) < 10) UNION SELECT '[10-15>' AS bin, COUNT(session_id) AS total FROM sessions WHERE ((CAST(duration AS REAL) / 60) >= 10 AND (CAST(duration AS REAL) / 60) < 15) UNION SELECT '15 or more' AS bin, COUNT(session_id) AS total FROM sessions WHERE (CAST(duration AS REAL) / 60) >= 15;

/*
Gold Result:
('15 or more', 1)
('[0-5>', 0)
('[10-15>', 0)
('[5-10>', 1)
*/

-- Prediction Query
SELECT '[0-5>' AS BIN, COUNT(*) AS TOTAL FROM SESSIONS WHERE DURATION < 300 UNION ALL SELECT '[5-10>' AS BIN, COUNT(*) AS TOTAL FROM SESSIONS WHERE DURATION BETWEEN 300 AND 600 UNION ALL SELECT '[10-15>' AS BIN, COUNT(*) AS TOTAL FROM SESSIONS WHERE DURATION BETWEEN 600 AND 900 UNION ALL SELECT '15 or more' AS BIN, COUNT(*) AS TOTAL FROM SESSIONS WHERE DURATION > 900;

/*
Prediction Result:
('[0-5>', 0)
('[5-10>', 1)
('[10-15>', 1)
('15 or more', 0)
*/