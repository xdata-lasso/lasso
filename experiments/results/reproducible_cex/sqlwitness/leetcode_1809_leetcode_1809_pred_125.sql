-- Schema DDL
CREATE TABLE "Playback" ("session_id" INTEGER PRIMARY KEY, "customer_id" INTEGER UNIQUE, "start_time" INTEGER, "end_time" INTEGER, CHECK ("start_time" <= 'Playback.end_time'));

CREATE TABLE "Ads" ("ad_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "timestamp" INTEGER, FOREIGN KEY ("customer_id") REFERENCES "Playback" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO ads (ad_id, customer_id, timestamp) VALUES (1, 0, 0);
INSERT INTO playback (session_id, customer_id, start_time, end_time) VALUES (1, 1, 1, 1), (0, 0, NULL, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT session_id FROM playback AS pb LEFT JOIN ads AS ad ON pb.customer_id = ad.customer_id AND ad.timestamp BETWEEN start_time AND end_time WHERE ad.customer_id IS NULL;

/*
Gold Result:
(0,)
(1,)
*/

-- Prediction Query
WITH SESSIONS AS (SELECT A.*, B.AD_ID, B.TIMESTAMP FROM PLAYBACK AS A LEFT JOIN ADS AS B ON A.CUSTOMER_ID = B.CUSTOMER_ID AND B.TIMESTAMP >= A.START_TIME AND B.TIMESTAMP <= A.END_TIME) SELECT SESSION_ID FROM SESSIONS WHERE AD_ID IS NULL ORDER BY SESSION_ID;

/*
Prediction Result:
(0,)
(1,)
*/