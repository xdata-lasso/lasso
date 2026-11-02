-- Schema DDL
CREATE TABLE "Sessions" ("session_id" INTEGER PRIMARY KEY, "duration" INTEGER, CHECK ("duration" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 3
-- Duplicate durations and NULL handling (tests COUNT(session_id) vs COUNT(DISTINCT duration) vs COUNT(duration) with NULLs)
INSERT INTO "Sessions" ("session_id", "duration") VALUES (1, 150);
INSERT INTO "Sessions" ("session_id", "duration") VALUES (2, 150);
INSERT INTO "Sessions" ("session_id", "duration") VALUES (3, 450);
INSERT INTO "Sessions" ("session_id", "duration") VALUES (4, 450);
INSERT INTO "Sessions" ("session_id", "duration") VALUES (5, 750);
INSERT INTO "Sessions" ("session_id", "duration") VALUES (6, 750);
INSERT INTO "Sessions" ("session_id", "duration") VALUES (7, 1200);
INSERT INTO "Sessions" ("session_id", "duration") VALUES (8, 1200);
INSERT INTO "Sessions" ("session_id", "duration") VALUES (9, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT '[0-5>' AS bin, COUNT(session_id) AS total FROM sessions WHERE ((CAST(duration AS REAL) / 60) >= 0 AND (CAST(duration AS REAL) / 60) < 5) UNION SELECT '[5-10>' AS bin, COUNT(session_id) AS total FROM sessions WHERE ((CAST(duration AS REAL) / 60) >= 5 AND (CAST(duration AS REAL) / 60) < 10) UNION SELECT '[10-15>' AS bin, COUNT(session_id) AS total FROM sessions WHERE ((CAST(duration AS REAL) / 60) >= 10 AND (CAST(duration AS REAL) / 60) < 15) UNION SELECT '15 or more' AS bin, COUNT(session_id) AS total FROM sessions WHERE (CAST(duration AS REAL) / 60) >= 15;

/*
Gold Result:
('15 or more', 2)
('[0-5>', 2)
('[10-15>', 2)
('[5-10>', 2)
*/

-- Prediction Query
SELECT BIN, SUM(TOTAL) AS TOTAL FROM (SELECT '[10-15>' AS BIN, 0 AS TOTAL UNION SELECT '15 or more' AS BIN, 0 AS TOTAL UNION SELECT '[5-10>' AS BIN, 0 AS TOTAL UNION SELECT '[0-5>' AS BIN, 0 AS TOTAL UNION SELECT BIN, COUNT(*) AS TOTAL FROM (SELECT *, (CASE WHEN CAST(DURATION AS REAL) / 60 >= 15 THEN '15 or more' WHEN CAST(DURATION AS REAL) / 60 < 15 AND CAST(DURATION AS REAL) / 60 >= 10 THEN '[10-15>' WHEN CAST(DURATION AS REAL) / 60 < 10 AND CAST(DURATION AS REAL) / 60 >= 5 THEN '[5-10>' ELSE '[0-5>' END) AS BIN FROM SESSIONS) AS TMP GROUP BY BIN) AS TMP GROUP BY BIN;

/*
Prediction Result:
('15 or more', 2)
('[0-5>', 3)
('[10-15>', 2)
('[5-10>', 2)
*/