-- Schema DDL
CREATE TABLE "Sessions" ("session_id" INTEGER PRIMARY KEY, "duration" INTEGER, CHECK ("duration" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: sessions --
INSERT INTO "sessions" ("session_id", "duration") VALUES (-2147483648, 1);

INSERT INTO "sessions" ("session_id", "duration") VALUES (-2147483647, 1);

INSERT INTO "sessions" ("session_id", "duration") VALUES (-2147483646, 1);

INSERT INTO "sessions" ("session_id", "duration") VALUES (-2147483645, 1);

INSERT INTO "sessions" ("session_id", "duration") VALUES (-2147483644, 1);

INSERT INTO "sessions" ("session_id", "duration") VALUES (-2147483643, 1);

INSERT INTO "sessions" ("session_id", "duration") VALUES (-2147483642, NULL);

INSERT INTO "sessions" ("session_id", "duration") VALUES (-2147483641, NULL);

INSERT INTO "sessions" ("session_id", "duration") VALUES (-2147483640, NULL);

INSERT INTO "sessions" ("session_id", "duration") VALUES (-2147483639, NULL);

INSERT INTO "sessions" ("session_id", "duration") VALUES (-2147483638, NULL);

INSERT INTO "sessions" ("session_id", "duration") VALUES (-2147483637, 1);

INSERT INTO "sessions" ("session_id", "duration") VALUES (-2147483636, 1);

INSERT INTO "sessions" ("session_id", "duration") VALUES (-2147483635, 1);

INSERT INTO "sessions" ("session_id", "duration") VALUES (-2147483634, 1);

INSERT INTO "sessions" ("session_id", "duration") VALUES (-2147483633, 1);

INSERT INTO "sessions" ("session_id", "duration") VALUES (-2147483632, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT '[0-5>' AS bin, COUNT(session_id) AS total FROM sessions WHERE ((CAST(duration AS REAL) / 60) >= 0 AND (CAST(duration AS REAL) / 60) < 5) UNION SELECT '[5-10>' AS bin, COUNT(session_id) AS total FROM sessions WHERE ((CAST(duration AS REAL) / 60) >= 5 AND (CAST(duration AS REAL) / 60) < 10) UNION SELECT '[10-15>' AS bin, COUNT(session_id) AS total FROM sessions WHERE ((CAST(duration AS REAL) / 60) >= 10 AND (CAST(duration AS REAL) / 60) < 15) UNION SELECT '15 or more' AS bin, COUNT(session_id) AS total FROM sessions WHERE (CAST(duration AS REAL) / 60) >= 15;

/*
Gold Result:
('15 or more', 0)
('[0-5>', 12)
('[10-15>', 0)
('[5-10>', 0)
*/

-- Prediction Query
WITH T1 AS (SELECT '[0-5>' AS BIN UNION ALL SELECT '[5-10>' AS BIN UNION ALL SELECT '[10-15>' AS BIN UNION ALL SELECT '15 or more' AS BIN), T2 AS (SELECT CASE WHEN (CAST(DURATION AS REAL) / 60) >= 0 AND (CAST(DURATION AS REAL) / 60) < 5 THEN '[0-5>' WHEN (CAST(DURATION AS REAL) / 60) >= 5 AND (CAST(DURATION AS REAL) / 60) < 10 THEN '[5-10>' WHEN (CAST(DURATION AS REAL) / 60) >= 10 AND (CAST(DURATION AS REAL) / 60) < 15 THEN '[10-15>' ELSE '15 or more' END AS BIN, COALESCE(COUNT(DISTINCT SESSION_ID), 0) AS TOTAL FROM SESSIONS GROUP BY BIN) SELECT T1.BIN, COALESCE(T2.TOTAL, 0) AS TOTAL FROM T1 LEFT JOIN T2 ON T1.BIN = T2.BIN;

/*
Prediction Result:
('[0-5>', 12)
('[5-10>', 0)
('[10-15>', 0)
('15 or more', 5)
*/