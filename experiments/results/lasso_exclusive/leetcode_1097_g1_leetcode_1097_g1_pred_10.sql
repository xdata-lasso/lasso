-- Schema DDL
CREATE TABLE "Activity" ("player_id" INTEGER, "event_date" DATE, "device_id" INTEGER, "games_played" INTEGER, PRIMARY KEY ("player_id", "event_date"), CHECK ("games_played" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (1075, 10, 1077, 1079);
INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (1075, 11, 1084.0, 1088.0);
INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (1086, '1980-11-11', 1084.0, 1088.0);
INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (NULL, 10, 1089, 1091);
INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (NULL, 11, 1096.0, 1100.0);
INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (NULL, 10, 1093, 1095);
INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (NULL, 11, 1100.0, 1104.0);
INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (1098, '1981-01-12', 1100.0, 1104.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT install_dt, COUNT(player_id) AS installs, ROUND(CAST(COUNT(next_day) AS REAL) / COUNT(player_id), 2) AS Day1_retention FROM (SELECT a1.player_id, a1.install_dt, a2.event_date AS next_day FROM (SELECT player_id, MIN(event_date) AS install_dt FROM Activity GROUP BY player_id) AS a1 LEFT JOIN Activity AS a2 ON a1.player_id = a2.player_id AND a2.event_date = a1.install_dt + 1) AS t GROUP BY install_dt;

/*
Gold Result:
(10, 1, 1.0)
('1980-11-11', 1, 0.0)
('1981-01-12', 1, 0.0)
*/

-- Prediction Query
SELECT FIRST_LOGIN AS INSTALL_DT, COUNT(*) AS INSTALLS, ROUND(CAST(SUM(PLAYER_STATUS) AS REAL) / COUNT(*), 2) AS DAY1_RETENTION FROM (SELECT LL.PLAYER_ID, LL.FIRST_LOGIN, CASE WHEN RR.PLAYER_ID IS NULL THEN 0 ELSE 1 END AS PLAYER_STATUS FROM (SELECT A.PLAYER_ID, MIN(A.EVENT_DATE) AS FIRST_LOGIN FROM ACTIVITY AS A GROUP BY A.PLAYER_ID) AS LL LEFT JOIN (SELECT DISTINCT L.PLAYER_ID FROM (SELECT B.PLAYER_ID, MIN(B.EVENT_DATE) AS FIRST_LOGIN FROM ACTIVITY AS B GROUP BY B.PLAYER_ID) AS L INNER JOIN ACTIVITY AS R ON L.PLAYER_ID = R.PLAYER_ID WHERE L.FIRST_LOGIN + 1 = R.EVENT_DATE) AS RR ON LL.PLAYER_ID = RR.PLAYER_ID) AS T GROUP BY FIRST_LOGIN;

/*
Prediction Result:
(10, 2, 0.5)
('1980-11-11', 1, 0.0)
('1981-01-12', 1, 0.0)
*/