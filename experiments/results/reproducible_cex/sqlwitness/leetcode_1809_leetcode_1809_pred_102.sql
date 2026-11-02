-- Schema DDL
CREATE TABLE "Playback" ("session_id" INTEGER PRIMARY KEY, "customer_id" INTEGER UNIQUE, "start_time" INTEGER, "end_time" INTEGER, CHECK ("start_time" <= 'Playback.end_time'));

CREATE TABLE "Ads" ("ad_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "timestamp" INTEGER, FOREIGN KEY ("customer_id") REFERENCES "Playback" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO ads (ad_id, customer_id, timestamp) VALUES (2, 2, NULL);
INSERT INTO playback (session_id, customer_id, start_time, end_time) VALUES (0, 1, 2, NULL), (2, 0, NULL, 1), (1, 2, 1, 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT session_id FROM playback AS pb LEFT JOIN ads AS ad ON pb.customer_id = ad.customer_id AND ad.timestamp BETWEEN start_time AND end_time WHERE ad.customer_id IS NULL;

/*
Gold Result:
(0,)
(1,)
(2,)
*/

-- Prediction Query
SELECT SESSION_ID FROM PLAYBACK AS P LEFT JOIN ADS AS A ON A.CUSTOMER_ID = P.CUSTOMER_ID AND P.START_TIME <= A.TIMESTAMP AND P.END_TIME >= A.TIMESTAMP WHERE A.CUSTOMER_ID IS NULL ORDER BY 1, P.session_id NULLS LAST, A.ad_id NULLS LAST;

/*
Prediction Result:
(0,)
(1,)
(2,)
*/