-- Schema DDL
CREATE TABLE "Activity" ("player_id" INTEGER, "event_date" DATE, "device_id" INTEGER, "games_played" INTEGER, PRIMARY KEY ("player_id", "event_date"), CHECK ("games_played" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests standard ISO date strings vs SQLite numeric addition, multiple logins, and rounding
INSERT INTO "Activity" ("player_id", "event_date", "device_id", "games_played") VALUES (1, '2023-01-01', 10, 5);
INSERT INTO "Activity" ("player_id", "event_date", "device_id", "games_played") VALUES (1, '2023-01-02', 10, 3);
INSERT INTO "Activity" ("player_id", "event_date", "device_id", "games_played") VALUES (2, '2023-01-01', 20, 1);
INSERT INTO "Activity" ("player_id", "event_date", "device_id", "games_played") VALUES (3, '2023-01-05', 30, 0);
INSERT INTO "Activity" ("player_id", "event_date", "device_id", "games_played") VALUES (3, '2023-01-07', 30, 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ROUND((CAST(SUM(CASE WHEN (temp.min_date + 1) = a.event_date THEN 1 ELSE 0 END) AS REAL) / COUNT(DISTINCT temp.player_id)), 2) AS fraction FROM (SELECT player_id, MIN(event_date) AS min_date FROM activity GROUP BY player_id) AS temp JOIN activity AS a ON temp.player_id = a.player_id;

/*
Gold Result:
(0.0,)
*/

-- Prediction Query
SELECT ROUND(CAST(T.COUNT1 AS REAL) / COUNT(DISTINCT A_FULL.PLAYER_ID), 2) AS FRACTION FROM ACTIVITY AS A_FULL CROSS JOIN (SELECT COUNT(DISTINCT A1.PLAYER_ID) AS COUNT1 FROM ACTIVITY AS A1 INNER JOIN (SELECT PLAYER_ID, MIN(EVENT_DATE) AS FIRST_DATE FROM ACTIVITY GROUP BY PLAYER_ID) AS A2 ON CAST((JULIANDAY(A1.EVENT_DATE) - JULIANDAY(A2.FIRST_DATE)) AS INTEGER) = 1 AND A1.PLAYER_ID = A2.PLAYER_ID WHERE NOT A2.PLAYER_ID IS NULL) AS T;

/*
Prediction Result:
(0.33,)
*/