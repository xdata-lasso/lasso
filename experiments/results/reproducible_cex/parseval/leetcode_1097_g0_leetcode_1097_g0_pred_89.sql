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

INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (-1, '2022-02-26', 907682809, 2026480202);

INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (0, '2021-06-28', 1861536320, 44952191);

INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (1, '2021-12-14', 1620389964, 546571701);

INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (1, '2024-09-18', 1990080517, 1408123494);

INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (1, '2020-06-05', 700088193, 374105386);

INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (3, '1969-12-31', 1119186446, 781505063);

INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (4, '1969-12-31', -1106983592, 1884179925);

INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (5, '1969-12-31', 902551284, 2107872094);

INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (2, '2024-06-15', 882961052, 743312762);

INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (-1, '2020-11-05', 2074205376, 274769912);

INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (0, '2023-05-17', 1898504886, 624571013);

INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (1, '2025-02-11', -1666765085, 1178636309);

INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (1, '2021-12-23', -453362185, 481163439);

INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (1, '2023-07-07', 1909986641, 1485335077);

INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (3, '1970-01-01', 392822403, 2142703426);

INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (4, '1970-01-01', -533293970, 176380444);

INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (5, '1970-01-01', -977635379, 1661181156);

INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (0, '2022-01-09', -346339240, 1692174491);

INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (1, '2025-07-21', 836513442, 176555546);

INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (1, '2020-11-04', 1196308825, 910894705);

INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (1, '2025-01-26', -736979194, 2103044118);

INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (1, '2021-04-26', -1742081330, 894242932);

INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (-1, '2025-01-20', -1762857309, 806170397);

INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (0, '2022-11-06', -688216274, 331812443);

INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (1, '2020-06-01', 1631231566, 172461907);

INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (1, '2024-07-01', 982314585, 638024588);

INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (1, '2025-09-09', -688098735, 1784916884);

INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (-1, '2025-09-14', -566887085, 602161869);

INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (0, '2020-11-23', -1888505890, 777149609);

INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (1, '2024-11-10', -1259474148, 2011234363);

INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (1, '2021-09-25', -2115841792, 1746373317);

INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (1, '2020-09-12', 600440952, 1568069663);

INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (1, '2020-12-02', 710458518, 678047687);

INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (1, '2021-09-30', -197933860, 2111987706);

INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (1, '2024-01-17', -106471771, 1235416111);

INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (1, '2024-10-12', 518609210, 1948383687);

INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (1, '2020-08-23', -1826414375, 357330522);

INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (1, '2025-09-12', -683007527, 2035306060);

INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (1, '2024-02-23', -1762140823, 1371234901);

INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (1, '2023-12-23', 645287482, 765724008);

INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (1, '2025-12-04', -1021978385, 569007824);

INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (1, '2022-08-18', 199672698, 2119806856);

INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (1, '2025-11-04', -1523347137, 1582582341);

INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (1, '2023-05-24', -29242208, 1691780814);

INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (1, '2025-03-18', 1201273976, 1923659053);

INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (1, '2020-02-20', 1721638020, 983324983);

INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (1, '2022-07-14', -1699185893, 875300074);

INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (1, '2021-05-27', -55240145, 1379859112);

INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (1, '2022-10-29', 1817366143, 1615073310);

INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (1, '2025-11-05', 1055237066, 988954859);

INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (6, '2021-02-12', -244633520, 418247369);

INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (6, '2021-08-17', 1803796945, 872694102);

INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (1, '2023-07-01', -1402164108, 2123471885);

INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (1, '2024-03-25', 274891948, 609771851);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A1.FIRST_LOGIN AS INSTALL_DT, COUNT(DISTINCT A1.PLAYER_ID) AS INSTALLS, ROUND((CAST(SUM(CASE WHEN (A1.FIRST_LOGIN + 1) = A2.EVENT_DATE THEN 1 ELSE 0 END) AS REAL) / COUNT(DISTINCT A1.PLAYER_ID)), 2) AS DAY1_RETENTION FROM (SELECT PLAYER_ID, MIN(EVENT_DATE) AS FIRST_LOGIN FROM ACTIVITY GROUP BY PLAYER_ID) AS A1 JOIN ACTIVITY AS A2 ON A1.PLAYER_ID = A2.PLAYER_ID GROUP BY A1.FIRST_LOGIN;

/*
Gold Result:
('1969-12-31', 3, 0.0)
('2020-02-20', 1, 0.0)
('2020-11-05', 1, 0.0)
('2020-11-23', 1, 0.0)
('2021-02-12', 1, 0.0)
('2024-06-15', 1, 0.0)
*/

-- Prediction Query
SELECT A1.EVENT_DATE AS INSTALL_DT, COUNT(A1.PLAYER_ID) AS INSTALLS, ROUND(CAST(SUM(CASE WHEN NOT A2.PLAYER_ID IS NULL THEN 1 ELSE 0 END) AS REAL) / COUNT(A1.PLAYER_ID), 2) AS DAY1_RETENTION FROM ACTIVITY AS A1 LEFT JOIN ACTIVITY AS A2 ON A1.PLAYER_ID = A2.PLAYER_ID AND CAST((JULIANDAY(A2.EVENT_DATE) - JULIANDAY(A1.EVENT_DATE)) AS INTEGER) = 1 WHERE (A1.PLAYER_ID, A1.EVENT_DATE) IN (SELECT PLAYER_ID, MIN(EVENT_DATE) AS EVENT_DATE FROM ACTIVITY GROUP BY PLAYER_ID) GROUP BY A1.EVENT_DATE ORDER BY A1.EVENT_DATE, INSTALL_DT NULLS LAST, INSTALLS NULLS LAST, DAY1_RETENTION NULLS LAST;

/*
Prediction Result:
('1969-12-31', 3, 1.0)
('2020-02-20', 1, 0.0)
('2020-11-05', 1, 0.0)
('2020-11-23', 1, 0.0)
('2021-02-12', 1, 0.0)
('2024-06-15', 1, 0.0)
*/