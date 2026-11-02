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
SELECT ROUND(CAST(COUNT(DISTINCT PLAYER_ID) AS REAL) / (SELECT COUNT(DISTINCT PLAYER_ID) FROM ACTIVITY), 2) AS FRACTION FROM (SELECT PLAYER_ID, DEVICE_ID, EVENT_DATE, GAMES_PLAYED, LEAD(EVENT_DATE) OVER (PARTITION BY PLAYER_ID ORDER BY EVENT_DATE) AS NEXT_LOGIN_DATE, RANK() OVER (PARTITION BY PLAYER_ID ORDER BY EVENT_DATE) AS RNK FROM ACTIVITY) AS T WHERE NEXT_LOGIN_DATE - EVENT_DATE = 1 AND RNK = 1;

/*
Prediction Result:
(0.25,)
*/