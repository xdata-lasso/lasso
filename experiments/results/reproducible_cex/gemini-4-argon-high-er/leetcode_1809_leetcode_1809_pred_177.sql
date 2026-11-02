-- Schema DDL
CREATE TABLE "Playback" ("session_id" INTEGER PRIMARY KEY, "customer_id" INTEGER UNIQUE, "start_time" INTEGER, "end_time" INTEGER, CHECK ("start_time" <= 'Playback.end_time'));

CREATE TABLE "Ads" ("ad_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "timestamp" INTEGER, FOREIGN KEY ("customer_id") REFERENCES "Playback" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO Playback (session_id, customer_id, start_time, end_time) VALUES (1, 1, 0, 10);
INSERT INTO Ads (ad_id, customer_id, timestamp) VALUES (1, 1, 20);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT session_id FROM playback AS pb LEFT JOIN ads AS ad ON pb.customer_id = ad.customer_id AND ad.timestamp BETWEEN start_time AND end_time WHERE ad.customer_id IS NULL;

/*
Gold Result:
(1,)
*/

-- Prediction Query
WITH TMP AS (SELECT DISTINCT B.SESSION_ID FROM ADS AS A LEFT JOIN PLAYBACK AS B ON A.CUSTOMER_ID = B.CUSTOMER_ID AND A.TIMESTAMP BETWEEN B.START_TIME AND B.END_TIME) SELECT DISTINCT SESSION_ID FROM PLAYBACK WHERE NOT SESSION_ID IN (SELECT * FROM TMP);

/*
Prediction Result:
*/