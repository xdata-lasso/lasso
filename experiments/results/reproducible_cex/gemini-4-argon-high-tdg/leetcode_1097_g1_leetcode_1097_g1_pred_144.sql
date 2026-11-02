-- Schema DDL
CREATE TABLE "Activity" ("player_id" INTEGER, "event_date" DATE, "device_id" INTEGER, "games_played" INTEGER, PRIMARY KEY ("player_id", "event_date"), CHECK ("games_played" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Activity (player_id, event_date, device_id, games_played) VALUES (1, 20200101, 10, 5);
INSERT INTO Activity (player_id, event_date, device_id, games_played) VALUES (1, 20200102, 10, 3);
INSERT INTO Activity (player_id, event_date, device_id, games_played) VALUES (2, 20200101, 20, 2);
INSERT INTO Activity (player_id, event_date, device_id, games_played) VALUES (2, 20200102, 20, 4);
INSERT INTO Activity (player_id, event_date, device_id, games_played) VALUES (3, 20200101, 30, 1);
INSERT INTO Activity (player_id, event_date, device_id, games_played) VALUES (4, 20200110, 40, 6);
INSERT INTO Activity (player_id, event_date, device_id, games_played) VALUES (4, 20200111, 40, 2);
INSERT INTO Activity (player_id, event_date, device_id, games_played) VALUES (5, 20200110, 50, 1);
INSERT INTO Activity (player_id, event_date, device_id, games_played) VALUES (6, 20200110, 60, 8);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT install_dt, COUNT(player_id) AS installs, ROUND(CAST(COUNT(next_day) AS REAL) / COUNT(player_id), 2) AS Day1_retention FROM (SELECT a1.player_id, a1.install_dt, a2.event_date AS next_day FROM (SELECT player_id, MIN(event_date) AS install_dt FROM Activity GROUP BY player_id) AS a1 LEFT JOIN Activity AS a2 ON a1.player_id = a2.player_id AND a2.event_date = a1.install_dt + 1) AS t GROUP BY install_dt;

/*
Gold Result:
(20200101, 3, 0.67)
(20200110, 3, 0.33)
*/

-- Prediction Query
WITH EARLIEST_DATE AS (SELECT * FROM (SELECT *, RANK() OVER (PARTITION BY PLAYER_ID ORDER BY EVENT_DATE) AS RN FROM ACTIVITY) AS A WHERE RN = 1), RETAINED AS (SELECT B.EVENT_DATE AS INSTALL_DT, COUNT(DISTINCT B.PLAYER_ID) AS DAY1_RETAINED FROM ACTIVITY AS A INNER JOIN EARLIEST_DATE AS B ON A.PLAYER_ID = B.PLAYER_ID AND DATE(B.EVENT_DATE, '1 DAY') = A.EVENT_DATE GROUP BY B.EVENT_DATE), INSTALLED_ON_FIRST_DAY AS (SELECT B.EVENT_DATE AS INSTALL_DT, COUNT(DISTINCT B.PLAYER_ID) AS INSTALLED_ON_FIRST_DAY FROM ACTIVITY AS A INNER JOIN EARLIEST_DATE AS B ON A.PLAYER_ID = B.PLAYER_ID AND B.EVENT_DATE = A.EVENT_DATE GROUP BY B.EVENT_DATE), AGG_ACTIVITY AS (SELECT A.EVENT_DATE AS INSTALL_DT, COUNT(DISTINCT A.PLAYER_ID) AS INSTALLS FROM ACTIVITY AS A INNER JOIN EARLIEST_DATE AS B USING (PLAYER_ID, EVENT_DATE) GROUP BY A.EVENT_DATE) SELECT A.INSTALL_DT, A.INSTALLS, COALESCE(ROUND(CAST(B.DAY1_RETAINED AS REAL) / C.INSTALLED_ON_FIRST_DAY, 2), 0) AS DAY1_RETENTION FROM AGG_ACTIVITY AS A LEFT JOIN RETAINED AS B USING (INSTALL_DT) LEFT JOIN INSTALLED_ON_FIRST_DAY AS C USING (INSTALL_DT);

/*
Prediction Result:
(20200101, 3, 0)
(20200110, 3, 0)
*/