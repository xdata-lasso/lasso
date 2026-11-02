-- Schema DDL
CREATE TABLE "Playback" ("session_id" INTEGER PRIMARY KEY, "customer_id" INTEGER UNIQUE, "start_time" INTEGER, "end_time" INTEGER, CHECK ("start_time" <= 'Playback.end_time'));

CREATE TABLE "Ads" ("ad_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "timestamp" INTEGER, FOREIGN KEY ("customer_id") REFERENCES "Playback" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Playback" ("session_id", "customer_id", "start_time", "end_time") VALUES (1, 1, NULL, 10);
INSERT INTO "Ads" ("ad_id", "customer_id", "timestamp") VALUES (1, 1, 5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT session_id FROM playback AS pb LEFT JOIN ads AS ad ON pb.customer_id = ad.customer_id AND ad.timestamp BETWEEN start_time AND end_time WHERE ad.customer_id IS NULL;

/*
Gold Result:
(1,)
*/

-- Prediction Query
WITH T AS (SELECT DISTINCT P.SESSION_ID, CASE WHEN A.TIMESTAMP < P.START_TIME OR A.TIMESTAMP > P.END_TIME OR A.TIMESTAMP IS NULL THEN 0 ELSE 1 END AS IS_AD_SHOWN FROM PLAYBACK AS P LEFT JOIN ADS AS A ON P.CUSTOMER_ID = A.CUSTOMER_ID) SELECT SESSION_ID FROM T GROUP BY SESSION_ID HAVING SUM(IS_AD_SHOWN) = 0;

/*
Prediction Result:
*/