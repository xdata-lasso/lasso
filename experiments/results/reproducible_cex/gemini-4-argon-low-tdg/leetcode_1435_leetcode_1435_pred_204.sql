-- Schema DDL
CREATE TABLE "Sessions" ("session_id" INTEGER PRIMARY KEY, "duration" INTEGER, CHECK ("duration" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Boundary value testing around 0, 5, 10, and 15 minutes (in seconds: 300, 600, 900)
INSERT INTO "Sessions" ("session_id", "duration") VALUES (1, 1);
INSERT INTO "Sessions" ("session_id", "duration") VALUES (2, 299);
INSERT INTO "Sessions" ("session_id", "duration") VALUES (3, 300);
INSERT INTO "Sessions" ("session_id", "duration") VALUES (4, 301);
INSERT INTO "Sessions" ("session_id", "duration") VALUES (5, 599);
INSERT INTO "Sessions" ("session_id", "duration") VALUES (6, 600);
INSERT INTO "Sessions" ("session_id", "duration") VALUES (7, 601);
INSERT INTO "Sessions" ("session_id", "duration") VALUES (8, 899);
INSERT INTO "Sessions" ("session_id", "duration") VALUES (9, 900);
INSERT INTO "Sessions" ("session_id", "duration") VALUES (10, 901);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT '[0-5>' AS bin, COUNT(session_id) AS total FROM sessions WHERE ((CAST(duration AS REAL) / 60) >= 0 AND (CAST(duration AS REAL) / 60) < 5) UNION SELECT '[5-10>' AS bin, COUNT(session_id) AS total FROM sessions WHERE ((CAST(duration AS REAL) / 60) >= 5 AND (CAST(duration AS REAL) / 60) < 10) UNION SELECT '[10-15>' AS bin, COUNT(session_id) AS total FROM sessions WHERE ((CAST(duration AS REAL) / 60) >= 10 AND (CAST(duration AS REAL) / 60) < 15) UNION SELECT '15 or more' AS bin, COUNT(session_id) AS total FROM sessions WHERE (CAST(duration AS REAL) / 60) >= 15;

/*
Gold Result:
('15 or more', 2)
('[0-5>', 2)
('[10-15>', 3)
('[5-10>', 3)
*/

-- Prediction Query
WITH CTE AS (SELECT '[0-5>' AS BIN UNION SELECT '[5-10>' AS BIN UNION SELECT '[10-15>' AS BIN UNION SELECT '15 or more' AS BIN), CTE2 AS (SELECT CASE WHEN CAST(DURATION AS REAL) / 60 BETWEEN 0 AND 5 THEN '[0-5>' WHEN CAST(DURATION AS REAL) / 60 BETWEEN 5 AND 10 THEN '[5-10>' WHEN CAST(DURATION AS REAL) / 60 BETWEEN 10 AND 15 THEN '[10-15>' WHEN CAST(DURATION AS REAL) / 60 > 15 THEN '15 or more' END AS BIN, COUNT(CASE WHEN CAST(DURATION AS REAL) / 60 BETWEEN 0 AND 5 THEN 1 WHEN CAST(DURATION AS REAL) / 60 BETWEEN 5 AND 10 THEN 1 WHEN CAST(DURATION AS REAL) / 60 BETWEEN 10 AND 15 THEN 1 WHEN CAST(DURATION AS REAL) / 60 > 15 THEN 1 END) AS CNT FROM SESSIONS GROUP BY BIN) SELECT C.BIN, COALESCE(S.CNT, 0) AS TOTAL FROM CTE AS C LEFT JOIN CTE2 AS S ON C.BIN = S.BIN;

/*
Prediction Result:
('15 or more', 1)
('[0-5>', 3)
('[10-15>', 3)
('[5-10>', 3)
*/