-- Schema DDL
CREATE TABLE "Playback" ("session_id" INTEGER PRIMARY KEY, "customer_id" INTEGER UNIQUE, "start_time" INTEGER, "end_time" INTEGER, CHECK ("start_time" <= 'Playback.end_time'));

CREATE TABLE "Ads" ("ad_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "timestamp" INTEGER, FOREIGN KEY ("customer_id") REFERENCES "Playback" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 5
INSERT INTO Playback (session_id, customer_id, start_time, end_time) VALUES (1, 101, 10, 20);
INSERT INTO Playback (session_id, customer_id, start_time, end_time) VALUES (2, NULL, 10, 20);
INSERT INTO Playback (session_id, customer_id, start_time, end_time) VALUES (3, 103, NULL, 20);
INSERT INTO Playback (session_id, customer_id, start_time, end_time) VALUES (4, 104, 10, NULL);
INSERT INTO Ads (ad_id, customer_id, timestamp) VALUES (1, 101, NULL);
INSERT INTO Ads (ad_id, customer_id, timestamp) VALUES (2, NULL, 15);
INSERT INTO Ads (ad_id, customer_id, timestamp) VALUES (3, 103, 15);
INSERT INTO Ads (ad_id, customer_id, timestamp) VALUES (4, 104, 15);
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
SELECT DISTINCT SESSION_ID FROM PLAYBACK AS P WHERE NOT P.CUSTOMER_ID IN (SELECT A.CUSTOMER_ID FROM ADS AS A WHERE A.TIMESTAMP <= P.END_TIME AND A.TIMESTAMP >= P.START_TIME);

/*
Prediction Result:
(3,)
(4,)
*/