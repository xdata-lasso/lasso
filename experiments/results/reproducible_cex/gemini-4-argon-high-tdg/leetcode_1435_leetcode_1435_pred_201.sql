-- Schema DDL
CREATE TABLE "Sessions" ("session_id" INTEGER PRIMARY KEY, "duration" INTEGER, CHECK ("duration" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Sessions (session_id, duration) VALUES (10, 299);
INSERT INTO Sessions (session_id, duration) VALUES (20, 300);
INSERT INTO Sessions (session_id, duration) VALUES (30, 599);
INSERT INTO Sessions (session_id, duration) VALUES (40, 600);
INSERT INTO Sessions (session_id, duration) VALUES (50, 750);
INSERT INTO Sessions (session_id, duration) VALUES (60, 899);
INSERT INTO Sessions (session_id, duration) VALUES (70, 900);
INSERT INTO Sessions (session_id, duration) VALUES (80, 901);
INSERT INTO Sessions (session_id, duration) VALUES (90, 1200);
INSERT INTO Sessions (session_id, duration) VALUES (100, 3600);
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
WITH TEMP AS (SELECT SESSION_ID, CASE WHEN DURATION < 300 THEN '[0-5>' WHEN DURATION < 600 THEN '[5-10>' WHEN DURATION < 900 THEN '[10-15> ' ELSE '15 or more' END AS BIN FROM SESSIONS), TA AS (SELECT '[0-5>' AS BIN FROM SESSIONS UNION SELECT '[5-10>' AS BIN FROM SESSIONS UNION SELECT '[10-15>' AS BIN FROM SESSIONS UNION SELECT '15 or more' AS BIN FROM SESSIONS) SELECT TA.BIN AS BIN, COUNT(SESSION_ID) AS TOTAL FROM TA LEFT JOIN TEMP ON TA.BIN = TEMP.BIN GROUP BY TA.BIN;

/*
Prediction Result:
('15 or more', 4)
('[0-5>', 1)
('[10-15>', 0)
('[5-10>', 2)
*/