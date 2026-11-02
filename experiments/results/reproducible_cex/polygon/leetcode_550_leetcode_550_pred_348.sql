-- Schema DDL
CREATE TABLE "Activity" ("player_id" INTEGER, "event_date" DATE, "device_id" INTEGER, "games_played" INTEGER, PRIMARY KEY ("player_id", "event_date"), CHECK ("games_played" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Activity" ("player_id", "event_date", "device_id", "games_played") VALUES (13, '0999-12-11', 17, 0);
INSERT INTO "Activity" ("player_id", "event_date", "device_id", "games_played") VALUES (13, '0999-12-10', NULL, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ROUND((CAST(SUM(CASE WHEN (temp.min_date + 1) = a.event_date THEN 1 ELSE 0 END) AS REAL) / COUNT(DISTINCT temp.player_id)), 2) AS fraction FROM (SELECT player_id, MIN(event_date) AS min_date FROM activity GROUP BY player_id) AS temp JOIN activity AS a ON temp.player_id = a.player_id;

/*
Gold Result:
(0.0,)
*/

-- Prediction Query
SELECT ROUND(CAST(C.F1 AS REAL) / D.F2, 2) AS FRACTION FROM (SELECT COUNT(*) AS F1 FROM (SELECT PLAYER_ID, MIN(EVENT_DATE) AS EVENT_DATE FROM ACTIVITY GROUP BY PLAYER_ID) AS A CROSS JOIN ACTIVITY AS B WHERE A.PLAYER_ID = B.PLAYER_ID AND CAST((JULIANDAY(B.EVENT_DATE) - JULIANDAY(A.EVENT_DATE)) AS INTEGER) = 1) AS C CROSS JOIN (SELECT COUNT(DISTINCT PLAYER_ID) AS F2 FROM ACTIVITY) AS D;

/*
Prediction Result:
(1.0,)
*/