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

INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (3, '2024-06-15', 2087640001, 907682809);

INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (2, '2024-06-15', -1399556171, 1038707349);

INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (1, '2024-07-24', 546571701, 947159877);

INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (1, '2023-05-08', 1155439218, 1313172851);

INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (1, '2023-08-15', 1119186446, 781505063);

INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (1, '2023-01-30', 1884179925, 902551284);

INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (1, '2020-04-03', -1347802441, 1673584235);

INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (1, '2020-01-28', -314162272, 2137741668);

INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (1, '2024-03-26', -188151580, 226938182);

INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (1, '2022-02-06', 1055976837, 1775126557);

INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (1, '2025-05-30', 481163439, 2123196517);

INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (1, '2020-08-25', -1021749117, 392822403);

INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (1, '2022-09-28', -533293970, 176380444);

INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (1, '2023-01-20', -346339240, 1692174491);

INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (1, '2025-07-21', 836513442, 176555546);

INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (1, '2020-11-04', 1196308825, 910894705);

INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (1, '2025-01-26', -736979194, 2103044118);

INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (1, '2021-04-26', -1742081330, 894242932);

INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (1, '2025-01-20', -1762857309, 806170397);

INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (1, '2022-11-06', -688216274, 331812443);

INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (1, '2020-06-01', 1631231566, 172461907);

INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (1, '2024-07-01', 982314585, 638024588);

INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (1, '2025-09-09', -688098735, 1784916884);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ROUND((CAST(SUM(CASE WHEN (temp.min_date + 1) = a.event_date THEN 1 ELSE 0 END) AS REAL) / COUNT(DISTINCT temp.player_id)), 2) AS fraction FROM (SELECT player_id, MIN(event_date) AS min_date FROM activity GROUP BY player_id) AS temp JOIN activity AS a ON temp.player_id = a.player_id;

/*
Gold Result:
(0.0,)
*/

-- Prediction Query
WITH TOTAL AS (SELECT COUNT(DISTINCT PLAYER_ID) AS TOTAL FROM ACTIVITY), RETENTION AS (SELECT COUNT(DISTINCT A.PLAYER_ID) AS RETENTION FROM ACTIVITY AS A JOIN ACTIVITY AS B ON A.PLAYER_ID = B.PLAYER_ID AND A.EVENT_DATE - B.EVENT_DATE = 1 AND (B.PLAYER_ID, B.EVENT_DATE) IN (SELECT PLAYER_ID, MIN(EVENT_DATE) FROM ACTIVITY GROUP BY 1)) SELECT ROUND(CAST(RETENTION.RETENTION AS REAL) / TOTAL.TOTAL, 2) AS FRACTION FROM TOTAL CROSS JOIN RETENTION;

/*
Prediction Result:
(0.33,)
*/