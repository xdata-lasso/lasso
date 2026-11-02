-- Schema DDL
CREATE TABLE "Activity" ("player_id" INTEGER, "event_date" DATE, "device_id" INTEGER, "games_played" INTEGER, PRIMARY KEY ("player_id", "event_date"), CHECK ("games_played" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Activity" ("player_id", "event_date", "device_id", "games_played") VALUES (10, '0998-09-25', 13, 0);
INSERT INTO "Activity" ("player_id", "event_date", "device_id", "games_played") VALUES (26, '0998-01-12', 14, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ROUND((CAST(SUM(CASE WHEN (temp.min_date + 1) = a.event_date THEN 1 ELSE 0 END) AS REAL) / COUNT(DISTINCT temp.player_id)), 2) AS fraction FROM (SELECT player_id, MIN(event_date) AS min_date FROM activity GROUP BY player_id) AS temp JOIN activity AS a ON temp.player_id = a.player_id;

/*
Gold Result:
(0.0,)
*/

-- Prediction Query
SELECT ROUND(CAST(COUNT(A.PLAYER_ID) AS REAL) / COUNT(*), 2) AS FRACTION FROM (SELECT PLAYER_ID, MIN(EVENT_DATE) AS FIRST_DATE FROM ACTIVITY GROUP BY 1) AS F LEFT JOIN ACTIVITY AS A ON F.PLAYER_ID = A.PLAYER_ID AND DATE(A.EVENT_DATE, '-1 DAY') = F.FIRST_DATE AND NOT A.PLAYER_ID IS NULL;

/*
Prediction Result:
(0.0,)
*/