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
WITH FIRSTLOGIN AS (SELECT PLAYER_ID, MIN(EVENT_DATE) AS FIRST_LOGIN FROM ACTIVITY GROUP BY PLAYER_ID), NEXTLOGIN AS (SELECT PLAYER_ID, EVENT_DATE, LEAD(EVENT_DATE, 1) OVER (PARTITION BY PLAYER_ID ORDER BY EVENT_DATE ASC) AS NEXT_LOGIN FROM ACTIVITY), RETENTION AS (SELECT NL.PLAYER_ID, IIF(CAST((JULIANDAY(NL.NEXT_LOGIN) - JULIANDAY(NL.EVENT_DATE)) AS INTEGER) = 1, 1, 0) AS DAY1RETENTION FROM NEXTLOGIN AS NL INNER JOIN FIRSTLOGIN AS FL ON FL.PLAYER_ID = NL.PLAYER_ID AND FL.FIRST_LOGIN = NL.EVENT_DATE) SELECT ROUND(CAST(SUM(DAY1RETENTION) AS REAL) / COUNT(PLAYER_ID), 2) AS FRACTION FROM RETENTION;

/*
Prediction Result:
(1.0,)
*/