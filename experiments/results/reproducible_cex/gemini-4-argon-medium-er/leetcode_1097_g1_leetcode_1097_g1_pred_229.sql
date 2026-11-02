-- Schema DDL
CREATE TABLE "Activity" ("player_id" INTEGER, "event_date" DATE, "device_id" INTEGER, "games_played" INTEGER, PRIMARY KEY ("player_id", "event_date"), CHECK ("games_played" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Activity" ("player_id", "event_date", "device_id", "games_played") VALUES (1, 1, 1, 1);
INSERT INTO "Activity" ("player_id", "event_date", "device_id", "games_played") VALUES (1, 2, 1, 1);
INSERT INTO "Activity" ("player_id", "event_date", "device_id", "games_played") VALUES (2, 1, 1, 1);
INSERT INTO "Activity" ("player_id", "event_date", "device_id", "games_played") VALUES (3, 1, 1, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT install_dt, COUNT(player_id) AS installs, ROUND(CAST(COUNT(next_day) AS REAL) / COUNT(player_id), 2) AS Day1_retention FROM (SELECT a1.player_id, a1.install_dt, a2.event_date AS next_day FROM (SELECT player_id, MIN(event_date) AS install_dt FROM Activity GROUP BY player_id) AS a1 LEFT JOIN Activity AS a2 ON a1.player_id = a2.player_id AND a2.event_date = a1.install_dt + 1) AS t GROUP BY install_dt;

/*
Gold Result:
(1, 3, 0.33)
*/

-- Prediction Query
SELECT T.EVENT_DATE AS INSTALL_DT, COUNT(T.PLAYER_ID) AS INSTALLS, CAST(CAST(SUM(CASE WHEN T.DATE_ONE IS NULL THEN 0 ELSE 1 END) AS REAL) / COUNT(T.PLAYER_ID) AS REAL(10, 2)) AS DAY1_RETENTION FROM (SELECT A.PLAYER_ID, A.EVENT_DATE, B.EVENT_DATE AS DATE_ONE FROM (SELECT PLAYER_ID, MIN(EVENT_DATE) AS EVENT_DATE FROM ACTIVITY GROUP BY PLAYER_ID) AS A LEFT JOIN (SELECT PLAYER_ID, EVENT_DATE FROM ACTIVITY) AS B ON A.PLAYER_ID = B.PLAYER_ID AND B.EVENT_DATE = A.EVENT_DATE + 1) AS T GROUP BY T.EVENT_DATE;

/*
Prediction Result:
(1, 3, 0.3333333333333333)
*/