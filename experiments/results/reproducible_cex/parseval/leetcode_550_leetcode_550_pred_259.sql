-- Schema DDL
CREATE TABLE "Activity" ("player_id" INTEGER, "event_date" DATE, "device_id" INTEGER, "games_played" INTEGER, PRIMARY KEY ("player_id", "event_date"), CHECK ("games_played" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: activity --
INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (-2147483648, '2024-06-15', -1726781632, 247012447);

INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (1, '2024-06-15', -252690330, 1115440883);

INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (-2147483646, '2024-06-15', 1644814318, 1465859724);

INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (2, '2024-06-15', -1349201381, 1019800248);

INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (3, '2024-06-15', -1610064545, 429706943);

INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (-2147483643, '2024-06-15', -45536098, 1861536320);

INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (1, '1969-12-31', 44952191, 1151980946);

INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (1, '1970-01-01', 1620389964, 546571701);

INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (-2147483642, '2024-06-15', 947159877, 1990080517);

INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (-2147483641, '2024-06-15', 1155439218, 1313172851);

INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (-2147483640, '2024-06-15', -761141909, 283598170);

INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (-2147483639, '2024-06-15', 775304493, 373262291);

INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (-2147483638, '2024-06-15', -2070843029, 328305758);

INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (-2147483637, '2024-06-15', 2074205376, 274769912);

INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (-2147483636, '2024-06-15', -188151580, 226938182);

INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (-2147483635, '2024-06-15', -453362185, 481163439);

INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (-2147483634, '2024-06-15', 2123196517, 364869063);

INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (-2147483633, '2024-06-15', -227162283, 2056419640);

INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (-2147483632, '2024-06-15', 222415430, 556727997);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ROUND((CAST(SUM(CASE WHEN (temp.min_date + 1) = a.event_date THEN 1 ELSE 0 END) AS REAL) / COUNT(DISTINCT temp.player_id)), 2) AS fraction FROM (SELECT player_id, MIN(event_date) AS min_date FROM activity GROUP BY player_id) AS temp JOIN activity AS a ON temp.player_id = a.player_id;

/*
Gold Result:
(0.0,)
*/

-- Prediction Query
WITH NEXT_DAY_LOG AS (SELECT PLAYER_ID, LEAD(EVENT_DATE) OVER (PARTITION BY PLAYER_ID ORDER BY EVENT_DATE) - EVENT_DATE AS DATE_DIFF, RANK() OVER (PARTITION BY PLAYER_ID ORDER BY EVENT_DATE ASC) AS RNK, EVENT_DATE FROM ACTIVITY) SELECT ROUND(CAST(COUNT(DISTINCT NEDL.PLAYER_ID) AS REAL) / COUNT(DISTINCT ACT.PLAYER_ID), 2) AS FRACTION FROM ACTIVITY AS ACT LEFT OUTER JOIN NEXT_DAY_LOG AS NEDL ON ACT.PLAYER_ID = NEDL.PLAYER_ID AND ACT.EVENT_DATE = NEDL.EVENT_DATE AND RNK = 1 AND DATE_DIFF = 1;

/*
Prediction Result:
(0.06,)
*/