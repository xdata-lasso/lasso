-- Schema DDL
CREATE TABLE "Sessions" ("session_id" INTEGER PRIMARY KEY, "duration" INTEGER, CHECK ("duration" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: sessions --
INSERT INTO "sessions" ("session_id", "duration") VALUES (-2147483648, 300);

INSERT INTO "sessions" ("session_id", "duration") VALUES (-2147483647, 600);

INSERT INTO "sessions" ("session_id", "duration") VALUES (-2147483646, 901);

INSERT INTO "sessions" ("session_id", "duration") VALUES (-2147483645, 1);

INSERT INTO "sessions" ("session_id", "duration") VALUES (-2147483644, 601);

INSERT INTO "sessions" ("session_id", "duration") VALUES (-2147483643, 600);

INSERT INTO "sessions" ("session_id", "duration") VALUES (-2147483642, 901);

INSERT INTO "sessions" ("session_id", "duration") VALUES (-2147483641, 1);

INSERT INTO "sessions" ("session_id", "duration") VALUES (-2147483640, 300);

INSERT INTO "sessions" ("session_id", "duration") VALUES (-2147483639, 901);

INSERT INTO "sessions" ("session_id", "duration") VALUES (-2147483638, 901);

INSERT INTO "sessions" ("session_id", "duration") VALUES (-2147483637, 1);

INSERT INTO "sessions" ("session_id", "duration") VALUES (-2147483636, 300);

INSERT INTO "sessions" ("session_id", "duration") VALUES (-2147483635, 600);

INSERT INTO "sessions" ("session_id", "duration") VALUES (-2147483634, 1);

INSERT INTO "sessions" ("session_id", "duration") VALUES (-2147483633, 1);

INSERT INTO "sessions" ("session_id", "duration") VALUES (-2147483632, 300);

INSERT INTO "sessions" ("session_id", "duration") VALUES (-2147483631, 600);

INSERT INTO "sessions" ("session_id", "duration") VALUES (-2147483630, 901);

INSERT INTO "sessions" ("session_id", "duration") VALUES (-2147483629, 300);

INSERT INTO "sessions" ("session_id", "duration") VALUES (-2147483628, 300);

INSERT INTO "sessions" ("session_id", "duration") VALUES (-2147483627, 600);

INSERT INTO "sessions" ("session_id", "duration") VALUES (-2147483626, 901);

INSERT INTO "sessions" ("session_id", "duration") VALUES (-2147483625, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT '[0-5>' AS bin, COUNT(session_id) AS total FROM sessions WHERE ((CAST(duration AS REAL) / 60) >= 0 AND (CAST(duration AS REAL) / 60) < 5) UNION SELECT '[5-10>' AS bin, COUNT(session_id) AS total FROM sessions WHERE ((CAST(duration AS REAL) / 60) >= 5 AND (CAST(duration AS REAL) / 60) < 10) UNION SELECT '[10-15>' AS bin, COUNT(session_id) AS total FROM sessions WHERE ((CAST(duration AS REAL) / 60) >= 10 AND (CAST(duration AS REAL) / 60) < 15) UNION SELECT '15 or more' AS bin, COUNT(session_id) AS total FROM sessions WHERE (CAST(duration AS REAL) / 60) >= 15;

/*
Gold Result:
('15 or more', 6)
('[0-5>', 6)
('[10-15>', 6)
('[5-10>', 6)
*/

-- Prediction Query
SELECT '[0-5>' AS BIN, COUNT(*) AS TOTAL FROM SESSIONS WHERE DURATION < 300 UNION ALL SELECT '[5-10>' AS BIN, COUNT(*) AS TOTAL FROM SESSIONS WHERE DURATION BETWEEN 300 AND 600 UNION ALL SELECT '[10-15>' AS BIN, COUNT(*) AS TOTAL FROM SESSIONS WHERE DURATION BETWEEN 600 AND 900 UNION ALL SELECT '15 or more' AS BIN, COUNT(*) AS TOTAL FROM SESSIONS WHERE DURATION > 900;

/*
Prediction Result:
('[0-5>', 6)
('[5-10>', 11)
('[10-15>', 6)
('15 or more', 6)
*/