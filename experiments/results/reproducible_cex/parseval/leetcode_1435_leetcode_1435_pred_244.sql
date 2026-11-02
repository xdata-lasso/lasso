-- Schema DDL
CREATE TABLE "Sessions" ("session_id" INTEGER PRIMARY KEY, "duration" INTEGER, CHECK ("duration" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: sessions --
INSERT INTO "sessions" ("session_id", "duration") VALUES (-2147483648, 600);

INSERT INTO "sessions" ("session_id", "duration") VALUES (-2147483647, 1);

INSERT INTO "sessions" ("session_id", "duration") VALUES (-2147483646, 300);

INSERT INTO "sessions" ("session_id", "duration") VALUES (-2147483645, 900);

INSERT INTO "sessions" ("session_id", "duration") VALUES (-2147483644, 600);

INSERT INTO "sessions" ("session_id", "duration") VALUES (-2147483643, 601);

INSERT INTO "sessions" ("session_id", "duration") VALUES (-2147483642, NULL);

INSERT INTO "sessions" ("session_id", "duration") VALUES (-2147483641, NULL);

INSERT INTO "sessions" ("session_id", "duration") VALUES (-2147483640, 300);

INSERT INTO "sessions" ("session_id", "duration") VALUES (-2147483639, 301);

INSERT INTO "sessions" ("session_id", "duration") VALUES (-2147483638, NULL);

INSERT INTO "sessions" ("session_id", "duration") VALUES (-2147483637, NULL);

INSERT INTO "sessions" ("session_id", "duration") VALUES (-2147483636, 600);

INSERT INTO "sessions" ("session_id", "duration") VALUES (-2147483635, 601);

INSERT INTO "sessions" ("session_id", "duration") VALUES (-2147483634, NULL);

INSERT INTO "sessions" ("session_id", "duration") VALUES (-2147483633, NULL);

INSERT INTO "sessions" ("session_id", "duration") VALUES (-2147483632, 300);

INSERT INTO "sessions" ("session_id", "duration") VALUES (-2147483631, 301);

INSERT INTO "sessions" ("session_id", "duration") VALUES (-2147483630, NULL);

INSERT INTO "sessions" ("session_id", "duration") VALUES (-2147483629, NULL);

INSERT INTO "sessions" ("session_id", "duration") VALUES (-2147483628, 600);

INSERT INTO "sessions" ("session_id", "duration") VALUES (-2147483627, 601);

INSERT INTO "sessions" ("session_id", "duration") VALUES (-2147483626, NULL);

INSERT INTO "sessions" ("session_id", "duration") VALUES (-2147483625, NULL);

INSERT INTO "sessions" ("session_id", "duration") VALUES (-2147483624, 300);

INSERT INTO "sessions" ("session_id", "duration") VALUES (-2147483623, 301);

INSERT INTO "sessions" ("session_id", "duration") VALUES (-2147483622, NULL);

INSERT INTO "sessions" ("session_id", "duration") VALUES (-2147483621, NULL);

INSERT INTO "sessions" ("session_id", "duration") VALUES (-2147483620, 600);

INSERT INTO "sessions" ("session_id", "duration") VALUES (-2147483619, 601);

INSERT INTO "sessions" ("session_id", "duration") VALUES (-2147483618, NULL);

INSERT INTO "sessions" ("session_id", "duration") VALUES (-2147483617, NULL);

INSERT INTO "sessions" ("session_id", "duration") VALUES (-2147483616, 300);

INSERT INTO "sessions" ("session_id", "duration") VALUES (-2147483615, 301);

INSERT INTO "sessions" ("session_id", "duration") VALUES (-2147483614, NULL);

INSERT INTO "sessions" ("session_id", "duration") VALUES (-2147483613, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT '[0-5>' AS bin, COUNT(session_id) AS total FROM sessions WHERE ((CAST(duration AS REAL) / 60) >= 0 AND (CAST(duration AS REAL) / 60) < 5) UNION SELECT '[5-10>' AS bin, COUNT(session_id) AS total FROM sessions WHERE ((CAST(duration AS REAL) / 60) >= 5 AND (CAST(duration AS REAL) / 60) < 10) UNION SELECT '[10-15>' AS bin, COUNT(session_id) AS total FROM sessions WHERE ((CAST(duration AS REAL) / 60) >= 10 AND (CAST(duration AS REAL) / 60) < 15) UNION SELECT '15 or more' AS bin, COUNT(session_id) AS total FROM sessions WHERE (CAST(duration AS REAL) / 60) >= 15;

/*
Gold Result:
('15 or more', 1)
('[0-5>', 1)
('[10-15>', 9)
('[5-10>', 9)
*/

-- Prediction Query
SELECT '[0-5>' AS BIN, COUNT(DURATION) AS TOTAL FROM SESSIONS WHERE DURATION < 300 UNION SELECT '[5-10>' AS BIN, COUNT(DURATION) AS TOTAL FROM SESSIONS WHERE DURATION BETWEEN 300 AND 600 UNION SELECT '[10-15>' AS BIN, COUNT(DURATION) AS TOTAL FROM SESSIONS WHERE DURATION BETWEEN 600 AND 900 UNION SELECT '15 or more' AS BIN, COUNT(DURATION) AS TOTAL FROM SESSIONS WHERE DURATION >= 900;

/*
Prediction Result:
('15 or more', 1)
('[0-5>', 1)
('[10-15>', 10)
('[5-10>', 14)
*/