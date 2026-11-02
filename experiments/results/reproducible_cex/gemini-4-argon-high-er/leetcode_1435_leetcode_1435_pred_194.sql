-- Schema DDL
CREATE TABLE "Sessions" ("session_id" INTEGER PRIMARY KEY, "duration" INTEGER, CHECK ("duration" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO Sessions (session_id, duration) VALUES (1, NULL);
INSERT INTO Sessions (session_id, duration) VALUES (2, 100);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT '[0-5>' AS bin, COUNT(session_id) AS total FROM sessions WHERE ((CAST(duration AS REAL) / 60) >= 0 AND (CAST(duration AS REAL) / 60) < 5) UNION SELECT '[5-10>' AS bin, COUNT(session_id) AS total FROM sessions WHERE ((CAST(duration AS REAL) / 60) >= 5 AND (CAST(duration AS REAL) / 60) < 10) UNION SELECT '[10-15>' AS bin, COUNT(session_id) AS total FROM sessions WHERE ((CAST(duration AS REAL) / 60) >= 10 AND (CAST(duration AS REAL) / 60) < 15) UNION SELECT '15 or more' AS bin, COUNT(session_id) AS total FROM sessions WHERE (CAST(duration AS REAL) / 60) >= 15;

/*
Gold Result:
('15 or more', 0)
('[0-5>', 1)
('[10-15>', 0)
('[5-10>', 0)
*/

-- Prediction Query
WITH ETC AS (SELECT *, CASE WHEN DURATION < 300 THEN '[0-5>' WHEN DURATION < 600 THEN '[5-10>' WHEN DURATION < 900 THEN '[10-15>' ELSE '15 or more' END AS BIN FROM SESSIONS), CTE AS (SELECT ETC.BIN, COUNT(ETC.SESSION_ID) AS TOTAL FROM ETC GROUP BY ETC.BIN UNION ALL SELECT '[0-5>', 0 UNION ALL SELECT '[5-10>', 0 UNION ALL SELECT '[10-15>', 0 UNION ALL SELECT '15 or more', 0 ORDER BY TOTAL DESC, ETC.BIN NULLS LAST) SELECT DISTINCT BIN, TOTAL FROM CTE GROUP BY BIN;

/*
Prediction Result:
('15 or more', 1)
('[0-5>', 1)
('[10-15>', 0)
('[5-10>', 0)
*/