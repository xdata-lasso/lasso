-- Schema DDL
CREATE TABLE "Activity" ("player_id" INTEGER, "event_date" DATE, "device_id" INTEGER, "games_played" INTEGER, PRIMARY KEY ("player_id", "event_date"), CHECK ("games_played" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: activity --
INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (1, '2024-06-15', 1, 247012447);

INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (1, '2020-06-08', -106629402, 1871297066);

INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (1, '2023-07-13', 1914020640, 1268590800);

INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (1, '2024-03-30', 1115440883, 1644814318);

INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (1, '2021-03-30', -1349201381, 1019800248);

INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (1, '2023-10-03', -1257178728, 1236688122);

INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (1, '2022-02-26', 907682809, 2026480202);

INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (2, '2021-06-28', 1861536320, 44952191);

INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (2, '2021-12-14', 1620389964, 546571701);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT PLAYER_ID, DEVICE_ID FROM ACTIVITY WHERE (PLAYER_ID, EVENT_DATE) IN (SELECT PLAYER_ID, MIN(EVENT_DATE) FROM ACTIVITY GROUP BY PLAYER_ID);

/*
Gold Result:
(1, -106629402)
(2, 1861536320)
*/

-- Prediction Query
SELECT B.DEVICE_ID, B.PLAYER_ID FROM ACTIVITY AS B INNER JOIN (SELECT MIN(EVENT_DATE) AS EVENT_DATE, DEVICE_ID, PLAYER_ID FROM ACTIVITY GROUP BY PLAYER_ID) AS A ON B.EVENT_DATE = A.EVENT_DATE AND A.PLAYER_ID = B.PLAYER_ID;

/*
Prediction Result:
(-106629402, 1)
(1861536320, 2)
*/