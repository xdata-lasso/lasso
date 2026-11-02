-- Schema DDL
CREATE TABLE "Playback" ("session_id" INTEGER PRIMARY KEY, "customer_id" INTEGER UNIQUE, "start_time" INTEGER, "end_time" INTEGER, CHECK ("start_time" <= 'Playback.end_time'));

CREATE TABLE "Ads" ("ad_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "timestamp" INTEGER, FOREIGN KEY ("customer_id") REFERENCES "Playback" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Playback" ("session_id", "customer_id", "start_time", "end_time") VALUES (1, 10, 1, 5);
INSERT INTO "Playback" ("session_id", "customer_id", "start_time", "end_time") VALUES (2, NULL, 1, 5);
INSERT INTO "Ads" ("ad_id", "customer_id", "timestamp") VALUES (1, NULL, 3);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT session_id FROM playback AS pb LEFT JOIN ads AS ad ON pb.customer_id = ad.customer_id AND ad.timestamp BETWEEN start_time AND end_time WHERE ad.customer_id IS NULL;

/*
Gold Result:
(1,)
(2,)
*/

-- Prediction Query
SELECT SESSION_ID FROM (SELECT SESSION_ID, SUM(AD_VAL) AS GT FROM (SELECT SESSION_ID, PLAYBACK.CUSTOMER_ID, START_TIME, END_TIME, TIMESTAMP, CASE WHEN TIMESTAMP BETWEEN START_TIME AND END_TIME THEN 1 ELSE 0 END AS AD_VAL FROM PLAYBACK INNER JOIN ADS ON PLAYBACK.CUSTOMER_ID = ADS.CUSTOMER_ID) AS AL GROUP BY SESSION_ID) AS OT WHERE OT.GT = 0 UNION ALL SELECT SESSION_ID FROM PLAYBACK WHERE NOT CUSTOMER_ID IN (SELECT CUSTOMER_ID FROM ADS);

/*
Prediction Result:
*/