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
SELECT ROUND(CAST(T.LOG_AGAIN_PLAYER_COUNT AS REAL) / COUNT(DISTINCT A.PLAYER_ID), 2) AS FRACTION FROM ACTIVITY AS A CROSS JOIN (SELECT COUNT(DISTINCT A1.PLAYER_ID) AS LOG_AGAIN_PLAYER_COUNT FROM (SELECT DISTINCT A2.PLAYER_ID, NTH_VALUE(A2.EVENT_DATE, 1) OVER (PARTITION BY A2.PLAYER_ID ORDER BY A2.EVENT_DATE) AS FIRST_LOGIN_DATE, NTH_VALUE(A2.EVENT_DATE, 2) OVER (PARTITION BY A2.PLAYER_ID ORDER BY A2.EVENT_DATE RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS SECOND_LOGIN_DATE FROM ACTIVITY AS A2) AS A1 WHERE CAST((JULIANDAY(A1.SECOND_LOGIN_DATE) - JULIANDAY(A1.FIRST_LOGIN_DATE)) AS INTEGER) = 1) AS T;

/*
Prediction Result:
(0.5,)
*/