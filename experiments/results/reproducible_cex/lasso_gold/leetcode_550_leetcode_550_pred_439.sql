-- Schema DDL
CREATE TABLE "Activity" ("player_id" INTEGER, "event_date" DATE, "device_id" INTEGER, "games_played" INTEGER, PRIMARY KEY ("player_id", "event_date"), CHECK ("games_played" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (1063, 10, 1065, 1067);
INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (1063, 11, 1072.0, 1076.0);
INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (1092, NULL, 1094, 1096);
INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (1092, NULL, 1101.0, 1105.0);
INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (1092, NULL, 1098, 1100);
INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (1092, NULL, 1105.0, 1109.0);
INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (1092, 10, 1103, 1105);
INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (1092, 11, 1110.0, 1114.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ROUND((CAST(SUM(CASE WHEN (temp.min_date + 1) = a.event_date THEN 1 ELSE 0 END) AS REAL) / COUNT(DISTINCT temp.player_id)), 2) AS fraction FROM (SELECT player_id, MIN(event_date) AS min_date FROM activity GROUP BY player_id) AS temp JOIN activity AS a ON temp.player_id = a.player_id;

/*
Gold Result:
(1.0,)
*/

-- Prediction Query
WITH TMP3 AS (SELECT COUNT(DISTINCT PLAYER_ID) AS TOTAL FROM ACTIVITY), TMP4 AS (WITH TMP2 AS (WITH TMP AS (SELECT PLAYER_ID, EVENT_DATE, LEAD(EVENT_DATE, 1, EVENT_DATE) OVER (PARTITION BY PLAYER_ID ORDER BY EVENT_DATE) AS NXT FROM ACTIVITY) SELECT PLAYER_ID, MIN(EVENT_DATE) AS EVENT_DATE, MIN(NXT) AS NXT FROM TMP GROUP BY PLAYER_ID) SELECT COUNT(PLAYER_ID) AS CNT FROM TMP2 WHERE CAST((JULIANDAY(NXT) - JULIANDAY(EVENT_DATE)) AS INTEGER) = 1) SELECT ROUND(CAST(CNT AS REAL) / TOTAL, 2) AS FRACTION FROM TMP4 INNER JOIN TMP3 ON TRUE;

/*
Prediction Result:
(0.5,)
*/