-- Schema DDL
CREATE TABLE "Activity" ("player_id" INTEGER, "event_date" DATE, "device_id" INTEGER, "games_played" INTEGER, PRIMARY KEY ("player_id", "event_date"), CHECK ("games_played" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 4
INSERT INTO Activity (player_id, event_date, device_id, games_played) VALUES (1, '2020-03-01', 1, 5);
INSERT INTO Activity (player_id, event_date, device_id, games_played) VALUES (1, '2020-03-02', 1, 6);
INSERT INTO Activity (player_id, event_date, device_id, games_played) VALUES (2, '2020-06-25', 1, 1);
INSERT INTO Activity (player_id, event_date, device_id, games_played) VALUES (3, '2020-03-01', 2, 0);
INSERT INTO Activity (player_id, event_date, device_id, games_played) VALUES (3, '2020-07-03', 2, 5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT install_dt, COUNT(player_id) AS installs, ROUND(CAST(COUNT(next_day) AS REAL) / COUNT(player_id), 2) AS Day1_retention FROM (SELECT a1.player_id, a1.install_dt, a2.event_date AS next_day FROM (SELECT player_id, MIN(event_date) AS install_dt FROM Activity GROUP BY player_id) AS a1 LEFT JOIN Activity AS a2 ON a1.player_id = a2.player_id AND a2.event_date = a1.install_dt + 1) AS t GROUP BY install_dt;

/*
Gold Result:
('2020-03-01', 2, 0.0)
('2020-06-25', 1, 0.0)
*/

-- Prediction Query
WITH NEXTT AS (SELECT PLAYER_ID, EVENT_DATE, LEAD(EVENT_DATE, 1) OVER (PARTITION BY PLAYER_ID ORDER BY EVENT_DATE ASC) AS NEXTDAY FROM ACTIVITY), MINDATE AS (SELECT PLAYER_ID, MIN(EVENT_DATE) AS FIRST_DATE FROM NEXTT GROUP BY 1), MINANDNEXT AS (SELECT MINDATE.PLAYER_ID, MINDATE.FIRST_DATE, NEXTT.NEXTDAY FROM MINDATE LEFT JOIN NEXTT ON MINDATE.PLAYER_ID = NEXTT.PLAYER_ID AND MINDATE.FIRST_DATE = NEXTT.EVENT_DATE) SELECT FIRST_DATE AS INSTALL_DT, COUNT(DISTINCT (PLAYER_ID)) AS INSTALLS, ROUND(CAST(SUM(CASE WHEN CAST((JULIANDAY(NEXTDAY) - JULIANDAY(FIRST_DATE)) AS INTEGER) = 1 THEN 1 ELSE 0 END) AS REAL) / COUNT(CASE WHEN CAST((JULIANDAY(NEXTDAY) - JULIANDAY(FIRST_DATE)) AS INTEGER) = 1 THEN 1 ELSE 0 END), 2) AS DAY1_RETENTION FROM MINANDNEXT GROUP BY 1;

/*
Prediction Result:
('2020-03-01', 2, 0.5)
('2020-06-25', 1, 0.0)
*/