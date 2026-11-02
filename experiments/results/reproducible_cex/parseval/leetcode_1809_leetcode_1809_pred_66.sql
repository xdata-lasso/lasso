-- Schema DDL
CREATE TABLE "Playback" ("session_id" INTEGER PRIMARY KEY, "customer_id" INTEGER UNIQUE, "start_time" INTEGER, "end_time" INTEGER, CHECK ("start_time" <= 'Playback.end_time'));

CREATE TABLE "Ads" ("ad_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "timestamp" INTEGER, FOREIGN KEY ("customer_id") REFERENCES "Playback" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: playback --
INSERT INTO "playback" ("session_id", "customer_id", "start_time", "end_time") VALUES (1, -2147483648, -55602865, -59984348);

INSERT INTO "playback" ("session_id", "customer_id", "start_time", "end_time") VALUES (-2147483647, 3, -664303813, -1022641847);

INSERT INTO "playback" ("session_id", "customer_id", "start_time", "end_time") VALUES (-2147483646, 2, -1726781632, 247012447);

INSERT INTO "playback" ("session_id", "customer_id", "start_time", "end_time") VALUES (-2147483645, 1, -1633151678, -252690330);

-- Inserting into table: ads --
INSERT INTO "ads" ("ad_id", "customer_id", "timestamp") VALUES (-2147483648, 2, -1980249628);

INSERT INTO "ads" ("ad_id", "customer_id", "timestamp") VALUES (-2147483647, 2, -734455130);

INSERT INTO "ads" ("ad_id", "customer_id", "timestamp") VALUES (-2147483646, 2, 1744686505);

INSERT INTO "ads" ("ad_id", "customer_id", "timestamp") VALUES (2, 1, 1115440883);

INSERT INTO "ads" ("ad_id", "customer_id", "timestamp") VALUES (3, 1, 1644814318);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT session_id FROM playback AS pb LEFT JOIN ads AS ad ON pb.customer_id = ad.customer_id AND ad.timestamp BETWEEN start_time AND end_time WHERE ad.customer_id IS NULL;

/*
Gold Result:
(-2147483647,)
(-2147483645,)
(1,)
*/

-- Prediction Query
SELECT PLAYBACK.SESSION_ID FROM PLAYBACK WHERE NOT PLAYBACK.SESSION_ID IN (SELECT DISTINCT PLAYBACK.SESSION_ID FROM ADS LEFT JOIN PLAYBACK ON PLAYBACK.CUSTOMER_ID = ADS.CUSTOMER_ID AND ADS.TIMESTAMP <= PLAYBACK.END_TIME AND ADS.TIMESTAMP >= PLAYBACK.START_TIME);

/*
Prediction Result:
*/