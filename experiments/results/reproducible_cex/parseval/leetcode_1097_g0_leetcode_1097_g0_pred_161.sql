-- Schema DDL
CREATE TABLE "Activity" ("player_id" INTEGER, "event_date" DATE, "device_id" INTEGER, "games_played" INTEGER, PRIMARY KEY ("player_id", "event_date"), CHECK ("games_played" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: activity --
INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (1, '2025-06-17', -890215420, 1610062532);

INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (1, '2025-04-30', -734455130, 1744686505);

INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (1, '2025-06-04', 1914020640, 1268590800);

INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (1, '1970-01-01', 700293388, 906324270);

INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (1, '2020-05-06', 2122220075, 1072996612);

INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (1, '2025-08-22', -1349201381, 1019800248);

INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (1, '2023-10-03', -1257178728, 1236688122);

INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (1, '1924-04-02', 2087640001, 907682809);

INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (2, '2022-07-21', -45536098, 1861536320);

INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (2, '2023-11-17', -1399556171, 1038707349);

INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (2, '2024-07-24', 546571701, 947159877);

INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (5, '1932-04-22', 1990080517, 1408123494);

INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (2, '2020-06-05', 700088193, 374105386);

INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (2, '2020-06-23', -1683203397, 528680845);

INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (2, '2025-03-28', 1155439218, 1313172851);

INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (2, '2023-08-15', 1119186446, 781505063);

INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (2, '2023-01-30', 1884179925, 902551284);

INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (2, '2020-04-03', -1347802441, 1673584235);

INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (5, '1970-01-01', -2118135981, 2074205376);

INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (2, '2023-01-29', 1898504886, 624571013);

INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (2, '2025-02-11', -1666765085, 1178636309);

INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (2, '2021-12-23', -453362185, 481163439);

INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (2, '2023-07-07', 1909986641, 1485335077);

INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (2, '2024-04-09', -227162283, 2056419640);

INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (2, '2023-10-06', 556727997, 1178000634);

INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (1, '2022-08-22', -461695645, 836513442);

INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (1, '2021-08-12', -1937207087, 1675430660);

INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (1, '2023-10-23', 233994589, 1442655647);

INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (1, '1932-04-22', -1929953647, 1581736075);

INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (1, '2024-12-03', 1298861365, 1968874827);

INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (1, '2023-11-15', 1038566008, 32204797);

INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (1, '2020-05-20', 1784916884, 37673509);

INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (1, '2021-03-28', -348113485, 138842628);

INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (1, '2023-03-04', -566887085, 602161869);

INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (1, '2020-11-23', -1888505890, 777149609);

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
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A1.FIRST_LOGIN AS INSTALL_DT, COUNT(DISTINCT A1.PLAYER_ID) AS INSTALLS, ROUND((CAST(SUM(CASE WHEN (A1.FIRST_LOGIN + 1) = A2.EVENT_DATE THEN 1 ELSE 0 END) AS REAL) / COUNT(DISTINCT A1.PLAYER_ID)), 2) AS DAY1_RETENTION FROM (SELECT PLAYER_ID, MIN(EVENT_DATE) AS FIRST_LOGIN FROM ACTIVITY GROUP BY PLAYER_ID) AS A1 JOIN ACTIVITY AS A2 ON A1.PLAYER_ID = A2.PLAYER_ID GROUP BY A1.FIRST_LOGIN;

/*
Gold Result:
('1924-04-02', 1, 0.0)
('1932-04-22', 1, 0.0)
('2020-04-03', 1, 0.0)
*/

-- Prediction Query
WITH INST AS (SELECT PLAYER_ID, MIN(EVENT_DATE) AS INSTALL_DATE FROM ACTIVITY GROUP BY 1), RETENTION AS (SELECT I.PLAYER_ID, I.INSTALL_DATE FROM INST AS I LEFT JOIN ACTIVITY AS A ON I.PLAYER_ID = A.PLAYER_ID WHERE A.EVENT_DATE - I.INSTALL_DATE = 1) SELECT L.INSTALL_DATE AS INSTALL_DT, COUNT(DISTINCT L.PLAYER_ID) AS INSTALLS, ROUND((CAST(COUNT(DISTINCT R.PLAYER_ID) AS REAL) / COUNT(DISTINCT L.PLAYER_ID)), 2) AS DAY1_RETENTION FROM INST AS L LEFT JOIN RETENTION AS R ON L.PLAYER_ID = R.PLAYER_ID GROUP BY 1;

/*
Prediction Result:
('1924-04-02', 1, 0.0)
('1932-04-22', 1, 0.0)
('2020-04-03', 1, 1.0)
*/