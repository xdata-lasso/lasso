-- Schema DDL
CREATE TABLE "Activity" ("player_id" INTEGER, "event_date" DATE, "device_id" INTEGER, "games_played" INTEGER, PRIMARY KEY ("player_id", "event_date"), CHECK ("games_played" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: activity --
INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (1, '2025-06-17', -890215420, 1610062532);

INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (1, '2025-04-30', -734455130, 1744686505);

INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (1, '2025-06-04', 1914020640, 1268590800);

INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (1, '2024-06-15', 700293388, 906324270);

INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (1, '2020-05-06', 2122220075, 1072996612);

INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (1, '2025-08-22', -1349201381, 1019800248);

INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (1, '2023-10-03', -1257178728, 1236688122);

INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (1, '1970-01-02', 2087640001, 907682809);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ROUND((CAST(SUM(CASE WHEN (temp.min_date + 1) = a.event_date THEN 1 ELSE 0 END) AS REAL) / COUNT(DISTINCT temp.player_id)), 2) AS fraction FROM (SELECT player_id, MIN(event_date) AS min_date FROM activity GROUP BY player_id) AS temp JOIN activity AS a ON temp.player_id = a.player_id;

/*
Gold Result:
(0.0,)
*/

-- Prediction Query
WITH CTE AS (SELECT DISTINCT A.PLAYER_ID, A.EVENT_DATE AS FIRST_LOGIN, B.EVENT_DATE AS NEXT_LOGIN FROM ACTIVITY AS A CROSS JOIN ACTIVITY AS B WHERE A.PLAYER_ID = B.PLAYER_ID AND B.EVENT_DATE = A.EVENT_DATE + 1), CTE2 AS (SELECT PLAYER_ID, MIN(EVENT_DATE) AS FIRST_LOGIN FROM ACTIVITY GROUP BY PLAYER_ID), CTE3 AS (SELECT CTE.PLAYER_ID FROM CTE CROSS JOIN CTE2 WHERE CTE.PLAYER_ID = CTE2.PLAYER_ID AND CTE.FIRST_LOGIN = CTE2.FIRST_LOGIN) SELECT ROUND(CAST(COUNT(DISTINCT CTE3.PLAYER_ID) AS REAL) / COUNT(DISTINCT ACTIVITY.PLAYER_ID), 2) AS FRACTION FROM CTE3 CROSS JOIN ACTIVITY;

/*
Prediction Result:
(None,)
*/