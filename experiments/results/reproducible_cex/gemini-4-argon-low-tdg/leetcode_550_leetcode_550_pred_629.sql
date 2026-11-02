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
WITH FIRST_LOGINS AS (SELECT ACT.PLAYER_ID, MIN(ACT.EVENT_DATE) AS FIRST_DATE FROM ACTIVITY AS ACT GROUP BY ACT.PLAYER_ID), CONSEQ_PLAYERS AS (SELECT COUNT(DISTINCT ACT.PLAYER_ID) AS CNT_CONSEQ FROM ACTIVITY AS ACT INNER JOIN FIRST_LOGINS AS FL ON ACT.PLAYER_ID = FL.PLAYER_ID WHERE ACT.EVENT_DATE - FL.FIRST_DATE = 1) SELECT ROUND(CAST(CP.CNT_CONSEQ AS REAL) / COUNT(DISTINCT ACT.PLAYER_ID), 2) AS FRACTION FROM ACTIVITY AS ACT CROSS JOIN CONSEQ_PLAYERS AS CP;

/*
Prediction Result:
(0.25,)
*/