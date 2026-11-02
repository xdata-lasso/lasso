-- Schema DDL
CREATE TABLE "Sessions" ("session_id" INTEGER PRIMARY KEY, "duration" INTEGER, CHECK ("duration" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: sessions --
INSERT INTO "sessions" ("session_id", "duration") VALUES (1, 247012447);

INSERT INTO "sessions" ("session_id", "duration") VALUES (-2147483647, 1744686505);

INSERT INTO "sessions" ("session_id", "duration") VALUES (2, 1115440883);

INSERT INTO "sessions" ("session_id", "duration") VALUES (-2147483645, 1);

INSERT INTO "sessions" ("session_id", "duration") VALUES (3, 1644814318);

INSERT INTO "sessions" ("session_id", "duration") VALUES (-2147483643, 1);

INSERT INTO "sessions" ("session_id", "duration") VALUES (4, 1465859724);

INSERT INTO "sessions" ("session_id", "duration") VALUES (-2147483641, 1);

INSERT INTO "sessions" ("session_id", "duration") VALUES (5, 1019800248);

INSERT INTO "sessions" ("session_id", "duration") VALUES (-2147483639, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT '[0-5>' AS bin, COUNT(session_id) AS total FROM sessions WHERE ((CAST(duration AS REAL) / 60) >= 0 AND (CAST(duration AS REAL) / 60) < 5) UNION SELECT '[5-10>' AS bin, COUNT(session_id) AS total FROM sessions WHERE ((CAST(duration AS REAL) / 60) >= 5 AND (CAST(duration AS REAL) / 60) < 10) UNION SELECT '[10-15>' AS bin, COUNT(session_id) AS total FROM sessions WHERE ((CAST(duration AS REAL) / 60) >= 10 AND (CAST(duration AS REAL) / 60) < 15) UNION SELECT '15 or more' AS bin, COUNT(session_id) AS total FROM sessions WHERE (CAST(duration AS REAL) / 60) >= 15;

/*
Gold Result:
('15 or more', 6)
('[0-5>', 4)
('[10-15>', 0)
('[5-10>', 0)
*/

-- Prediction Query
WITH CTE AS (SELECT '[0-5>' AS BIN, 0 AS MIN_DURATION, 5 * 60 AS MAX_DURATION UNION ALL SELECT '[5-10>' AS BIN, 5 * 60 AS MIN_DURATION, 10 * 60 AS MAX_DURATION UNION ALL SELECT '[10-15>' AS BIN, 10 * 60 AS MIN_DURATION, 15 * 60 AS MAX_DURATION UNION ALL SELECT '15 or more' AS BIN, 15 * 60 AS MIN_DURATION, 10000000 AS MAX_DURATION) SELECT A.BIN, COALESCE(COUNT(B.SESSION_ID), 0) AS TOTAL FROM CTE AS A LEFT JOIN SESSIONS AS B ON B.DURATION >= A.MIN_DURATION AND B.DURATION < A.MAX_DURATION GROUP BY 1;

/*
Prediction Result:
('15 or more', 0)
('[0-5>', 4)
('[10-15>', 0)
('[5-10>', 0)
*/