-- Schema DDL
CREATE TABLE "Activity" ("player_id" INTEGER, "event_date" DATE, "device_id" INTEGER, "games_played" INTEGER, PRIMARY KEY ("player_id", "event_date"), CHECK ("games_played" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (1067, '1972-12-03', 1069, 1070);
INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (1067, '1972-12-06', 1072, 1073);
INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (1076, '1972-12-10', 1072, 1073);
INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (1095, NULL, 1097, 1098);
INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (1095, NULL, 1100, 1101);
INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (1104, '1973-01-07', 1100, 1101);
INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (1095, '1973-01-09', 1106, 1107);
INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (1095, '1973-01-12', 1109, 1110);
INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (1113, '1973-01-16', 1109, 1110);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT install_dt, COUNT(player_id) AS installs, ROUND(CAST(COUNT(next_day) AS REAL) / COUNT(player_id), 2) AS Day1_retention FROM (SELECT a1.player_id, a1.install_dt, a2.event_date AS next_day FROM (SELECT player_id, MIN(event_date) AS install_dt FROM Activity GROUP BY player_id) AS a1 LEFT JOIN Activity AS a2 ON a1.player_id = a2.player_id AND a2.event_date = a1.install_dt + 1) AS t GROUP BY install_dt;

/*
Gold Result:
('1972-12-03', 1, 0.0)
('1972-12-10', 1, 0.0)
('1973-01-07', 1, 0.0)
('1973-01-09', 1, 0.0)
('1973-01-16', 1, 0.0)
*/

-- Prediction Query
SELECT INSTALL_DT, INSTALLS, ROUND(CAST(RETENTIONS AS REAL(10, 2)) / CAST(INSTALLS AS REAL(10, 2)), 2) AS DAY1_RETENTION FROM (SELECT A.EVENT_DATE AS INSTALL_DT, COUNT(DISTINCT A.PLAYER_ID) AS INSTALLS, COUNT(DISTINCT B.PLAYER_ID) AS RETENTIONS FROM (SELECT EVENT_DATE, PLAYER_ID, RANK() OVER (PARTITION BY PLAYER_ID ORDER BY EVENT_DATE) AS RNK, LEAD(EVENT_DATE) OVER (PARTITION BY PLAYER_ID ORDER BY EVENT_DATE) AS NEXT_LOGIN FROM ACTIVITY) AS A LEFT OUTER JOIN ACTIVITY AS B ON A.EVENT_DATE = B.EVENT_DATE - 1 AND A.PLAYER_ID = B.PLAYER_ID WHERE A.RNK = 1 GROUP BY 1) AS TBL;

/*
Prediction Result:
(None, 1, 0.0)
('1972-12-03', 1, 0.0)
('1972-12-10', 1, 0.0)
('1973-01-07', 1, 0.0)
('1973-01-16', 1, 0.0)
*/