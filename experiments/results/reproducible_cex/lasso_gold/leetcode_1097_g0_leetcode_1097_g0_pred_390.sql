-- Schema DDL
CREATE TABLE "Activity" ("player_id" INTEGER, "event_date" DATE, "device_id" INTEGER, "games_played" INTEGER, PRIMARY KEY ("player_id", "event_date"), CHECK ("games_played" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (1087, 10, 1089, 1091);
INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (1087, 11, 1096.0, 1100.0);
INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (1098, '1970-01-11', 1096.0, 1100.0);
INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (1141, 10, 1143, NULL);
INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (1141, 11, 1150.0, NULL);
INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (1152, '1970-01-16', 1150.0, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A1.FIRST_LOGIN AS INSTALL_DT, COUNT(DISTINCT A1.PLAYER_ID) AS INSTALLS, ROUND((CAST(SUM(CASE WHEN (A1.FIRST_LOGIN + 1) = A2.EVENT_DATE THEN 1 ELSE 0 END) AS REAL) / COUNT(DISTINCT A1.PLAYER_ID)), 2) AS DAY1_RETENTION FROM (SELECT PLAYER_ID, MIN(EVENT_DATE) AS FIRST_LOGIN FROM ACTIVITY GROUP BY PLAYER_ID) AS A1 JOIN ACTIVITY AS A2 ON A1.PLAYER_ID = A2.PLAYER_ID GROUP BY A1.FIRST_LOGIN;

/*
Gold Result:
(10, 2, 1.0)
('1970-01-11', 1, 0.0)
('1970-01-16', 1, 0.0)
*/

-- Prediction Query
SELECT A1.INSTALL_DT, COUNT(A1.PLAYER_ID) AS INSTALLS, COALESCE(ROUND(CAST(SUM(A2.GAMES_PLAYED <> 0) AS REAL) / COUNT(A1.PLAYER_ID), 2), 0) AS DAY1_RETENTION FROM (SELECT PLAYER_ID, MIN(EVENT_DATE) AS INSTALL_DT FROM ACTIVITY GROUP BY PLAYER_ID) AS A1 LEFT JOIN ACTIVITY AS A2 ON A1.INSTALL_DT = A2.EVENT_DATE - 1 AND A1.PLAYER_ID = A2.PLAYER_ID GROUP BY INSTALL_DT;

/*
Prediction Result:
(10, 2, 0.5)
('1970-01-11', 1, 0)
('1970-01-16', 1, 0)
*/