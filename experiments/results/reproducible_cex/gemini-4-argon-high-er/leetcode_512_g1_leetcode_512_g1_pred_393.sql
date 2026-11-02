-- Schema DDL
CREATE TABLE "Activity" ("player_id" INTEGER, "event_date" DATE, "device_id" INTEGER, "games_played" INTEGER, PRIMARY KEY ("player_id", "event_date"), CHECK ("games_played" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO Activity (player_id, event_date, device_id, games_played) VALUES (1, '2023-01-01', 2, 5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A1.PLAYER_ID, A1.DEVICE_ID FROM ACTIVITY AS A1 JOIN (SELECT PLAYER_ID, MIN(EVENT_DATE) AS FIRST_LOGIN FROM ACTIVITY GROUP BY PLAYER_ID) AS A2 ON (A1.PLAYER_ID = A2.PLAYER_ID AND A1.EVENT_DATE = A2.FIRST_LOGIN);

/*
Gold Result:
(1, 2)
*/

-- Prediction Query
WITH PLAYERS AS (SELECT *, RANK() OVER (PARTITION BY PLAYER_ID ORDER BY EVENT_DATE ASC) AS A FROM ACTIVITY) SELECT PLAYER_ID, DEVICE_ID FROM PLAYERS WHERE A = '1';

/*
Prediction Result:
*/