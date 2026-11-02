-- Schema DDL
CREATE TABLE "Playback" ("session_id" INTEGER PRIMARY KEY, "customer_id" INTEGER UNIQUE, "start_time" INTEGER, "end_time" INTEGER, CHECK ("start_time" <= 'Playback.end_time'));

CREATE TABLE "Ads" ("ad_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "timestamp" INTEGER, FOREIGN KEY ("customer_id") REFERENCES "Playback" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO Playback (session_id, customer_id, start_time, end_time) VALUES (0, 1, 1, 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT session_id FROM playback AS pb LEFT JOIN ads AS ad ON pb.customer_id = ad.customer_id AND ad.timestamp BETWEEN start_time AND end_time WHERE ad.customer_id IS NULL;

/*
Gold Result:
(0,)
*/

-- Prediction Query
SELECT SESSION_ID FROM PLAYBACK WHERE NOT SESSION_ID IN (SELECT DISTINCT CASE WHEN TIMESTAMP BETWEEN START_TIME AND END_TIME THEN SESSION_ID ELSE 0 END AS SESSION_ID FROM PLAYBACK AS A LEFT JOIN ADS AS B ON A.CUSTOMER_ID = B.CUSTOMER_ID);

/*
Prediction Result:
*/