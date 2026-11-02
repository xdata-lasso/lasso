-- Schema DDL
CREATE TABLE "Activity" ("player_id" INTEGER, "event_date" DATE, "device_id" INTEGER, "games_played" INTEGER, PRIMARY KEY ("player_id", "event_date"), CHECK ("games_played" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: activity --
INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (1, '2024-06-15', -1726781632, 247012447);

INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (1, '2020-06-08', -106629402, 1871297066);

INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (1, '2023-07-13', 1914020640, 1268590800);

INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (1, '2024-03-30', 1115440883, 1644814318);

INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (1, '2021-03-30', -1349201381, 1019800248);

INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (1, '2023-10-03', -1257178728, 1236688122);

INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (1, '2022-02-26', 907682809, 2026480202);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT install_dt, COUNT(player_id) AS installs, ROUND(CAST(COUNT(next_day) AS REAL) / COUNT(player_id), 2) AS Day1_retention FROM (SELECT a1.player_id, a1.install_dt, a2.event_date AS next_day FROM (SELECT player_id, MIN(event_date) AS install_dt FROM Activity GROUP BY player_id) AS a1 LEFT JOIN Activity AS a2 ON a1.player_id = a2.player_id AND a2.event_date = a1.install_dt + 1) AS t GROUP BY install_dt;

/*
Gold Result:
('2020-06-08', 1, 0.0)
*/

-- Prediction Query
WITH HEL AS (SELECT PLAYER_ID, MIN(EVENT_DATE) AS INSTALL_DATE FROM ACTIVITY GROUP BY PLAYER_ID) SELECT C.INSTALL_DATE AS INSTALL_DT, INSTALLS, ROUND(CAST(COALESCE(REN, 0) AS REAL) / INSTALLS, 2) AS DAY1_RETENTION FROM (SELECT INSTALL_DATE, COUNT(PLAYER_ID) AS INSTALLS FROM HEL GROUP BY INSTALL_DATE) AS C LEFT JOIN (SELECT A.INSTALL_DATE, COUNT(B.EVENT_DATE) AS REN FROM HEL AS A JOIN ACTIVITY AS B ON A.PLAYER_ID = B.PLAYER_ID AND A.INSTALL_DATE - B.EVENT_DATE = -1 GROUP BY B.EVENT_DATE) AS D ON C.INSTALL_DATE = D.INSTALL_DATE;

/*
Prediction Result:
('2020-06-08', 1, 1.0)
*/