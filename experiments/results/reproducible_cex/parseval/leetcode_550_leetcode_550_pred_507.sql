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

INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (3, '2021-12-14', 1620389964, 546571701);

INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (3, '2024-09-18', 1990080517, 1408123494);

INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (3, '2020-06-05', 700088193, 374105386);

INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (2, '1969-12-31', 1119186446, 781505063);

INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (2, '1970-01-01', -1106983592, 1884179925);

INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (-2147483643, '2024-06-15', 902551284, 2107872094);

INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (3, '2024-08-27', -314162272, 2137741668);

INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (3, '2024-03-26', -188151580, 226938182);

INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (3, '2022-02-06', 1055976837, 1775126557);

INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (-2147483642, '2024-06-15', -74849714, 105869088);

INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (3, '2023-12-17', 481163439, 2123196517);

INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (3, '2020-08-25', -1021749117, 392822403);

INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (3, '2022-09-28', -533293970, 176380444);

INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (2, '1970-01-02', -977635379, 1661181156);

INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (-2147483641, '2024-06-15', 836513442, 176555546);

INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (1, '2020-11-04', 1196308825, 910894705);

INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (1, '2025-01-26', -736979194, 2103044118);

INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (1, '2021-04-26', -1742081330, 894242932);

INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (-2147483640, '2024-06-15', -512640349, 1038566008);

INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (1, '2022-04-12', -688098735, 1784916884);

INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (1, '2025-09-14', -566887085, 602161869);

INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (1, '2020-11-23', -1888505890, 777149609);

INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (-2147483639, '2024-06-15', -2115841792, 1746373317);

INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (1, '2020-09-12', 600440952, 1568069663);

INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (1, '2020-12-02', 710458518, 678047687);

INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (1, '2021-09-30', -197933860, 2111987706);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ROUND((CAST(SUM(CASE WHEN (temp.min_date + 1) = a.event_date THEN 1 ELSE 0 END) AS REAL) / COUNT(DISTINCT temp.player_id)), 2) AS fraction FROM (SELECT player_id, MIN(event_date) AS min_date FROM activity GROUP BY player_id) AS temp JOIN activity AS a ON temp.player_id = a.player_id;

/*
Gold Result:
(0.0,)
*/

-- Prediction Query
WITH CTE AS (SELECT PLAYER_ID, MIN(EVENT_DATE) AS FIRST_LOGIN FROM ACTIVITY GROUP BY PLAYER_ID ORDER BY PLAYER_ID, FIRST_LOGIN NULLS LAST) SELECT ROUND(CAST(COUNT(ACTIVITY.PLAYER_ID) AS REAL) / (SELECT COUNT(DISTINCT PLAYER_ID) FROM ACTIVITY), 2) AS FRACTION FROM ACTIVITY JOIN CTE ON CTE.PLAYER_ID = ACTIVITY.PLAYER_ID AND CAST((JULIANDAY(ACTIVITY.EVENT_DATE) - JULIANDAY(CTE.FIRST_LOGIN)) AS INTEGER) = 1;

/*
Prediction Result:
(0.1,)
*/