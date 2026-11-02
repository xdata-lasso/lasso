-- Schema DDL
CREATE TABLE "Sessions" ("session_id" INTEGER PRIMARY KEY, "duration" INTEGER, CHECK ("duration" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
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
WITH BT AS (SELECT SESSION_ID, CASE WHEN CAST(DURATION AS REAL) / 60 BETWEEN 0 AND 5 THEN '[0-5>' WHEN CAST(DURATION AS REAL) / 60 BETWEEN 5 AND 10 THEN '[5-10>' WHEN CAST(DURATION AS REAL) / 60 BETWEEN 10 AND 15 THEN '[10-15>' WHEN CAST(DURATION AS REAL) / 60 > 15 THEN '15 or more' ELSE 0 END AS BIN FROM SESSIONS), BT1 AS (SELECT '[0-5>' AS BIN UNION SELECT '[5-10>' AS BIN UNION SELECT '[10-15>' AS BIN UNION SELECT '15 or more AS BIN') SELECT BT1.BIN, COUNT(BT.BIN) AS TOTAL FROM BT1 LEFT JOIN BT ON BT1.BIN = BT.BIN GROUP BY BT1.BIN;

/*
Prediction Result:
('15 or more AS BIN', 0)
('[0-5>', 0)
('[10-15>', 0)
('[5-10>', 0)
*/