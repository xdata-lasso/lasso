-- Schema DDL
CREATE TABLE "Activity" ("player_id" INTEGER, "event_date" DATE, "device_id" INTEGER, "games_played" INTEGER, PRIMARY KEY ("player_id", "event_date"), CHECK ("games_played" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO Activity (player_id, event_date, device_id, games_played) VALUES (1, 100, 1, 5);
INSERT INTO Activity (player_id, event_date, device_id, games_played) VALUES (1, 101, 1, 2);
INSERT INTO Activity (player_id, event_date, device_id, games_played) VALUES (1, 102, 1, 3);
INSERT INTO Activity (player_id, event_date, device_id, games_played) VALUES (2, 200, 2, 0);
INSERT INTO Activity (player_id, event_date, device_id, games_played) VALUES (2, 202, 2, 4);
INSERT INTO Activity (player_id, event_date, device_id, games_played) VALUES (2, 203, 2, 8);
INSERT INTO Activity (player_id, event_date, device_id, games_played) VALUES (3, 300, 3, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ROUND((CAST(SUM(CASE WHEN (temp.min_date + 1) = a.event_date THEN 1 ELSE 0 END) AS REAL) / COUNT(DISTINCT temp.player_id)), 2) AS fraction FROM (SELECT player_id, MIN(event_date) AS min_date FROM activity GROUP BY player_id) AS temp JOIN activity AS a ON temp.player_id = a.player_id;

/*
Gold Result:
(0.33,)
*/

-- Prediction Query
SELECT ROUND(CAST(COUNT(DISTINCT PLAYER_ID) AS REAL) / (SELECT COUNT(DISTINCT PLAYER_ID) FROM ACTIVITY), 2) AS FRACTION FROM ACTIVITY WHERE (PLAYER_ID, EVENT_DATE) IN (SELECT PLAYER_ID, DATE(MIN(EVENT_DATE) + 1) FROM ACTIVITY GROUP BY PLAYER_ID);

/*
Prediction Result:
(0.0,)
*/