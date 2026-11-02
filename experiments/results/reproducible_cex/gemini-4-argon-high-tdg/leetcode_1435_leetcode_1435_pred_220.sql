-- Schema DDL
CREATE TABLE "Sessions" ("session_id" INTEGER PRIMARY KEY, "duration" INTEGER, CHECK ("duration" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 7
INSERT INTO Sessions (session_id, duration) VALUES (1, 100);
INSERT INTO Sessions (session_id, duration) VALUES (2, NULL);
INSERT INTO Sessions (session_id, duration) VALUES (3, 400);
INSERT INTO Sessions (session_id, duration) VALUES (4, 700);
INSERT INTO Sessions (session_id, duration) VALUES (5, 1000);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT '[0-5>' AS bin, COUNT(session_id) AS total FROM sessions WHERE ((CAST(duration AS REAL) / 60) >= 0 AND (CAST(duration AS REAL) / 60) < 5) UNION SELECT '[5-10>' AS bin, COUNT(session_id) AS total FROM sessions WHERE ((CAST(duration AS REAL) / 60) >= 5 AND (CAST(duration AS REAL) / 60) < 10) UNION SELECT '[10-15>' AS bin, COUNT(session_id) AS total FROM sessions WHERE ((CAST(duration AS REAL) / 60) >= 10 AND (CAST(duration AS REAL) / 60) < 15) UNION SELECT '15 or more' AS bin, COUNT(session_id) AS total FROM sessions WHERE (CAST(duration AS REAL) / 60) >= 15;

/*
Gold Result:
('15 or more', 1)
('[0-5>', 1)
('[10-15>', 1)
('[5-10>', 1)
*/

-- Prediction Query
WITH A AS (SELECT '[0-5>' AS BIN UNION ALL SELECT '[5-10>' AS BIN UNION ALL SELECT '[10-15>' AS BIN UNION ALL SELECT '15 or more' AS BIN) SELECT A.BIN, COALESCE(TOTAL, 0) AS TOTAL FROM A LEFT JOIN (SELECT CASE WHEN CAST(DURATION AS REAL) / 60 >= 15 THEN '15 or more' WHEN CAST(DURATION AS REAL) / 60 >= 10 THEN '[10-15>' WHEN CAST(DURATION AS REAL) / 60 >= 5 THEN '[5-10>' ELSE '[0-5>' END AS BIN, COUNT(*) AS TOTAL FROM SESSIONS GROUP BY 1) AS B ON A.BIN = B.BIN;

/*
Prediction Result:
('[0-5>', 2)
('[5-10>', 1)
('[10-15>', 1)
('15 or more', 1)
*/