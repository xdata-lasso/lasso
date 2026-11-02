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
SELECT COUNT(CASE WHEN DURATION < 5 * 60 THEN 1 END) AS TOTAL, '[0-5>' AS BIN FROM SESSIONS UNION SELECT COUNT(CASE WHEN (DURATION < 10 * 60 AND DURATION >= 5 * 60) THEN 1 END) AS TOTAL, '[5-10>' AS BIN FROM SESSIONS UNION SELECT COUNT(CASE WHEN (DURATION < 15 * 60 AND DURATION >= 10 * 60) THEN 1 END) AS TOTAL, '[10-15>' AS BIN FROM SESSIONS UNION SELECT COUNT(CASE WHEN DURATION > 15 * 60 THEN 1 END) AS TOTAL, '15 or more' AS BIN FROM SESSIONS;

/*
Prediction Result:
(1, '[0-5>')
(2, '[5-10>')
(3, '15 or more')
(3, '[10-15>')
*/