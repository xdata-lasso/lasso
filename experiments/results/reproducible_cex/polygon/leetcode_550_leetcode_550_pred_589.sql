-- Schema DDL
CREATE TABLE "Activity" ("player_id" INTEGER, "event_date" DATE, "device_id" INTEGER, "games_played" INTEGER, PRIMARY KEY ("player_id", "event_date"), CHECK ("games_played" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Activity" ("player_id", "event_date", "device_id", "games_played") VALUES (11, '0999-12-08', NULL, NULL);
INSERT INTO "Activity" ("player_id", "event_date", "device_id", "games_played") VALUES (11, '0999-12-09', NULL, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ROUND((CAST(SUM(CASE WHEN (temp.min_date + 1) = a.event_date THEN 1 ELSE 0 END) AS REAL) / COUNT(DISTINCT temp.player_id)), 2) AS fraction FROM (SELECT player_id, MIN(event_date) AS min_date FROM activity GROUP BY player_id) AS temp JOIN activity AS a ON temp.player_id = a.player_id;

/*
Gold Result:
(0.0,)
*/

-- Prediction Query
WITH FIRST_LOGIN AS (SELECT PLAYER_ID, MIN(EVENT_DATE) AS F_LOGIN FROM ACTIVITY GROUP BY PLAYER_ID) SELECT ROUND(CAST(COUNT(*) AS REAL) / (SELECT COUNT(DISTINCT PLAYER_ID) FROM ACTIVITY), 2) AS FRACTION FROM ACTIVITY AS AC INNER JOIN FIRST_LOGIN AS FL ON TRUE WHERE AC.PLAYER_ID = FL.PLAYER_ID AND AC.EVENT_DATE - '1 DAY' = FL.F_LOGIN;

/*
Prediction Result:
(0.0,)
*/