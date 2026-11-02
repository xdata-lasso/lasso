-- Schema DDL
CREATE TABLE "Activity" ("player_id" INTEGER, "event_date" DATE, "device_id" INTEGER, "games_played" INTEGER, PRIMARY KEY ("player_id", "event_date"), CHECK ("games_played" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: activity --
INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (1, '2024-06-15', 1, 0);

INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (1, '2025-06-17', -890215420, 1610062532);

INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (1, '2025-04-30', -734455130, 1744686505);

INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (1, '2025-06-04', 1914020640, 1268590800);

INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (1, '2024-03-30', 1115440883, 1644814318);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A1.FIRST_LOGIN AS INSTALL_DT, COUNT(DISTINCT A1.PLAYER_ID) AS INSTALLS, ROUND((CAST(SUM(CASE WHEN (A1.FIRST_LOGIN + 1) = A2.EVENT_DATE THEN 1 ELSE 0 END) AS REAL) / COUNT(DISTINCT A1.PLAYER_ID)), 2) AS DAY1_RETENTION FROM (SELECT PLAYER_ID, MIN(EVENT_DATE) AS FIRST_LOGIN FROM ACTIVITY GROUP BY PLAYER_ID) AS A1 JOIN ACTIVITY AS A2 ON A1.PLAYER_ID = A2.PLAYER_ID GROUP BY A1.FIRST_LOGIN;

/*
Gold Result:
('2024-03-30', 1, 0.0)
*/

-- Prediction Query
WITH TEMP1 AS (SELECT *, MIN(EVENT_DATE) OVER (PARTITION BY PLAYER_ID ORDER BY EVENT_DATE) AS INSTALL_DATE, LEAD(EVENT_DATE, 1) OVER (PARTITION BY PLAYER_ID ORDER BY EVENT_DATE) AS NEXT_DT FROM ACTIVITY) SELECT INSTALL_DATE AS INSTALL_DT, COUNT(DISTINCT PLAYER_ID) AS INSTALLS, ROUND(CAST((SUM(CASE WHEN (INSTALL_DATE - NEXT_DT) = -1 THEN 1 ELSE 0 END)) AS REAL) / (COUNT(DISTINCT PLAYER_ID)), 2) AS DAY1_RETENTION FROM TEMP1 GROUP BY INSTALL_DATE;

/*
Prediction Result:
('2024-03-30', 1, 3.0)
*/