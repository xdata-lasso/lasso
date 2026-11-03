-- Schema DDL
CREATE TABLE "Activity" ("player_id" INTEGER, "event_date" DATE, "device_id" INTEGER, "games_played" INTEGER, PRIMARY KEY ("player_id", "event_date"), CHECK ("games_played" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (1067, '1972-12-03', 1069, 1070);
INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (1067, '1972-12-06', 1072, 1073);
INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (1076, '1972-12-10', 1072, 1073);
INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (NULL, '1972-12-13', 1079, 1080);
INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (NULL, '1972-12-16', 1082, 1083);
INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (1086, '1972-12-20', 1082, 1083);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT install_dt, COUNT(player_id) AS installs, ROUND(CAST(COUNT(next_day) AS REAL) / COUNT(player_id), 2) AS Day1_retention FROM (SELECT a1.player_id, a1.install_dt, a2.event_date AS next_day FROM (SELECT player_id, MIN(event_date) AS install_dt FROM Activity GROUP BY player_id) AS a1 LEFT JOIN Activity AS a2 ON a1.player_id = a2.player_id AND a2.event_date = a1.install_dt + 1) AS t GROUP BY install_dt;

/*
Gold Result:
('1972-12-03', 1, 0.0)
('1972-12-10', 1, 0.0)
('1972-12-13', 0, None)
('1972-12-20', 1, 0.0)
*/

-- Prediction Query
WITH FA AS (SELECT MIN(EVENT_DATE) AS INSTALL_DT, PLAYER_ID FROM ACTIVITY AS A GROUP BY PLAYER_ID), IA AS (SELECT INSTALL_DT, COUNT(1) AS INSTALLS FROM FA GROUP BY INSTALL_DT) SELECT FA.INSTALL_DT, IA.INSTALLS, ROUND((CAST(SUM(IIF(A.PLAYER_ID IS NULL, 0, 1)) AS REAL) / IA.INSTALLS), 2) AS DAY1_RETENTION FROM FA JOIN IA ON IA.INSTALL_DT = FA.INSTALL_DT LEFT JOIN ACTIVITY AS A ON A.PLAYER_ID = FA.PLAYER_ID AND FA.INSTALL_DT + 1 = A.EVENT_DATE GROUP BY FA.INSTALL_DT, IA.INSTALLS;

/*
Prediction Result:
('1972-12-03', 1, 0.0)
('1972-12-10', 1, 0.0)
('1972-12-13', 1, 0.0)
('1972-12-20', 1, 0.0)
*/