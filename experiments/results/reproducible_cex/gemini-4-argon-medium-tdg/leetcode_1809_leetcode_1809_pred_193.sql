-- Schema DDL
CREATE TABLE "Playback" ("session_id" INTEGER PRIMARY KEY, "customer_id" INTEGER UNIQUE, "start_time" INTEGER, "end_time" INTEGER, CHECK ("start_time" <= 'Playback.end_time'));

CREATE TABLE "Ads" ("ad_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "timestamp" INTEGER, FOREIGN KEY ("customer_id") REFERENCES "Playback" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 5
INSERT INTO "Playback" ("session_id", "customer_id", "start_time", "end_time") VALUES (1, NULL, 10, 20);
INSERT INTO "Playback" ("session_id", "customer_id", "start_time", "end_time") VALUES (2, 100, 10, NULL);
INSERT INTO "Playback" ("session_id", "customer_id", "start_time", "end_time") VALUES (3, 200, NULL, 20);
INSERT INTO "Playback" ("session_id", "customer_id", "start_time", "end_time") VALUES (4, 300, 10, 20);
INSERT INTO "Ads" ("ad_id", "customer_id", "timestamp") VALUES (10, NULL, 15);
INSERT INTO "Ads" ("ad_id", "customer_id", "timestamp") VALUES (20, 100, 15);
INSERT INTO "Ads" ("ad_id", "customer_id", "timestamp") VALUES (30, 200, 15);
INSERT INTO "Ads" ("ad_id", "customer_id", "timestamp") VALUES (40, 300, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT session_id FROM playback AS pb LEFT JOIN ads AS ad ON pb.customer_id = ad.customer_id AND ad.timestamp BETWEEN start_time AND end_time WHERE ad.customer_id IS NULL;

/*
Gold Result:
(1,)
(2,)
(3,)
(4,)
*/

-- Prediction Query
WITH CTE AS (SELECT P.SESSION_ID, SUM(IIF(A.TIMESTAMP < P.START_TIME OR A.TIMESTAMP > P.END_TIME, 1, 0)) AS QUALIFIED_CNT, COUNT(AD_ID) AS TOTAL_CNT FROM PLAYBACK AS P INNER JOIN ADS AS A ON P.CUSTOMER_ID = A.CUSTOMER_ID GROUP BY P.SESSION_ID) SELECT SESSION_ID FROM CTE WHERE QUALIFIED_CNT = TOTAL_CNT UNION ALL SELECT SESSION_ID FROM PLAYBACK WHERE NOT CUSTOMER_ID IN (SELECT CUSTOMER_ID FROM ADS);

/*
Prediction Result:
*/