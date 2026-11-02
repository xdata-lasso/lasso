-- Schema DDL
CREATE TABLE "Playback" ("session_id" INTEGER PRIMARY KEY, "customer_id" INTEGER UNIQUE, "start_time" INTEGER, "end_time" INTEGER, CHECK ("start_time" <= 'Playback.end_time'));

CREATE TABLE "Ads" ("ad_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "timestamp" INTEGER, FOREIGN KEY ("customer_id") REFERENCES "Playback" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO ads (ad_id, customer_id, timestamp) VALUES (0, NULL, NULL);
INSERT INTO playback (session_id, customer_id, start_time, end_time) VALUES (1, 0, 0, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT session_id FROM playback AS pb LEFT JOIN ads AS ad ON pb.customer_id = ad.customer_id AND ad.timestamp BETWEEN start_time AND end_time WHERE ad.customer_id IS NULL;

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT PLAYBACK.SESSION_ID FROM PLAYBACK WHERE NOT PLAYBACK.SESSION_ID IN (SELECT DISTINCT PLAYBACK.SESSION_ID FROM ADS LEFT JOIN PLAYBACK ON PLAYBACK.CUSTOMER_ID = ADS.CUSTOMER_ID AND ADS.TIMESTAMP <= PLAYBACK.END_TIME AND ADS.TIMESTAMP >= PLAYBACK.START_TIME);

/*
Prediction Result:
*/