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

INSERT INTO "sessions" ("session_id", "duration") VALUES (-2147483639, 1);

INSERT INTO "sessions" ("session_id", "duration") VALUES (-2147483638, 1);

INSERT INTO "sessions" ("session_id", "duration") VALUES (-2147483637, 1);

INSERT INTO "sessions" ("session_id", "duration") VALUES (-2147483636, 1);

INSERT INTO "sessions" ("session_id", "duration") VALUES (-2147483635, 1);

INSERT INTO "sessions" ("session_id", "duration") VALUES (-2147483634, 1);
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
SELECT A.BIN, COALESCE(TOTAL, 0) AS TOTAL FROM (SELECT '[0-5>' AS BIN UNION ALL SELECT '[5-10>' AS BIN UNION ALL SELECT '[10-15>' AS BIN UNION ALL SELECT '15 or more' AS BIN) AS A LEFT JOIN (SELECT CASE WHEN (CAST(DURATION AS REAL) / 60) < 5 THEN '[0-5>' WHEN (CAST(DURATION AS REAL) / 60) < 10 THEN '[5-10>' WHEN (CAST(DURATION AS REAL) / 60) < 15 THEN '[10-15>' ELSE '15 or more' END AS BIN, COUNT(1) AS TOTAL FROM SESSIONS GROUP BY CASE WHEN (CAST(DURATION AS REAL) / 60) < 5 THEN '[0-5>' WHEN (CAST(DURATION AS REAL) / 60) < 10 THEN '[5-10>' WHEN (CAST(DURATION AS REAL) / 60) < 15 THEN '[10-15>' ELSE '15 or more' END) AS B ON A.BIN = B.BIN;

/*
Prediction Result:
('[0-5>', 12)
('[5-10>', 0)
('[10-15>', 0)
('15 or more', 3)
*/