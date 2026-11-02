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
SELECT A.BIN, COALESCE(B.TOTAL, 0) AS TOTAL FROM (SELECT '[0-5>' AS BIN UNION SELECT '[5-10>' UNION SELECT '[10-15>' UNION SELECT '15 or more') AS A LEFT JOIN (SELECT CASE WHEN DURATION < 5 * 60 THEN '[0-5>' WHEN DURATION >= 5 * 60 AND DURATION < 10 * 60 THEN '[5-10>' WHEN DURATION >= 10 * 60 AND DURATION < 15 * 60 THEN '[10-15>' ELSE '15 or more' END AS BIN, COUNT(*) AS TOTAL FROM SESSIONS GROUP BY 1) AS B ON A.BIN = B.BIN;

/*
Prediction Result:
('15 or more', 3)
('[0-5>', 12)
('[10-15>', 0)
('[5-10>', 0)
*/