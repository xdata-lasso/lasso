-- Schema DDL
CREATE TABLE "Activity" ("player_id" INTEGER, "event_date" DATE, "device_id" INTEGER, "games_played" INTEGER, PRIMARY KEY ("player_id", "event_date"), CHECK ("games_played" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO activity (player_id, event_date, device_id, games_played) VALUES (2, '2023-01-02', -1, 3), (3, '2023-01-01', 3, NULL), (-1, '2023-01-01', 1, 2), (3, '2023-01-02', NULL, 3), (-1, '2023-01-02', 1, 0), (-1000, '2025-06-16', 2, 3), (1, '2023-01-01', -1, NULL), (-1000, '2025-02-19', 3, 1), (1, '2023-01-02', 3, NULL), (-1000, '2026-07-25', 3, NULL), (-1000, '2026-05-25', NULL, NULL), (0, '2023-01-01', -1, 2), (0, '2023-01-02', 2, 0), (-1000, '2024-11-24', 3, 3), (2, '2023-01-01', 3, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ROUND((CAST(SUM(CASE WHEN (temp.min_date + 1) = a.event_date THEN 1 ELSE 0 END) AS REAL) / COUNT(DISTINCT temp.player_id)), 2) AS fraction FROM (SELECT player_id, MIN(event_date) AS min_date FROM activity GROUP BY player_id) AS temp JOIN activity AS a ON temp.player_id = a.player_id;

/*
Gold Result:
(0.0,)
*/

-- Prediction Query
WITH FIRST_LOGINS AS (SELECT ACT.PLAYER_ID, MIN(ACT.EVENT_DATE) AS FIRST_DATE FROM ACTIVITY AS ACT GROUP BY ACT.PLAYER_ID), CONSEQ_PLAYERS AS (SELECT COUNT(DISTINCT ACT.PLAYER_ID) AS CNT_CONSEQ FROM ACTIVITY AS ACT INNER JOIN FIRST_LOGINS AS FL ON ACT.PLAYER_ID = FL.PLAYER_ID WHERE ACT.EVENT_DATE - FL.FIRST_DATE = 1) SELECT ROUND(CAST(CP.CNT_CONSEQ AS REAL) / COUNT(DISTINCT ACT.PLAYER_ID), 2) AS FRACTION FROM ACTIVITY AS ACT CROSS JOIN CONSEQ_PLAYERS AS CP;

/*
Prediction Result:
(0.17,)
*/