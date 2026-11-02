-- Schema DDL
CREATE TABLE "Activity" ("player_id" INTEGER, "event_date" DATE, "device_id" INTEGER, "games_played" INTEGER, PRIMARY KEY ("player_id", "event_date"), CHECK ("games_played" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 3
-- Tests standard ISO-8601 string dates in case candidate queries use DATE() functions or standard string dates.
-- Note: In SQLite, '2020-01-01' + 1 evaluates to 2021, so a player logging in on '2021-05-05' would weirdly match if compared loosely, so we avoid year 2021 here.
INSERT INTO Activity (player_id, event_date, device_id, games_played) VALUES (1, '2023-05-01', 1, 5);
INSERT INTO Activity (player_id, event_date, device_id, games_played) VALUES (1, '2023-05-02', 1, 3);
INSERT INTO Activity (player_id, event_date, device_id, games_played) VALUES (2, '2023-05-01', 2, 1);
INSERT INTO Activity (player_id, event_date, device_id, games_played) VALUES (3, '2023-05-02', 3, 2);
INSERT INTO Activity (player_id, event_date, device_id, games_played) VALUES (3, '2023-05-04', 3, 7);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A1.FIRST_LOGIN AS INSTALL_DT, COUNT(DISTINCT A1.PLAYER_ID) AS INSTALLS, ROUND((CAST(SUM(CASE WHEN (A1.FIRST_LOGIN + 1) = A2.EVENT_DATE THEN 1 ELSE 0 END) AS REAL) / COUNT(DISTINCT A1.PLAYER_ID)), 2) AS DAY1_RETENTION FROM (SELECT PLAYER_ID, MIN(EVENT_DATE) AS FIRST_LOGIN FROM ACTIVITY GROUP BY PLAYER_ID) AS A1 JOIN ACTIVITY AS A2 ON A1.PLAYER_ID = A2.PLAYER_ID GROUP BY A1.FIRST_LOGIN;

/*
Gold Result:
('2023-05-01', 2, 0.0)
('2023-05-02', 1, 0.0)
*/

-- Prediction Query
SELECT INSTALL_DT, COUNT(DISTINCT PLAYER_ID) AS INSTALLS, ROUND(CAST(SUM(DAY_1_RETENTION) AS REAL) / COUNT(DISTINCT PLAYER_ID), 2) AS DAY1_RETENTION FROM (SELECT DISTINCT PLAYER_ID, FIRST_VALUE(EVENT_DATE) OVER (PARTITION BY PLAYER_ID ORDER BY EVENT_DATE) AS INSTALL_DT, CASE WHEN CAST((JULIANDAY(EVENT_DATE) - JULIANDAY(FIRST_VALUE(EVENT_DATE) OVER (PARTITION BY PLAYER_ID ORDER BY EVENT_DATE))) AS INTEGER) = 1 THEN 1 ELSE 0 END AS DAY_1_RETENTION FROM ACTIVITY) AS TEMP GROUP BY 1;

/*
Prediction Result:
('2023-05-01', 2, 0.5)
('2023-05-02', 1, 0.0)
*/