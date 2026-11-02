-- Schema DDL
CREATE TABLE "Sessions" ("session_id" INTEGER PRIMARY KEY, "duration" INTEGER, CHECK ("duration" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests exact boundary values at 5, 10, and 15 minutes (300, 600, 900 seconds) and immediate neighbors (off-by-one mutations like <= vs < or > vs >=).
-- Also includes distinct counts per bin (1, 2, 3, 4) to detect bin swaps or grouping errors.
INSERT INTO "Sessions" ("session_id", "duration") VALUES (1, 299);
INSERT INTO "Sessions" ("session_id", "duration") VALUES (2, 300);
INSERT INTO "Sessions" ("session_id", "duration") VALUES (3, 599);
INSERT INTO "Sessions" ("session_id", "duration") VALUES (4, 600);
INSERT INTO "Sessions" ("session_id", "duration") VALUES (5, 601);
INSERT INTO "Sessions" ("session_id", "duration") VALUES (6, 899);
INSERT INTO "Sessions" ("session_id", "duration") VALUES (7, 900);
INSERT INTO "Sessions" ("session_id", "duration") VALUES (8, 901);
INSERT INTO "Sessions" ("session_id", "duration") VALUES (9, 1200);
INSERT INTO "Sessions" ("session_id", "duration") VALUES (10, 1500);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT '[0-5>' AS bin, COUNT(session_id) AS total FROM sessions WHERE ((CAST(duration AS REAL) / 60) >= 0 AND (CAST(duration AS REAL) / 60) < 5) UNION SELECT '[5-10>' AS bin, COUNT(session_id) AS total FROM sessions WHERE ((CAST(duration AS REAL) / 60) >= 5 AND (CAST(duration AS REAL) / 60) < 10) UNION SELECT '[10-15>' AS bin, COUNT(session_id) AS total FROM sessions WHERE ((CAST(duration AS REAL) / 60) >= 10 AND (CAST(duration AS REAL) / 60) < 15) UNION SELECT '15 or more' AS bin, COUNT(session_id) AS total FROM sessions WHERE (CAST(duration AS REAL) / 60) >= 15;

/*
Gold Result:
('15 or more', 4)
('[0-5>', 1)
('[10-15>', 3)
('[5-10>', 2)
*/

-- Prediction Query
SELECT '[0-5>' AS BIN, SUM(DURATION < 5 * 60) AS TOTAL FROM SESSIONS UNION SELECT '[5-10>' AS BIN, SUM(DURATION < 10 * 60 AND DURATION >= 5 * 60) AS TOTAL FROM SESSIONS UNION SELECT '[10-15>' AS BIN, SUM(DURATION < 15 * 60 AND DURATION >= 10 * 60) AS TOTAL FROM SESSIONS UNION SELECT '15 or more' AS BIN, SUM(DURATION > 15 * 60) AS TOTAL FROM SESSIONS;

/*
Prediction Result:
('15 or more', 3)
('[0-5>', 1)
('[10-15>', 3)
('[5-10>', 2)
*/