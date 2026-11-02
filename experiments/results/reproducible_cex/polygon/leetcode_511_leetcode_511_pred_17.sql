-- Schema DDL
CREATE TABLE "Activity" ("player_id" INTEGER, "event_date" DATE, "device_id" INTEGER, "games_played" INTEGER, PRIMARY KEY ("player_id", "event_date"), CHECK ("games_played" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Activity" ("player_id", "event_date", "device_id", "games_played") VALUES (6, '0998-01-12', 6, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT player_id, MIN(event_date) AS first_login FROM activity GROUP BY player_id;

/*
Gold Result:
(6, '0998-01-12')
*/

-- Prediction Query
SELECT A.PLAYER_ID, A.FIRST_LOGIN FROM (SELECT T.PLAYER_ID, T.EVENT_DATE AS FIRST_LOGIN, RANK() OVER (PARTITION BY PLAYER_ID ORDER BY EVENT_DATE ASC) AS PLAYRNK FROM ACTIVITY AS T) AS A WHERE A.PLAYRNK = 1;

/*
Prediction Result:
(6, '0998-01-12')
*/