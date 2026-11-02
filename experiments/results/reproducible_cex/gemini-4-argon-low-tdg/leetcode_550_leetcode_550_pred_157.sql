-- Schema DDL
CREATE TABLE "Activity" ("player_id" INTEGER, "event_date" DATE, "device_id" INTEGER, "games_played" INTEGER, PRIMARY KEY ("player_id", "event_date"), CHECK ("games_played" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 3
INSERT INTO Activity (player_id, event_date, device_id, games_played) VALUES (1, '2020-01-31', 1, 10);
INSERT INTO Activity (player_id, event_date, device_id, games_played) VALUES (1, '2020-02-01', 2, 20);
INSERT INTO Activity (player_id, event_date, device_id, games_played) VALUES (2, '2020-02-28', 1, 5);
INSERT INTO Activity (player_id, event_date, device_id, games_played) VALUES (2, '2020-02-29', 1, 5);
INSERT INTO Activity (player_id, event_date, device_id, games_played) VALUES (3, '2021-02-28', 3, 1);
INSERT INTO Activity (player_id, event_date, device_id, games_played) VALUES (3, '2021-03-01', 3, 2);
INSERT INTO Activity (player_id, event_date, device_id, games_played) VALUES (4, '2020-12-31', 4, 0);
INSERT INTO Activity (player_id, event_date, device_id, games_played) VALUES (4, '2021-01-01', 4, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ROUND((CAST(SUM(CASE WHEN (temp.min_date + 1) = a.event_date THEN 1 ELSE 0 END) AS REAL) / COUNT(DISTINCT temp.player_id)), 2) AS fraction FROM (SELECT player_id, MIN(event_date) AS min_date FROM activity GROUP BY player_id) AS temp JOIN activity AS a ON temp.player_id = a.player_id;

/*
Gold Result:
(0.0,)
*/

-- Prediction Query
SELECT ROUND(CAST(COUNT(DISTINCT B.PLAYER_ID) AS REAL) / COUNT(DISTINCT A.PLAYER_ID), 2) AS FRACTION FROM ACTIVITY AS A LEFT JOIN ACTIVITY AS B ON A.PLAYER_ID = B.PLAYER_ID AND B.EVENT_DATE - A.EVENT_DATE = 1 AND (A.PLAYER_ID, A.EVENT_DATE) IN (SELECT PLAYER_ID, MIN(EVENT_DATE) FROM ACTIVITY GROUP BY PLAYER_ID);

/*
Prediction Result:
(0.25,)
*/