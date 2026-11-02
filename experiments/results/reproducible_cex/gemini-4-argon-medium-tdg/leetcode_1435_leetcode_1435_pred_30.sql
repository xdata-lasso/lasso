-- Schema DDL
CREATE TABLE "Sessions" ("session_id" INTEGER PRIMARY KEY, "duration" INTEGER, CHECK ("duration" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
-- Tests empty bins (producing 0 counts) and NULL durations.
-- Kills mutants that use GROUP BY without a scaffold table (missing 0-count bins) or COUNT(*) when NULLs are mapped to an ELSE bin.
INSERT INTO "Sessions" ("session_id", "duration") VALUES (1, 1);
INSERT INTO "Sessions" ("session_id", "duration") VALUES (2, 150);
INSERT INTO "Sessions" ("session_id", "duration") VALUES (3, 950);
INSERT INTO "Sessions" ("session_id", "duration") VALUES (4, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT '[0-5>' AS bin, COUNT(session_id) AS total FROM sessions WHERE ((CAST(duration AS REAL) / 60) >= 0 AND (CAST(duration AS REAL) / 60) < 5) UNION SELECT '[5-10>' AS bin, COUNT(session_id) AS total FROM sessions WHERE ((CAST(duration AS REAL) / 60) >= 5 AND (CAST(duration AS REAL) / 60) < 10) UNION SELECT '[10-15>' AS bin, COUNT(session_id) AS total FROM sessions WHERE ((CAST(duration AS REAL) / 60) >= 10 AND (CAST(duration AS REAL) / 60) < 15) UNION SELECT '15 or more' AS bin, COUNT(session_id) AS total FROM sessions WHERE (CAST(duration AS REAL) / 60) >= 15;

/*
Gold Result:
('15 or more', 1)
('[0-5>', 2)
('[10-15>', 0)
('[5-10>', 0)
*/

-- Prediction Query
SELECT BIN, SUM(TOTAL) AS TOTAL FROM (SELECT '[10-15>' AS BIN, 0 AS TOTAL UNION SELECT '15 or more' AS BIN, 0 AS TOTAL UNION SELECT '[5-10>' AS BIN, 0 AS TOTAL UNION SELECT '[0-5>' AS BIN, 0 AS TOTAL UNION SELECT BIN, COUNT(*) AS TOTAL FROM (SELECT *, (CASE WHEN CAST(DURATION AS REAL) / 60 >= 15 THEN '15 or more' WHEN CAST(DURATION AS REAL) / 60 < 15 AND CAST(DURATION AS REAL) / 60 >= 10 THEN '[10-15>' WHEN CAST(DURATION AS REAL) / 60 < 10 AND CAST(DURATION AS REAL) / 60 >= 5 THEN '[5-10>' ELSE '[0-5>' END) AS BIN FROM SESSIONS) AS TMP GROUP BY BIN) AS TMP GROUP BY BIN;

/*
Prediction Result:
('15 or more', 1)
('[0-5>', 3)
('[10-15>', 0)
('[5-10>', 0)
*/