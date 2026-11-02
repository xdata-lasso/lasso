-- Schema DDL
CREATE TABLE "Activity" ("player_id" INTEGER, "event_date" DATE, "device_id" INTEGER, "games_played" INTEGER, PRIMARY KEY ("player_id", "event_date"), CHECK ("games_played" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic retention, fractional rounding (1/3 = 0.33), and non-install days vs install days using integer dates.
INSERT INTO "Activity" ("player_id", "event_date", "device_id", "games_played") VALUES (1, 100, 1, 5);
INSERT INTO "Activity" ("player_id", "event_date", "device_id", "games_played") VALUES (1, 101, 1, 2);
INSERT INTO "Activity" ("player_id", "event_date", "device_id", "games_played") VALUES (2, 100, 2, 0);
INSERT INTO "Activity" ("player_id", "event_date", "device_id", "games_played") VALUES (2, 102, 2, 4);
INSERT INTO "Activity" ("player_id", "event_date", "device_id", "games_played") VALUES (3, 100, 3, 1);
INSERT INTO "Activity" ("player_id", "event_date", "device_id", "games_played") VALUES (4, 101, 4, 3);
INSERT INTO "Activity" ("player_id", "event_date", "device_id", "games_played") VALUES (4, 102, 4, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT install_dt, COUNT(player_id) AS installs, ROUND(CAST(COUNT(next_day) AS REAL) / COUNT(player_id), 2) AS Day1_retention FROM (SELECT a1.player_id, a1.install_dt, a2.event_date AS next_day FROM (SELECT player_id, MIN(event_date) AS install_dt FROM Activity GROUP BY player_id) AS a1 LEFT JOIN Activity AS a2 ON a1.player_id = a2.player_id AND a2.event_date = a1.install_dt + 1) AS t GROUP BY install_dt;

/*
Gold Result:
(100, 3, 0.33)
(101, 1, 1.0)
*/

-- Prediction Query
WITH INDIV_INSTALL AS (SELECT PLAYER_ID, MIN(EVENT_DATE) AS INSTALL_DATE FROM ACTIVITY GROUP BY 1), NEXT_LOGIN AS (SELECT PLAYER_ID, EVENT_DATE, LEAD(EVENT_DATE) OVER (PARTITION BY PLAYER_ID ORDER BY EVENT_DATE) AS NEXT_LOGIN FROM ACTIVITY), RETAINED_PEOPLE AS (SELECT PLAYER_ID, EVENT_DATE FROM NEXT_LOGIN WHERE DATE(NEXT_LOGIN, '-1 day') = EVENT_DATE AND (PLAYER_ID, EVENT_DATE) IN (SELECT * FROM INDIV_INSTALL)), RETAINED AS (SELECT EVENT_DATE, COUNT(DISTINCT PLAYER_ID) AS RETAINED_1DAY FROM RETAINED_PEOPLE GROUP BY 1), INSTALLED AS (SELECT INSTALL_DATE, COUNT(PLAYER_ID) AS INSTALLS FROM INDIV_INSTALL GROUP BY 1) SELECT I.INSTALL_DATE AS INSTALL_DT, I.INSTALLS, ROUND(CAST(COALESCE(R.RETAINED_1DAY, 0) AS REAL) / I.INSTALLS, 2) AS DAY1_RETENTION FROM INSTALLED AS I LEFT JOIN RETAINED AS R ON I.INSTALL_DATE = R.EVENT_DATE;

/*
Prediction Result:
(100, 3, 0.0)
(101, 1, 0.0)
*/