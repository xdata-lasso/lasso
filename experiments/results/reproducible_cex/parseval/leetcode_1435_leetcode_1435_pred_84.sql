-- Schema DDL
CREATE TABLE "Sessions" ("session_id" INTEGER PRIMARY KEY, "duration" INTEGER, CHECK ("duration" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: sessions --
INSERT INTO "sessions" ("session_id", "duration") VALUES (-2147483648, 901);

INSERT INTO "sessions" ("session_id", "duration") VALUES (-2147483647, 301);

INSERT INTO "sessions" ("session_id", "duration") VALUES (-2147483646, 1);

INSERT INTO "sessions" ("session_id", "duration") VALUES (-2147483645, 601);

INSERT INTO "sessions" ("session_id", "duration") VALUES (-2147483644, 1);

INSERT INTO "sessions" ("session_id", "duration") VALUES (-2147483643, 301);

INSERT INTO "sessions" ("session_id", "duration") VALUES (-2147483642, 1);

INSERT INTO "sessions" ("session_id", "duration") VALUES (-2147483641, 601);

INSERT INTO "sessions" ("session_id", "duration") VALUES (-2147483640, 901);

INSERT INTO "sessions" ("session_id", "duration") VALUES (-2147483639, 1);

INSERT INTO "sessions" ("session_id", "duration") VALUES (-2147483638, 1);

INSERT INTO "sessions" ("session_id", "duration") VALUES (-2147483637, 601);

INSERT INTO "sessions" ("session_id", "duration") VALUES (-2147483636, 901);

INSERT INTO "sessions" ("session_id", "duration") VALUES (-2147483635, 600);

INSERT INTO "sessions" ("session_id", "duration") VALUES (-2147483634, 1);

INSERT INTO "sessions" ("session_id", "duration") VALUES (-2147483633, 601);

INSERT INTO "sessions" ("session_id", "duration") VALUES (-2147483632, 901);

INSERT INTO "sessions" ("session_id", "duration") VALUES (-2147483631, 301);

INSERT INTO "sessions" ("session_id", "duration") VALUES (-2147483630, 300);

INSERT INTO "sessions" ("session_id", "duration") VALUES (-2147483629, 601);

INSERT INTO "sessions" ("session_id", "duration") VALUES (-2147483628, 901);

INSERT INTO "sessions" ("session_id", "duration") VALUES (-2147483627, 301);

INSERT INTO "sessions" ("session_id", "duration") VALUES (-2147483626, 1);

INSERT INTO "sessions" ("session_id", "duration") VALUES (-2147483625, 1);

INSERT INTO "sessions" ("session_id", "duration") VALUES (-2147483624, 901);

INSERT INTO "sessions" ("session_id", "duration") VALUES (-2147483623, 301);

INSERT INTO "sessions" ("session_id", "duration") VALUES (-2147483622, 1);

INSERT INTO "sessions" ("session_id", "duration") VALUES (-2147483621, 900);

INSERT INTO "sessions" ("session_id", "duration") VALUES (-2147483620, 901);

INSERT INTO "sessions" ("session_id", "duration") VALUES (-2147483619, 301);

INSERT INTO "sessions" ("session_id", "duration") VALUES (-2147483618, 1);

INSERT INTO "sessions" ("session_id", "duration") VALUES (-2147483617, 601);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT '[0-5>' AS bin, COUNT(session_id) AS total FROM sessions WHERE ((CAST(duration AS REAL) / 60) >= 0 AND (CAST(duration AS REAL) / 60) < 5) UNION SELECT '[5-10>' AS bin, COUNT(session_id) AS total FROM sessions WHERE ((CAST(duration AS REAL) / 60) >= 5 AND (CAST(duration AS REAL) / 60) < 10) UNION SELECT '[10-15>' AS bin, COUNT(session_id) AS total FROM sessions WHERE ((CAST(duration AS REAL) / 60) >= 10 AND (CAST(duration AS REAL) / 60) < 15) UNION SELECT '15 or more' AS bin, COUNT(session_id) AS total FROM sessions WHERE (CAST(duration AS REAL) / 60) >= 15;

/*
Gold Result:
('15 or more', 8)
('[0-5>', 10)
('[10-15>', 7)
('[5-10>', 7)
*/

-- Prediction Query
SELECT '[0-5>' AS BIN, COUNT(*) AS TOTAL FROM SESSIONS WHERE DURATION < 300 UNION SELECT '[5-10>' AS BIN, COUNT(*) AS TOTAL FROM SESSIONS WHERE DURATION > 300 AND DURATION < 600 UNION SELECT '[10-15>' AS BIN, COUNT(*) AS TOTAL FROM SESSIONS WHERE DURATION > 600 AND DURATION < 900 UNION SELECT '15 or more' AS BIN, COUNT(*) AS TOTAL FROM SESSIONS WHERE DURATION > 900;

/*
Prediction Result:
('15 or more', 7)
('[0-5>', 10)
('[10-15>', 6)
('[5-10>', 6)
*/