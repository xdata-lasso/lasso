-- Schema DDL
CREATE TABLE "Activity" ("player_id" INTEGER, "event_date" DATE, "device_id" INTEGER, "games_played" INTEGER, PRIMARY KEY ("player_id", "event_date"), CHECK ("games_played" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Activity" ("player_id", "event_date", "device_id", "games_played") VALUES (1, '2016-03-01', 2, 5);
INSERT INTO "Activity" ("player_id", "event_date", "device_id", "games_played") VALUES (1, '2016-03-02', 2, 6);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ROUND((CAST(SUM(CASE WHEN (temp.min_date + 1) = a.event_date THEN 1 ELSE 0 END) AS REAL) / COUNT(DISTINCT temp.player_id)), 2) AS fraction FROM (SELECT player_id, MIN(event_date) AS min_date FROM activity GROUP BY player_id) AS temp JOIN activity AS a ON temp.player_id = a.player_id;

/*
Gold Result:
(0.0,)
*/

-- Prediction Query
SELECT ROUND(CAST(COUNT_CONSEC_TABLE.COUNT_CONSEC AS REAL) / COUNT_TOTAL_TABLE.COUNT_TOTAL, 2) AS FRACTION FROM ((SELECT COUNT(PLAYER_ID) AS COUNT_CONSEC FROM (SELECT PLAYER_ID, EVENT_DATE, RANK() OVER (PARTITION BY PLAYER_ID ORDER BY EVENT_DATE) AS RK, LEAD(EVENT_DATE) OVER (PARTITION BY PLAYER_ID ORDER BY EVENT_DATE) AS PREV_DATE FROM ACTIVITY) AS SUB WHERE CAST((JULIANDAY(EVENT_DATE) - JULIANDAY(PREV_DATE)) AS INTEGER) = -1 AND RK = 1) AS COUNT_CONSEC_TABLE CROSS JOIN (SELECT COUNT(DISTINCT PLAYER_ID) AS COUNT_TOTAL FROM ACTIVITY) AS COUNT_TOTAL_TABLE);

/*
Prediction Result:
(1.0,)
*/