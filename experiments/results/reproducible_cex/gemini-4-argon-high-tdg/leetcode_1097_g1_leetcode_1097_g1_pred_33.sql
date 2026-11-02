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
WITH INSTALLDATE AS (SELECT PLAYER_ID, MIN(EVENT_DATE) AS INSTALL_DT FROM ACTIVITY GROUP BY PLAYER_ID), INTALLDATEANALYSIS AS (SELECT INSTALL_DT, COUNT(PLAYER_ID) AS INSTALLS FROM INSTALLDATE GROUP BY INSTALL_DT), NEXTLOGIN AS (SELECT A.PLAYER_ID, A.EVENT_DATE, LEAD(EVENT_DATE, 1) OVER (PARTITION BY A.PLAYER_ID ORDER BY A.EVENT_DATE ASC) AS NEXTLOGIN FROM ACTIVITY AS A), "1DAYRETENTIONCOUNTING" AS (SELECT NL.PLAYER_ID, ID.INSTALL_DT, IIF(ABS(CAST((JULIANDAY(NL.EVENT_DATE) - JULIANDAY(NL.NEXTLOGIN)) AS INTEGER)) = 1, 1, 0) AS RETENTION FROM NEXTLOGIN AS NL INNER JOIN INSTALLDATE AS ID ON ID.INSTALL_DT = NL.EVENT_DATE AND NL.PLAYER_ID = ID.PLAYER_ID), "1DAYRETENTIONSUMMARY" AS (SELECT INSTALL_DT, SUM(RETENTION) AS RETENTION FROM "1DAYRETENTIONCOUNTING" GROUP BY INSTALL_DT) SELECT IAD.INSTALL_DT, IAD.INSTALLS, ROUND(CAST("1DRS".RETENTION AS REAL) / IAD.INSTALLS, 2) AS DAY1_RETENTION FROM "1DAYRETENTIONSUMMARY" AS "1DRS" INNER JOIN INTALLDATEANALYSIS AS IAD ON IAD.INSTALL_DT = "1DRS".INSTALL_DT ORDER BY 1 ASC, IAD.INSTALL_DT NULLS LAST, IAD.INSTALLS NULLS LAST, DAY1_RETENTION NULLS LAST;

/*
Prediction Result:
(20200101, 3, 0.0)
(20200110, 3, 0.0)
*/