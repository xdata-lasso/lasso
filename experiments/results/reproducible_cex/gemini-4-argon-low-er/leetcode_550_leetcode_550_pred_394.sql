-- Schema DDL
CREATE TABLE "Activity" ("player_id" INTEGER, "event_date" DATE, "device_id" INTEGER, "games_played" INTEGER, PRIMARY KEY ("player_id", "event_date"), CHECK ("games_played" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Activity" ("player_id", "event_date", "device_id", "games_played") VALUES (1, 10, 1, 1);
INSERT INTO "Activity" ("player_id", "event_date", "device_id", "games_played") VALUES (1, 11, 1, 1);
INSERT INTO "Activity" ("player_id", "event_date", "device_id", "games_played") VALUES (2, 10, 2, 1);
INSERT INTO "Activity" ("player_id", "event_date", "device_id", "games_played") VALUES (3, 10, 3, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ROUND((CAST(SUM(CASE WHEN (temp.min_date + 1) = a.event_date THEN 1 ELSE 0 END) AS REAL) / COUNT(DISTINCT temp.player_id)), 2) AS fraction FROM (SELECT player_id, MIN(event_date) AS min_date FROM activity GROUP BY player_id) AS temp JOIN activity AS a ON temp.player_id = a.player_id;

/*
Gold Result:
(0.33,)
*/

-- Prediction Query
SELECT CAST((CAST(COUNT(DISTINCT SQ2.PLAYER_ID) AS REAL) / COUNT(DISTINCT SQ1.PLAYER_ID)) AS REAL(4, 2)) AS FRACTION FROM (SELECT PLAYER_ID, MIN(EVENT_DATE) AS FIRST_LOGIN_DATE FROM ACTIVITY GROUP BY PLAYER_ID) AS SQ1 LEFT OUTER JOIN ACTIVITY AS SQ2 ON SQ1.PLAYER_ID = SQ2.PLAYER_ID AND SQ1.FIRST_LOGIN_DATE + 1 = SQ2.EVENT_DATE;

/*
Prediction Result:
(0.3333333333333333,)
*/