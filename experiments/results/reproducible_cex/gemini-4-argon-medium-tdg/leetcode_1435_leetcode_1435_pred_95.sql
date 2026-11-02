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
SELECT A.BIN, COALESCE(B.TOTAL, 0) AS TOTAL FROM (SELECT '[0-5>' AS BIN UNION SELECT '[5-10>' AS BIN UNION SELECT '[10-15>' AS BIN UNION SELECT '15 or more' AS BOIN) AS A LEFT JOIN (SELECT CASE WHEN DURATION >= 0 AND DURATION < 5 * 60 THEN '[0-5>' WHEN DURATION >= 5 * 60 AND DURATION < 10 * 60 THEN '[5-10>' WHEN DURATION >= 10 * 60 AND DURATION < 15 * 60 THEN '[10-15>' ELSE '15 or more' END AS BIN, COUNT(SESSION_ID) AS TOTAL FROM SESSIONS GROUP BY BIN) AS B ON A.BIN = B.BIN;

/*
Prediction Result:
('15 or more', 2)
('[0-5>', 2)
('[10-15>', 0)
('[5-10>', 0)
*/