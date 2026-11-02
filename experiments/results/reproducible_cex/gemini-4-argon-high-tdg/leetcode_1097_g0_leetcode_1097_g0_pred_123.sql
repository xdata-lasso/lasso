-- Schema DDL
CREATE TABLE "Activity" ("player_id" INTEGER, "event_date" DATE, "device_id" INTEGER, "games_played" INTEGER, PRIMARY KEY ("player_id", "event_date"), CHECK ("games_played" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Activity (player_id, event_date, device_id, games_played) VALUES (1, 20200101, 10, 5);
INSERT INTO Activity (player_id, event_date, device_id, games_played) VALUES (1, 20200102, 10, 3);
INSERT INTO Activity (player_id, event_date, device_id, games_played) VALUES (1, 20200105, 10, 2);
INSERT INTO Activity (player_id, event_date, device_id, games_played) VALUES (2, 20200101, 20, 1);
INSERT INTO Activity (player_id, event_date, device_id, games_played) VALUES (2, 20200103, 20, 4);
INSERT INTO Activity (player_id, event_date, device_id, games_played) VALUES (3, 20200101, 30, 2);
INSERT INTO Activity (player_id, event_date, device_id, games_played) VALUES (4, 20200110, 40, 6);
INSERT INTO Activity (player_id, event_date, device_id, games_played) VALUES (4, 20200111, 40, 1);
INSERT INTO Activity (player_id, event_date, device_id, games_played) VALUES (5, 20200110, 50, 2);
INSERT INTO Activity (player_id, event_date, device_id, games_played) VALUES (5, 20200111, 50, 8);
INSERT INTO Activity (player_id, event_date, device_id, games_played) VALUES (6, 20200110, 60, 3);
INSERT INTO Activity (player_id, event_date, device_id, games_played) VALUES (7, 20200120, 70, 1);
INSERT INTO Activity (player_id, event_date, device_id, games_played) VALUES (7, 20200122, 70, 2);
INSERT INTO Activity (player_id, event_date, device_id, games_played) VALUES (8, 20200120, 80, 4);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A1.FIRST_LOGIN AS INSTALL_DT, COUNT(DISTINCT A1.PLAYER_ID) AS INSTALLS, ROUND((CAST(SUM(CASE WHEN (A1.FIRST_LOGIN + 1) = A2.EVENT_DATE THEN 1 ELSE 0 END) AS REAL) / COUNT(DISTINCT A1.PLAYER_ID)), 2) AS DAY1_RETENTION FROM (SELECT PLAYER_ID, MIN(EVENT_DATE) AS FIRST_LOGIN FROM ACTIVITY GROUP BY PLAYER_ID) AS A1 JOIN ACTIVITY AS A2 ON A1.PLAYER_ID = A2.PLAYER_ID GROUP BY A1.FIRST_LOGIN;

/*
Gold Result:
(20200101, 3, 0.33)
(20200110, 3, 0.67)
(20200120, 2, 0.0)
*/

-- Prediction Query
WITH C AS (SELECT PLAYER_ID, EVENT_DATE, DENSE_RANK() OVER (PARTITION BY PLAYER_ID ORDER BY EVENT_DATE) AS DSEQ FROM ACTIVITY) SELECT C1.EVENT_DATE AS INSTALL_DT, COUNT(C1.DSEQ) AS INSTALLS, ROUND(CAST(1.0 * COUNT(C2.DSEQ) AS REAL) / COUNT(C1.DSEQ), 2) AS DAY1_RETENTION FROM C AS C1 LEFT JOIN C AS C2 ON C1.PLAYER_ID = C2.PLAYER_ID AND C2.DSEQ = 2 AND CAST((JULIANDAY(C2.EVENT_DATE) - JULIANDAY(C1.EVENT_DATE)) AS INTEGER) = 1 WHERE C1.DSEQ = 1 GROUP BY C1.EVENT_DATE ORDER BY 1, INSTALL_DT NULLS LAST, INSTALLS NULLS LAST, DAY1_RETENTION NULLS LAST;

/*
Prediction Result:
(20200101, 3, 0.0)
(20200110, 3, 0.0)
(20200120, 2, 0.0)
*/