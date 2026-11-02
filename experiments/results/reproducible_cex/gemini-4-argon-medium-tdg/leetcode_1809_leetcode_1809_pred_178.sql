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
WITH CTE AS (SELECT DISTINCT SESSION_ID, CASE WHEN NOT A.TIMESTAMP BETWEEN START_TIME AND END_TIME THEN 1 ELSE 0 END AS AA FROM PLAYBACK AS P JOIN ADS AS A ON A.CUSTOMER_ID = P.CUSTOMER_ID) SELECT SESSION_ID FROM PLAYBACK WHERE NOT SESSION_ID IN (SELECT SESSION_ID FROM CTE WHERE AA = 0);

/*
Prediction Result:
(1,)
*/