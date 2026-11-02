-- Schema DDL
CREATE TABLE "Sessions" ("session_id" INTEGER PRIMARY KEY, "duration" INTEGER, CHECK ("duration" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Empty table (or we can notice if table is empty, Query 1 returns 0 for counts, Query 2 returns NULL for SUM).
-- Wait, let's check if we need a non-empty table or if no rows is valid. If we must provide INSERT statements, what if one bin has 0 matching rows?
-- In Query 2, SUM(CASE ... ELSE 0 END) over a non-empty table where no rows match the condition will sum 0s, resulting in 0!
-- Only when the table is completely empty will SUM(...) return NULL, while COUNT(...) returns 0.
-- Wait: what if duration is NULL? Primary key is session_id (not null), duration can be NULL!
-- If the only row has duration = NULL:
-- Query 1: WHERE condition is UNKNOWN, so 0 rows selected -> COUNT(session_id) is 0.
-- Query 2: 1 row in SESSIONS, CASE evaluates to 0, SUM(0) is 0.
-- So with 1 row, Query 2 returns 0, same as Query 1.;
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
SELECT '[0-5>' AS BIN, SUM(CASE WHEN CAST(DURATION AS REAL) / 60 >= 0 AND CAST(DURATION AS REAL) / 60 < 5 THEN 1 ELSE 0 END) AS TOTAL FROM SESSIONS UNION SELECT '[5-10>' AS BIN, SUM(CASE WHEN CAST(DURATION AS REAL) / 60 >= 5 AND CAST(DURATION AS REAL) / 60 < 10 THEN 1 ELSE 0 END) AS TOTAL FROM SESSIONS UNION SELECT '[10-15>' AS BIN, SUM(CASE WHEN CAST(DURATION AS REAL) / 60 >= 10 AND CAST(DURATION AS REAL) / 60 < 15 THEN 1 ELSE 0 END) AS TOTAL FROM SESSIONS UNION SELECT '15 or more' AS BIN, SUM(CASE WHEN CAST(DURATION AS REAL) / 60 >= 15 THEN 1 ELSE 0 END) AS TOTAL FROM SESSIONS;

/*
Prediction Result:
('15 or more', None)
('[0-5>', None)
('[10-15>', None)
('[5-10>', None)
*/