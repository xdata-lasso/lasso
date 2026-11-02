-- Schema DDL
CREATE TABLE "Activity" ("player_id" INTEGER, "event_date" DATE, "device_id" INTEGER, "games_played" INTEGER, PRIMARY KEY ("player_id", "event_date"), CHECK ("games_played" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Activity (player_id, event_date, device_id, games_played) VALUES (1, 20200101, 10, 5);
INSERT INTO Activity (player_id, event_date, device_id, games_played) VALUES (1, 20200102, 10, 3);
INSERT INTO Activity (player_id, event_date, device_id, games_played) VALUES (2, 20200101, 20, 2);
INSERT INTO Activity (player_id, event_date, device_id, games_played) VALUES (2, 20200102, 20, 4);
INSERT INTO Activity (player_id, event_date, device_id, games_played) VALUES (3, 20200101, 30, 1);
INSERT INTO Activity (player_id, event_date, device_id, games_played) VALUES (4, 20200110, 40, 6);
INSERT INTO Activity (player_id, event_date, device_id, games_played) VALUES (4, 20200111, 40, 2);
INSERT INTO Activity (player_id, event_date, device_id, games_played) VALUES (5, 20200110, 50, 1);
INSERT INTO Activity (player_id, event_date, device_id, games_played) VALUES (6, 20200110, 60, 8);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT install_dt, COUNT(player_id) AS installs, ROUND(CAST(COUNT(next_day) AS REAL) / COUNT(player_id), 2) AS Day1_retention FROM (SELECT a1.player_id, a1.install_dt, a2.event_date AS next_day FROM (SELECT player_id, MIN(event_date) AS install_dt FROM Activity GROUP BY player_id) AS a1 LEFT JOIN Activity AS a2 ON a1.player_id = a2.player_id AND a2.event_date = a1.install_dt + 1) AS t GROUP BY install_dt;

/*
Gold Result:
(20200101, 3, 0.67)
(20200110, 3, 0.33)
*/

-- Prediction Query
WITH FIRST_LOGIN AS (SELECT PLAYER_ID, MIN(EVENT_DATE) AS FIRST_EVENT_DATE FROM ACTIVITY GROUP BY PLAYER_ID), CONSECUTIVE_SECOND_LOGIN AS (SELECT A.PLAYER_ID, F.FIRST_EVENT_DATE FROM ACTIVITY AS A INNER JOIN FIRST_LOGIN AS F ON A.PLAYER_ID = F.PLAYER_ID AND A.EVENT_DATE = DATE(F.FIRST_EVENT_DATE, '1 DAY') GROUP BY A.PLAYER_ID, F.FIRST_EVENT_DATE), COUNT_USERS_BY_EVENT_DATE AS (SELECT FIRST_EVENT_DATE, COUNT(*) AS USERCOUNT FROM FIRST_LOGIN GROUP BY FIRST_EVENT_DATE), COUNT_CONSECUTIVE_SECONDLOGIN_USERS_BY_EVENT_DATE AS (SELECT FIRST_EVENT_DATE, COUNT(*) AS SECONDUSERCOUNT FROM CONSECUTIVE_SECOND_LOGIN GROUP BY FIRST_EVENT_DATE) SELECT C.FIRST_EVENT_DATE AS INSTALL_DT, C.USERCOUNT AS INSTALLS, ROUND(CAST(COALESCE(C2.SECONDUSERCOUNT, 0) AS REAL) / C.USERCOUNT, 2) AS DAY1_RETENTION FROM COUNT_USERS_BY_EVENT_DATE AS C LEFT JOIN COUNT_CONSECUTIVE_SECONDLOGIN_USERS_BY_EVENT_DATE AS C2 ON C.FIRST_EVENT_DATE = C2.FIRST_EVENT_DATE;

/*
Prediction Result:
(20200101, 3, 0.0)
(20200110, 3, 0.0)
*/