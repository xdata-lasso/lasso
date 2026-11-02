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
WITH CTE AS (SELECT SESSION_ID, CASE WHEN DURATION < 300 THEN '[0-5>' WHEN DURATION >= 300 AND DURATION < 600 THEN '[5-10>' WHEN DURATION >= 600 AND DURATION < 900 THEN '[10-15>' ELSE '15 or more' END AS BIN FROM SESSIONS), CTE2 AS (SELECT '[0-5>' AS BIN UNION SELECT '[5-10>' AS BIN UNION SELECT '[10-15>' AS BIN UNION SELECT '15 or more' AS BIN) SELECT C2.BIN, COALESCE(COUNT(C.SESSION_ID), 0) AS TOTAL FROM CTE2 AS C2 LEFT JOIN CTE AS C USING (BIN) GROUP BY 1;

/*
Prediction Result:
('15 or more', 2)
('[0-5>', 2)
('[10-15>', 0)
('[5-10>', 0)
*/