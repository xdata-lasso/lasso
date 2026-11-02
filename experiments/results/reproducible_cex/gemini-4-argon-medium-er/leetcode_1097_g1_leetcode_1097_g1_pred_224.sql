-- Schema DDL
CREATE TABLE "Activity" ("player_id" INTEGER, "event_date" DATE, "device_id" INTEGER, "games_played" INTEGER, PRIMARY KEY ("player_id", "event_date"), CHECK ("games_played" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Activity" ("player_id", "event_date", "device_id", "games_played") VALUES (1, '2020-01-01', 1, 5);
INSERT INTO "Activity" ("player_id", "event_date", "device_id", "games_played") VALUES (1, '2020-01-02', 1, 5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT install_dt, COUNT(player_id) AS installs, ROUND(CAST(COUNT(next_day) AS REAL) / COUNT(player_id), 2) AS Day1_retention FROM (SELECT a1.player_id, a1.install_dt, a2.event_date AS next_day FROM (SELECT player_id, MIN(event_date) AS install_dt FROM Activity GROUP BY player_id) AS a1 LEFT JOIN Activity AS a2 ON a1.player_id = a2.player_id AND a2.event_date = a1.install_dt + 1) AS t GROUP BY install_dt;

/*
Gold Result:
('2020-01-01', 1, 0.0)
*/

-- Prediction Query
WITH ALLFIRSTDATE AS (SELECT PLAYER_ID, MIN(EVENT_DATE) AS FIRST_DATE FROM ACTIVITY GROUP BY 1), FISTDATECOUNT AS (SELECT FIRST_DATE AS INSTALL_DT, COUNT(DISTINCT PLAYER_ID) AS INSTALLS FROM ALLFIRSTDATE GROUP BY 1), NEXTDAYPLAYS AS (SELECT F.FIRST_DATE, COUNT(DISTINCT A.PLAYER_ID) AS PLAYS, COUNT(DISTINCT F.PLAYER_ID) AS INSTALLS FROM ALLFIRSTDATE AS F LEFT OUTER JOIN ACTIVITY AS A ON DATE(F.FIRST_DATE, '1 DAY') = A.EVENT_DATE AND F.PLAYER_ID = A.PLAYER_ID GROUP BY 1) SELECT FIRST_DATE AS INSTALL_DT, INSTALLS, ROUND(CAST((1.00 * PLAYS) AS REAL) / (1.00 * INSTALLS), 2) AS DAY1_RETENTION FROM NEXTDAYPLAYS;

/*
Prediction Result:
('2020-01-01', 1, 1.0)
*/