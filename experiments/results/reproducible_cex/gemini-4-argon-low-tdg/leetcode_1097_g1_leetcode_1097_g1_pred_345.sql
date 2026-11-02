-- Schema DDL
CREATE TABLE "Activity" ("player_id" INTEGER, "event_date" DATE, "device_id" INTEGER, "games_played" INTEGER, PRIMARY KEY ("player_id", "event_date"), CHECK ("games_played" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
-- Tests ISO string dates (e.g. '2016-03-01') to catch mutants differing in date addition vs integer addition, plus 0% and 50% retention.
INSERT INTO "Activity" ("player_id", "event_date", "device_id", "games_played") VALUES (1, '2016-03-01', 2, 5);
INSERT INTO "Activity" ("player_id", "event_date", "device_id", "games_played") VALUES (1, '2016-03-02', 2, 6);
INSERT INTO "Activity" ("player_id", "event_date", "device_id", "games_played") VALUES (2, '2016-06-25', 1, 1);
INSERT INTO "Activity" ("player_id", "event_date", "device_id", "games_played") VALUES (3, '2016-03-01', 3, 0);
INSERT INTO "Activity" ("player_id", "event_date", "device_id", "games_played") VALUES (3, '2016-07-03', 3, 5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT install_dt, COUNT(player_id) AS installs, ROUND(CAST(COUNT(next_day) AS REAL) / COUNT(player_id), 2) AS Day1_retention FROM (SELECT a1.player_id, a1.install_dt, a2.event_date AS next_day FROM (SELECT player_id, MIN(event_date) AS install_dt FROM Activity GROUP BY player_id) AS a1 LEFT JOIN Activity AS a2 ON a1.player_id = a2.player_id AND a2.event_date = a1.install_dt + 1) AS t GROUP BY install_dt;

/*
Gold Result:
('2016-03-01', 2, 0.0)
('2016-06-25', 1, 0.0)
*/

-- Prediction Query
WITH PLAYERS_RANKED_DAYS AS (SELECT PLAYER_ID, EVENT_DATE, ROW_NUMBER() OVER (PARTITION BY PLAYER_ID ORDER BY EVENT_DATE ASC) AS LOGIN_DAY_RANK FROM ACTIVITY), FIRST_DAY_LOGINS AS (SELECT PLAYER_ID, EVENT_DATE FROM PLAYERS_RANKED_DAYS WHERE LOGIN_DAY_RANK = 1), INSTALLS_BY_DATE AS (SELECT EVENT_DATE, COUNT(PLAYER_ID) AS INSTALLS FROM FIRST_DAY_LOGINS GROUP BY EVENT_DATE), DAY_DIFFERENCE AS (SELECT PLAYER_ID, EVENT_DATE, CAST((JULIANDAY(EVENT_DATE) - JULIANDAY(NEXT_DAY)) AS INTEGER) AS NEXT_DAY_DIFF FROM (SELECT PLAYER_ID, EVENT_DATE, LEAD(EVENT_DATE, 1) OVER (PARTITION BY PLAYER_ID ORDER BY EVENT_DATE ASC) AS NEXT_DAY FROM PLAYERS_RANKED_DAYS WHERE LOGIN_DAY_RANK = 1 OR LOGIN_DAY_RANK = 2) AS T1), ONE_DAY_RETAINERS AS (SELECT EVENT_DATE, COUNT(PLAYER_ID) AS ONE_DAY_RETAINED_PLAYERS FROM (SELECT PLAYER_ID, EVENT_DATE FROM DAY_DIFFERENCE WHERE NEXT_DAY_DIFF = -1) AS T1 GROUP BY EVENT_DATE) SELECT EVENT_DATE AS INSTALL_DT, INSTALLS, (CASE WHEN DAY1_RETENTION IS NULL THEN 0.00 ELSE DAY1_RETENTION END) AS DAY1_RETENTION FROM (SELECT A.EVENT_DATE, INSTALLS, ROUND(CAST(ONE_DAY_RETAINED_PLAYERS AS REAL) / INSTALLS, 2) AS DAY1_RETENTION FROM INSTALLS_BY_DATE AS A LEFT JOIN ONE_DAY_RETAINERS AS B ON A.EVENT_DATE = B.EVENT_DATE) AS T1;

/*
Prediction Result:
('2016-03-01', 2, 0.5)
('2016-06-25', 1, 0.0)
*/