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
WITH FIRST_INSTALL AS (SELECT PLAYER_ID, MIN(EVENT_DATE) AS INSTALL_DATE FROM ACTIVITY GROUP BY 1), NEXT_DAY AS (SELECT DISTINCT F.PLAYER_ID, 1 AS NEXT_DAY FROM FIRST_INSTALL AS F JOIN ACTIVITY AS A ON F.PLAYER_ID = A.PLAYER_ID AND CAST((JULIANDAY(A.EVENT_DATE) - JULIANDAY(F.INSTALL_DATE)) AS INTEGER) = 1) SELECT F.INSTALL_DATE AS INSTALL_DT, COUNT(*) AS INSTALLS, ROUND(CAST(SUM(COALESCE(N.NEXT_DAY, 0)) AS REAL) / COUNT(*), 2) AS DAY1_RETENTION FROM FIRST_INSTALL AS F LEFT JOIN NEXT_DAY AS N ON F.PLAYER_ID = N.PLAYER_ID GROUP BY 1;

/*
Prediction Result:
('2023-05-01', 2, 0.5)
('2023-05-02', 1, 0.0)
*/