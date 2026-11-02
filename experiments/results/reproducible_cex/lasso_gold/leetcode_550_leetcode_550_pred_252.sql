-- Schema DDL
CREATE TABLE "Activity" ("player_id" INTEGER, "event_date" DATE, "device_id" INTEGER, "games_played" INTEGER, PRIMARY KEY ("player_id", "event_date"), CHECK ("games_played" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (1023, '1971-02-02', 1025, 1027);
INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (1023, '1972-03-03', 1025, 1027);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ROUND((CAST(SUM(CASE WHEN (temp.min_date + 1) = a.event_date THEN 1 ELSE 0 END) AS REAL) / COUNT(DISTINCT temp.player_id)), 2) AS fraction FROM (SELECT player_id, MIN(event_date) AS min_date FROM activity GROUP BY player_id) AS temp JOIN activity AS a ON temp.player_id = a.player_id;

/*
Gold Result:
(0.0,)
*/

-- Prediction Query
WITH NEXT_DAY_LOG AS (SELECT PLAYER_ID, LEAD(EVENT_DATE) OVER (PARTITION BY PLAYER_ID ORDER BY EVENT_DATE) - EVENT_DATE AS DATE_DIFF, RANK() OVER (PARTITION BY PLAYER_ID ORDER BY EVENT_DATE ASC) AS RNK, EVENT_DATE FROM ACTIVITY) SELECT ROUND(CAST(COUNT(DISTINCT NEDL.PLAYER_ID) AS REAL) / COUNT(DISTINCT ACT.PLAYER_ID), 2) AS FRACTION FROM ACTIVITY AS ACT LEFT OUTER JOIN NEXT_DAY_LOG AS NEDL ON ACT.PLAYER_ID = NEDL.PLAYER_ID AND ACT.EVENT_DATE = NEDL.EVENT_DATE AND RNK = 1 AND DATE_DIFF = 1;

/*
Prediction Result:
(1.0,)
*/