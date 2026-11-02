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
WITH CTE AS (SELECT *, MIN(EVENT_DATE) OVER (PARTITION BY PLAYER_ID) AS LOGIN_DATE, LEAD(EVENT_DATE, 1) OVER (PARTITION BY PLAYER_ID ORDER BY EVENT_DATE ASC) AS NEXT_LOGIN, ROW_NUMBER() OVER (PARTITION BY PLAYER_ID ORDER BY EVENT_DATE ASC) AS RK FROM ACTIVITY), CTE2 AS (SELECT LOGIN_DATE, COUNT(PLAYER_ID) AS NUM_LOGINS, SUM(CAST((JULIANDAY(NEXT_LOGIN) - JULIANDAY(LOGIN_DATE)) AS INTEGER) = 1) AS REPEAT_LOGINS FROM CTE WHERE RK = 1 GROUP BY LOGIN_DATE) SELECT LOGIN_DATE AS INSTALL_DT, NUM_LOGINS AS INSTALLS, COALESCE(ROUND(CAST(REPEAT_LOGINS AS REAL) / NUM_LOGINS, 2), 0) AS DAY1_RETENTION FROM CTE2 GROUP BY LOGIN_DATE, INSTALLS, DAY1_RETENTION;

/*
Prediction Result:
('2023-05-01', 2, 0.5)
('2023-05-02', 1, 0.0)
*/