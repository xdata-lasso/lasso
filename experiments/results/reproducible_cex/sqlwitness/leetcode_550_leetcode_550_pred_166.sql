-- Schema DDL
CREATE TABLE "Activity" ("player_id" INTEGER, "event_date" DATE, "device_id" INTEGER, "games_played" INTEGER, PRIMARY KEY ("player_id", "event_date"), CHECK ("games_played" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO activity (player_id, event_date, device_id, games_played) VALUES (2, '2023-01-02', -1, 3), (3, '2023-01-01', NULL, 0), (-1, '2023-01-01', 1, 2), (3, '2023-01-02', NULL, 0), (-1, '2023-01-02', 1, 2), (-1000, '2025-06-16', NULL, 3), (1, '2023-01-01', 1, NULL), (1, '2023-01-02', 2, 2), (-1000, '2026-07-25', NULL, 0), (-1000, '2026-05-25', 2, 2), (0, '2023-01-01', 2, NULL), (0, '2023-01-02', 3, 2), (2, '2023-01-01', -1, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ROUND((CAST(SUM(CASE WHEN (temp.min_date + 1) = a.event_date THEN 1 ELSE 0 END) AS REAL) / COUNT(DISTINCT temp.player_id)), 2) AS fraction FROM (SELECT player_id, MIN(event_date) AS min_date FROM activity GROUP BY player_id) AS temp JOIN activity AS a ON temp.player_id = a.player_id;

/*
Gold Result:
(0.0,)
*/

-- Prediction Query
SELECT ROUND(CAST(COUNT(DISTINCT PLAYER_ID) AS REAL) / (SELECT COUNT(DISTINCT PLAYER_ID) FROM ACTIVITY), 2) AS FRACTION FROM (SELECT PLAYER_ID, DEVICE_ID, EVENT_DATE, GAMES_PLAYED, LEAD(EVENT_DATE) OVER (PARTITION BY PLAYER_ID ORDER BY EVENT_DATE) AS NEXT_LOGIN_DATE, RANK() OVER (PARTITION BY PLAYER_ID ORDER BY EVENT_DATE) AS RNK FROM ACTIVITY) AS T WHERE NEXT_LOGIN_DATE - EVENT_DATE = 1 AND RNK = 1;

/*
Prediction Result:
(0.17,)
*/