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
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ROUND((CAST(SUM(CASE WHEN (temp.min_date + 1) = a.event_date THEN 1 ELSE 0 END) AS REAL) / COUNT(DISTINCT temp.player_id)), 2) AS fraction FROM (SELECT player_id, MIN(event_date) AS min_date FROM activity GROUP BY player_id) AS temp JOIN activity AS a ON temp.player_id = a.player_id;

/*
Gold Result:
(0.5,)
*/

-- Prediction Query
WITH RANKED AS (SELECT PLAYER_ID, RANK() OVER W AS DATE_RANK, NTH_VALUE(EVENT_DATE, 1) OVER W AS FIRST_DATE, NTH_VALUE(EVENT_DATE, 2) OVER W AS SECOND_DATE FROM ACTIVITY WINDOW W AS (PARTITION BY PLAYER_ID ORDER BY EVENT_DATE)) SELECT ROUND(CAST(SUM(FIRST_DATE + 1 = SECOND_DATE AND DATE_RANK = 2) AS REAL) / SUM(DATE_RANK = 1), 2) AS FRACTION FROM RANKED;

/*
Prediction Result:
(0.2,)
*/