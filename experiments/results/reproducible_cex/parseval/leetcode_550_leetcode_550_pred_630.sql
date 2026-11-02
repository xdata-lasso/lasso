-- Schema DDL
CREATE TABLE "Activity" ("player_id" INTEGER, "event_date" DATE, "device_id" INTEGER, "games_played" INTEGER, PRIMARY KEY ("player_id", "event_date"), CHECK ("games_played" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: activity --
INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (1, '2024-06-15', -1726781632, 247012447);

INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (2, '2020-06-08', -106629402, 1871297066);

INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (2, '2023-07-13', 1914020640, 1268590800);

INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (2, '2024-03-30', 1115440883, 1644814318);

INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (2, '2021-03-30', -1349201381, 1019800248);

INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (3, '2023-10-03', -1257178728, 1236688122);

INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (3, '2022-02-26', 907682809, 2026480202);

INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (3, '2021-06-28', 1861536320, 44952191);

INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (3, '2021-12-14', 1620389964, 546571701);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ROUND((CAST(SUM(CASE WHEN (temp.min_date + 1) = a.event_date THEN 1 ELSE 0 END) AS REAL) / COUNT(DISTINCT temp.player_id)), 2) AS fraction FROM (SELECT player_id, MIN(event_date) AS min_date FROM activity GROUP BY player_id) AS temp JOIN activity AS a ON temp.player_id = a.player_id;

/*
Gold Result:
(0.0,)
*/

-- Prediction Query
WITH FIRST_LOGIN AS (SELECT PLAYER_ID, MIN(EVENT_DATE) AS FIRST_LOGIN_DATE FROM ACTIVITY GROUP BY PLAYER_ID) SELECT ROUND(CAST((SELECT COUNT(DISTINCT A1.PLAYER_ID) AS NUMERATOR FROM ACTIVITY AS A1 INNER JOIN FIRST_LOGIN AS A2 ON A1.PLAYER_ID = A2.PLAYER_ID AND A1.EVENT_DATE - A2.FIRST_LOGIN_DATE = 1) AS REAL) / (SELECT COUNT(DISTINCT PLAYER_ID) FROM ACTIVITY), 2) AS FRACTION;

/*
Prediction Result:
(0.67,)
*/