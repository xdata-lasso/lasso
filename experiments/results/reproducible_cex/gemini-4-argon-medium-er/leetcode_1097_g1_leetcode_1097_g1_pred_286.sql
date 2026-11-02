-- Schema DDL
CREATE TABLE "Activity" ("player_id" INTEGER, "event_date" DATE, "device_id" INTEGER, "games_played" INTEGER, PRIMARY KEY ("player_id", "event_date"), CHECK ("games_played" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Activity" ("player_id", "event_date", "device_id", "games_played") VALUES (0, 1, 1, 1);
INSERT INTO "Activity" ("player_id", "event_date", "device_id", "games_played") VALUES (0, 2, 1, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT install_dt, COUNT(player_id) AS installs, ROUND(CAST(COUNT(next_day) AS REAL) / COUNT(player_id), 2) AS Day1_retention FROM (SELECT a1.player_id, a1.install_dt, a2.event_date AS next_day FROM (SELECT player_id, MIN(event_date) AS install_dt FROM Activity GROUP BY player_id) AS a1 LEFT JOIN Activity AS a2 ON a1.player_id = a2.player_id AND a2.event_date = a1.install_dt + 1) AS t GROUP BY install_dt;

/*
Gold Result:
(1, 1, 1.0)
*/

-- Prediction Query
SELECT INSTALL_DT, COUNT(D1.PLAYER_ID) AS INSTALLS, ROUND(COUNT(CASE WHEN D2.PLAYER_ID THEN D2.PLAYER_ID ELSE NULL END) / CAST(COUNT(D1.PLAYER_ID) AS REAL), 2) AS DAY1_RETENTION FROM (SELECT PLAYER_ID, MIN(EVENT_DATE) AS INSTALL_DT FROM ACTIVITY GROUP BY 1) AS D1 LEFT JOIN ACTIVITY AS D2 ON D1.PLAYER_ID = D2.PLAYER_ID AND D1.INSTALL_DT + 1 = D2.EVENT_DATE GROUP BY 1;

/*
Prediction Result:
(1, 1, 0.0)
*/