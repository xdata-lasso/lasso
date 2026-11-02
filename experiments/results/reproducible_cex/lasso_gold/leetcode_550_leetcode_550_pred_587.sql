-- Schema DDL
CREATE TABLE "Activity" ("player_id" INTEGER, "event_date" DATE, "device_id" INTEGER, "games_played" INTEGER, PRIMARY KEY ("player_id", "event_date"), CHECK ("games_played" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (1073, 10, 1075, 1077);
INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (1073, 11, 1082.0, 1086.0);
INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (NULL, 10, 1089, 1091);
INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (NULL, 11, 1096.0, 1100.0);
INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (NULL, 10, 1093, 1095);
INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (NULL, 11, 1100.0, 1104.0);
INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (NULL, 10, 1097, 1099);
INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (NULL, 11, 1104.0, 1108.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ROUND((CAST(SUM(CASE WHEN (temp.min_date + 1) = a.event_date THEN 1 ELSE 0 END) AS REAL) / COUNT(DISTINCT temp.player_id)), 2) AS fraction FROM (SELECT player_id, MIN(event_date) AS min_date FROM activity GROUP BY player_id) AS temp JOIN activity AS a ON temp.player_id = a.player_id;

/*
Gold Result:
(1.0,)
*/

-- Prediction Query
SELECT ROUND(AVG(LOG), 2) AS FRACTION FROM (SELECT T1.PLAYER_ID, T1.FIRST, (CASE WHEN (T1.PLAYER_ID, T1.FIRST + 1) IN (SELECT PLAYER_ID, EVENT_DATE FROM ACTIVITY) THEN 1 ELSE 0 END) AS LOG FROM (SELECT PLAYER_ID, MIN(EVENT_DATE) AS FIRST FROM ACTIVITY GROUP BY PLAYER_ID) AS T1) AS T2;

/*
Prediction Result:
(0.5,)
*/