-- Schema DDL
CREATE TABLE "Sessions" ("session_id" INTEGER PRIMARY KEY, "duration" INTEGER, CHECK ("duration" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: sessions --
INSERT INTO "sessions" ("session_id", "duration") VALUES (-2147483648, 900);

INSERT INTO "sessions" ("session_id", "duration") VALUES (-2147483647, 600);

INSERT INTO "sessions" ("session_id", "duration") VALUES (-2147483646, 300);

INSERT INTO "sessions" ("session_id", "duration") VALUES (-2147483645, 1);

INSERT INTO "sessions" ("session_id", "duration") VALUES (-2147483644, 1);

INSERT INTO "sessions" ("session_id", "duration") VALUES (-2147483643, 600);

INSERT INTO "sessions" ("session_id", "duration") VALUES (-2147483642, 300);

INSERT INTO "sessions" ("session_id", "duration") VALUES (-2147483641, 1);

INSERT INTO "sessions" ("session_id", "duration") VALUES (-2147483640, 900);

INSERT INTO "sessions" ("session_id", "duration") VALUES (-2147483639, 1);

INSERT INTO "sessions" ("session_id", "duration") VALUES (-2147483638, 300);

INSERT INTO "sessions" ("session_id", "duration") VALUES (-2147483637, 1);

INSERT INTO "sessions" ("session_id", "duration") VALUES (-2147483636, 900);

INSERT INTO "sessions" ("session_id", "duration") VALUES (-2147483635, 901);

INSERT INTO "sessions" ("session_id", "duration") VALUES (-2147483634, 300);

INSERT INTO "sessions" ("session_id", "duration") VALUES (-2147483633, 1);

INSERT INTO "sessions" ("session_id", "duration") VALUES (-2147483632, 900);

INSERT INTO "sessions" ("session_id", "duration") VALUES (-2147483631, 600);

INSERT INTO "sessions" ("session_id", "duration") VALUES (-2147483630, 1);

INSERT INTO "sessions" ("session_id", "duration") VALUES (-2147483629, 1);

INSERT INTO "sessions" ("session_id", "duration") VALUES (-2147483628, 900);

INSERT INTO "sessions" ("session_id", "duration") VALUES (-2147483627, 600);

INSERT INTO "sessions" ("session_id", "duration") VALUES (-2147483626, 601);

INSERT INTO "sessions" ("session_id", "duration") VALUES (-2147483625, 1);

INSERT INTO "sessions" ("session_id", "duration") VALUES (-2147483624, 900);

INSERT INTO "sessions" ("session_id", "duration") VALUES (-2147483623, 600);

INSERT INTO "sessions" ("session_id", "duration") VALUES (-2147483622, 300);

INSERT INTO "sessions" ("session_id", "duration") VALUES (-2147483621, 300);

INSERT INTO "sessions" ("session_id", "duration") VALUES (-2147483620, 900);

INSERT INTO "sessions" ("session_id", "duration") VALUES (-2147483619, 600);

INSERT INTO "sessions" ("session_id", "duration") VALUES (-2147483618, 300);

INSERT INTO "sessions" ("session_id", "duration") VALUES (-2147483617, 1);
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
SELECT '[0-5>' AS BIN, COUNT(*) AS TOTAL FROM SESSIONS WHERE DURATION < 5 * 60 UNION SELECT '[5-10>' AS BIN, COUNT(*) AS TOTAL FROM SESSIONS WHERE DURATION >= 5 * 60 AND DURATION <= 10 * 60 UNION SELECT '[10-15>' AS BIN, COUNT(*) AS TOTAL FROM SESSIONS WHERE DURATION >= 10 * 60 AND DURATION <= 15 * 60 UNION SELECT '15 or more' AS BIN, COUNT(*) AS TOTAL FROM SESSIONS WHERE DURATION >= 15 * 60;

/*
Prediction Result:
('15 or more', 8)
('[0-5>', 10)
('[10-15>', 14)
('[5-10>', 13)
*/