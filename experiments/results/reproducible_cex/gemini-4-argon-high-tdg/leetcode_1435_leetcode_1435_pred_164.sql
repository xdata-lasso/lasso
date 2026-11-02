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
WITH T1 AS (SELECT '[0-5>' AS BIN, 1 AS NUM UNION SELECT '[5-10>' AS BIN, 2 AS NUM UNION SELECT '[10-15>' AS BIN, 3 AS NUM UNION SELECT '15 or more AS BIN', 4 AS NUM), T2 AS (SELECT SESSION_ID, CASE WHEN CAST(DURATION AS REAL) / 60 < 5 THEN 1 WHEN CAST(DURATION AS REAL) / 60 < 10 THEN 2 WHEN CAST(DURATION AS REAL) / 60 < 15 THEN 3 ELSE 4 END AS NUM FROM SESSIONS) SELECT T1.BIN, COUNT(T2.NUM) AS TOTAL FROM T1 LEFT JOIN T2 ON T1.NUM = T2.NUM GROUP BY T1.BIN;

/*
Prediction Result:
('15 or more AS BIN', 4)
('[0-5>', 1)
('[10-15>', 3)
('[5-10>', 2)
*/