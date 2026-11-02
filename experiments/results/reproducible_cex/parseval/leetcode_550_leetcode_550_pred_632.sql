-- Schema DDL
CREATE TABLE "Activity" ("player_id" INTEGER, "event_date" DATE, "device_id" INTEGER, "games_played" INTEGER, PRIMARY KEY ("player_id", "event_date"), CHECK ("games_played" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: activity --
INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (-2147483648, '2024-06-15', -1726781632, 247012447);

INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (1, '2020-06-08', -106629402, 1871297066);

INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (1, '2023-07-13', 1914020640, 1268590800);

INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (1, '2024-03-30', 1115440883, 1644814318);

INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (1, '2024-06-15', 429706943, 462974032);

INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (-2147483646, '2024-06-15', 1861536320, 44952191);

INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (2, '2021-12-14', 1620389964, 546571701);

INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (2, '2024-09-18', 1990080517, 1408123494);

INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (2, '2020-06-05', 700088193, 374105386);

INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (5, '2024-06-15', 1119186446, 781505063);

INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (-2147483643, '2024-06-15', -1106983592, 1884179925);

INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (2, '2025-08-08', -2070843029, 328305758);

INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (2, '2023-08-24', -314162272, 2137741668);

INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (2, '2024-03-26', -188151580, 226938182);

INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (-2147483642, '2024-06-15', -453362185, 481163439);

INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (2, '2023-07-07', 1909986641, 1485335077);

INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (2, '2024-04-09', -227162283, 2056419640);

INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (2, '2023-10-06', 556727997, 1178000634);

INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (-2147483641, '2024-06-15', 1196308825, 910894705);

INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (1, '2025-01-26', -736979194, 2103044118);

INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (1, '2021-04-26', -1742081330, 894242932);

INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (1, '2025-01-20', -1762857309, 806170397);

INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (-2147483640, '2024-06-15', 331812443, 1382410067);

INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (1, '2020-05-01', 172461907, 1606439408);

INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (1, '2021-10-23', -155284187, 1686459626);

INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (1, '2021-07-19', -512640349, 1038566008);

INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (-2147483639, '2024-06-15', 602161869, 1350414441);

INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (1, '2024-03-11', 777149609, 61479715);

INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (1, '2021-06-18', -458359144, 600440952);

INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (1, '2020-02-11', -197933860, 2111987706);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ROUND((CAST(SUM(CASE WHEN (temp.min_date + 1) = a.event_date THEN 1 ELSE 0 END) AS REAL) / COUNT(DISTINCT temp.player_id)), 2) AS fraction FROM (SELECT player_id, MIN(event_date) AS min_date FROM activity GROUP BY player_id) AS temp JOIN activity AS a ON temp.player_id = a.player_id;

/*
Gold Result:
(0.0,)
*/

-- Prediction Query
WITH DF1 AS (SELECT PLAYER_ID, MIN(EVENT_DATE) AS FIRST_LOGGEDIN FROM ACTIVITY GROUP BY 1) SELECT ROUND(CAST(1.00 * COUNT(DISTINCT A.PLAYER_ID) AS REAL) / (SELECT COUNT(DISTINCT PLAYER_ID) FROM ACTIVITY), 2) AS FRACTION FROM ACTIVITY AS A JOIN DF1 ON A.PLAYER_ID = DF1.PLAYER_ID AND A.EVENT_DATE - FIRST_LOGGEDIN = 1;

/*
Prediction Result:
(0.2,)
*/