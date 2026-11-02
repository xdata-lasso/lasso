-- Schema DDL
CREATE TABLE "Playback" ("session_id" INTEGER PRIMARY KEY, "customer_id" INTEGER UNIQUE, "start_time" INTEGER, "end_time" INTEGER, CHECK ("start_time" <= 'Playback.end_time'));

CREATE TABLE "Ads" ("ad_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "timestamp" INTEGER, FOREIGN KEY ("customer_id") REFERENCES "Playback" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Playback" ("session_id", "customer_id", "start_time", "end_time") VALUES (22, 26, 726, NULL);
INSERT INTO "Playback" ("session_id", "customer_id", "start_time", "end_time") VALUES (49, NULL, NULL, NULL);
INSERT INTO "Ads" ("ad_id", "customer_id", "timestamp") VALUES (24, 26, 726);
INSERT INTO "Ads" ("ad_id", "customer_id", "timestamp") VALUES (23, 26, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT session_id FROM playback AS pb LEFT JOIN ads AS ad ON pb.customer_id = ad.customer_id AND ad.timestamp BETWEEN start_time AND end_time WHERE ad.customer_id IS NULL;

/*
Gold Result:
(22,)
(49,)
*/

-- Prediction Query
SELECT DISTINCT SESSION_ID FROM PLAYBACK AS P LEFT JOIN ADS AS A ON P.CUSTOMER_ID = A.CUSTOMER_ID WHERE NOT SESSION_ID IN (SELECT DISTINCT SESSION_ID FROM PLAYBACK AS P LEFT JOIN ADS AS A ON P.CUSTOMER_ID = A.CUSTOMER_ID WHERE TIMESTAMP BETWEEN START_TIME AND END_TIME OR START_TIME = TIMESTAMP OR END_TIME = TIMESTAMP);

/*
Prediction Result:
(49,)
*/