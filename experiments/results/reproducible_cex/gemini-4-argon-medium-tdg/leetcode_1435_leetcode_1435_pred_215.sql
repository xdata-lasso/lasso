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
SELECT SUM(CASE WHEN DURATION < 300 THEN 1 ELSE 0 END) AS TOTAL, '[0-5>' AS BIN FROM SESSIONS UNION SELECT SUM(CASE WHEN DURATION >= 300 AND DURATION < 600 THEN 1 ELSE 0 END) AS TOTAL, '[5-10>' AS BIN FROM SESSIONS UNION SELECT SUM(CASE WHEN DURATION >= 600 AND DURATION < 900 THEN 1 ELSE 0 END) AS TOTAL, '[10-15>' AS BIN FROM SESSIONS UNION SELECT SUM(CASE WHEN DURATION >= 900 THEN 1 ELSE 0 END) AS TOTAL, '15 or more' AS BIN FROM SESSIONS;

/*
Prediction Result:
(1, '[0-5>')
(2, '[5-10>')
(3, '[10-15>')
(4, '15 or more')
*/