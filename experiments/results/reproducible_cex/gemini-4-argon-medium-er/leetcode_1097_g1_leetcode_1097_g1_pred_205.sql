-- Schema DDL
CREATE TABLE "Activity" ("player_id" INTEGER, "event_date" DATE, "device_id" INTEGER, "games_played" INTEGER, PRIMARY KEY ("player_id", "event_date"), CHECK ("games_played" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO Activity (player_id, event_date, device_id, games_played) VALUES (1, 20200101, 10, 5);
INSERT INTO Activity (player_id, event_date, device_id, games_played) VALUES (1, 20200102, 10, 3);
INSERT INTO Activity (player_id, event_date, device_id, games_played) VALUES (2, 20200101, 20, 2);
INSERT INTO Activity (player_id, event_date, device_id, games_played) VALUES (3, 20200101, 30, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT install_dt, COUNT(player_id) AS installs, ROUND(CAST(COUNT(next_day) AS REAL) / COUNT(player_id), 2) AS Day1_retention FROM (SELECT a1.player_id, a1.install_dt, a2.event_date AS next_day FROM (SELECT player_id, MIN(event_date) AS install_dt FROM Activity GROUP BY player_id) AS a1 LEFT JOIN Activity AS a2 ON a1.player_id = a2.player_id AND a2.event_date = a1.install_dt + 1) AS t GROUP BY install_dt;

/*
Gold Result:
(20200101, 3, 0.33)
*/

-- Prediction Query
SELECT C.INSTALL_DATE AS INSTALL_DT, COUNT(DISTINCT C.PLAYER_ID) AS INSTALLS, CAST(CAST(COUNT(DISTINCT CASE WHEN C.INSTALL_DATE + 1 = C.EVENT_DATE THEN C.PLAYER_ID END) AS REAL) / COUNT(DISTINCT C.PLAYER_ID) AS REAL(18, 2)) AS DAY1_RETENTION FROM (SELECT A.*, B.EVENT_DATE, RANK() OVER (PARTITION BY A.PLAYER_ID, A.INSTALL_DATE ORDER BY B.EVENT_DATE ASC) AS EVENT_DT_RANK FROM (SELECT PLAYER_ID, MIN(EVENT_DATE) AS INSTALL_DATE FROM ACTIVITY GROUP BY 1) AS A LEFT JOIN ACTIVITY AS B ON A.PLAYER_ID = B.PLAYER_ID AND B.EVENT_DATE > A.INSTALL_DATE) AS C WHERE C.EVENT_DT_RANK = 1 GROUP BY 1 ORDER BY 1 ASC, INSTALL_DT NULLS LAST, INSTALLS NULLS LAST, DAY1_RETENTION NULLS LAST;

/*
Prediction Result:
(20200101, 3, 0.3333333333333333)
*/