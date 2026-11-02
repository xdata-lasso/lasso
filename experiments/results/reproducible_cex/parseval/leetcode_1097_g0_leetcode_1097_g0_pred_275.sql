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

INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (1, '2021-12-14', 1620389964, 546571701);

INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (1, '2024-09-18', 1990080517, 1408123494);

INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (1, '2020-06-05', 700088193, 374105386);

INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (-2147483645, '2024-06-15', 1119186446, 781505063);

INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (-2147483644, '2024-06-15', -1106983592, 1884179925);

INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (1, '2025-08-08', -2070843029, 328305758);

INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (1, '2023-08-24', -314162272, 2137741668);

INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (1, '2024-03-26', -188151580, 226938182);

INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (-2147483643, '2024-06-15', -453362185, 481163439);

INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (3, '2023-07-07', 1909986641, 1485335077);

INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (3, '2024-04-09', -227162283, 2056419640);

INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (3, '2023-10-06', 556727997, 1178000634);

INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (2, '2024-06-15', 1196308825, 910894705);

INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (-2147483640, '2024-06-15', -283454505, 233994589);

INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (3, '2024-02-13', 1298861365, 1968874827);

INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (3, '2023-11-15', 1038566008, 32204797);

INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (3, '2020-05-20', 1784916884, 37673509);

INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (-2147483639, '2024-06-15', -639539893, 1255343543);

INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (3, '2020-03-27', 602161869, 1350414441);

INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (3, '2024-03-11', 777149609, 61479715);

INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (3, '2021-06-18', -458359144, 600440952);

INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (-2147483638, '2024-06-15', 1972233925, 1792827279);

INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (1, '2025-04-30', -1826414375, 357330522);

INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (1, '2025-09-12', -683007527, 2035306060);

INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (1, '2024-02-23', -1762140823, 1371234901);

INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (-2147483637, '2024-06-15', -290314193, 76996700);

INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (1, '2024-06-20', -1928431425, 1303877941);

INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (1, '2022-04-02', -288338724, 1897687032);

INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (1, '2024-12-22', 199672698, 2119806856);

INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (-2147483636, '2024-06-15', 1798111945, 944975670);

INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (1, '2024-07-18', 1691780814, 1944978593);

INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (1, '2025-06-06', 1721638020, 983324983);

INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (1, '2022-07-14', -1699185893, 875300074);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A1.FIRST_LOGIN AS INSTALL_DT, COUNT(DISTINCT A1.PLAYER_ID) AS INSTALLS, ROUND((CAST(SUM(CASE WHEN (A1.FIRST_LOGIN + 1) = A2.EVENT_DATE THEN 1 ELSE 0 END) AS REAL) / COUNT(DISTINCT A1.PLAYER_ID)), 2) AS DAY1_RETENTION FROM (SELECT PLAYER_ID, MIN(EVENT_DATE) AS FIRST_LOGIN FROM ACTIVITY GROUP BY PLAYER_ID) AS A1 JOIN ACTIVITY AS A2 ON A1.PLAYER_ID = A2.PLAYER_ID GROUP BY A1.FIRST_LOGIN;

/*
Gold Result:
('2020-03-27', 1, 0.0)
('2020-06-05', 1, 0.0)
('2024-06-15', 11, 0.0)
*/

-- Prediction Query
WITH FIRSTINSTALL AS (SELECT MIN(EVENT_DATE) AS FIRSTINSTALLDT, PLAYER_ID FROM ACTIVITY GROUP BY 2) SELECT FI.FIRSTINSTALLDT AS INSTALL_DT, COUNT(FI.PLAYER_ID) AS INSTALLS, ROUND(CAST(SUM(CASE WHEN NOT AC.EVENT_DATE IS NULL THEN 1 ELSE 0 END) AS REAL) / COUNT(FI.PLAYER_ID), 2) AS DAY1_RETENTION FROM FIRSTINSTALL AS FI LEFT JOIN ACTIVITY AS AC ON FI.PLAYER_ID = AC.PLAYER_ID AND AC.EVENT_DATE - FI.FIRSTINSTALLDT = 1 GROUP BY 1;

/*
Prediction Result:
('2020-03-27', 1, 1.0)
('2020-06-05', 1, 1.0)
('2024-06-15', 11, 0.0)
*/