-- Schema DDL
CREATE TABLE "Sessions" ("session_id" INTEGER PRIMARY KEY, "duration" INTEGER, CHECK ("duration" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO Sessions (session_id, duration) VALUES (1, 300);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT '[0-5>' AS bin, COUNT(session_id) AS total FROM sessions WHERE ((CAST(duration AS REAL) / 60) >= 0 AND (CAST(duration AS REAL) / 60) < 5) UNION SELECT '[5-10>' AS bin, COUNT(session_id) AS total FROM sessions WHERE ((CAST(duration AS REAL) / 60) >= 5 AND (CAST(duration AS REAL) / 60) < 10) UNION SELECT '[10-15>' AS bin, COUNT(session_id) AS total FROM sessions WHERE ((CAST(duration AS REAL) / 60) >= 10 AND (CAST(duration AS REAL) / 60) < 15) UNION SELECT '15 or more' AS bin, COUNT(session_id) AS total FROM sessions WHERE (CAST(duration AS REAL) / 60) >= 15;

/*
Gold Result:
('15 or more', 0)
('[0-5>', 0)
('[10-15>', 0)
('[5-10>', 1)
*/

-- Prediction Query
SELECT L.BIN, COUNT(L.SESSION_ID) AS TOTAL FROM (SELECT S.SESSION_ID, C.BIN FROM (SELECT '[0-5>' AS BIN UNION ALL SELECT '[5-10>' UNION ALL SELECT '[10-15>' UNION ALL SELECT '15 or more') AS C LEFT JOIN (SELECT S1.SESSION_ID, CASE WHEN CAST(S1.DURATION AS REAL) / 60 <= 5 AND CAST(S1.DURATION AS REAL) / 60 > 0 THEN '[0-5>' WHEN CAST(S1.DURATION AS REAL) / 60 <= 10 AND CAST(S1.DURATION AS REAL) / 60 > 5 THEN '[5-10>' WHEN CAST(S1.DURATION AS REAL) / 60 <= 15 AND CAST(S1.DURATION AS REAL) / 60 > 10 THEN '[10-15>' ELSE '15 or more' END AS BIN FROM SESSIONS AS S1) AS S ON S.BIN = C.BIN) AS L GROUP BY L.BIN;

/*
Prediction Result:
('15 or more', 0)
('[0-5>', 1)
('[10-15>', 0)
('[5-10>', 0)
*/