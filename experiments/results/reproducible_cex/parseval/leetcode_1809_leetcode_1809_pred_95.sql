-- Schema DDL
CREATE TABLE "Playback" ("session_id" INTEGER PRIMARY KEY, "customer_id" INTEGER UNIQUE, "start_time" INTEGER, "end_time" INTEGER, CHECK ("start_time" <= 'Playback.end_time'));

CREATE TABLE "Ads" ("ad_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "timestamp" INTEGER, FOREIGN KEY ("customer_id") REFERENCES "Playback" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: playback --
INSERT INTO "playback" ("session_id", "customer_id", "start_time", "end_time") VALUES (1, 2, -55602865, -59984348);

INSERT INTO "playback" ("session_id", "customer_id", "start_time", "end_time") VALUES (-2147483647, 3, -664303813, -1022641847);

INSERT INTO "playback" ("session_id", "customer_id", "start_time", "end_time") VALUES (-2147483646, 1, -734455130, 1744686505);

-- Inserting into table: ads --
INSERT INTO "ads" ("ad_id", "customer_id", "timestamp") VALUES (-2147483648, 2, -1726781632);

INSERT INTO "ads" ("ad_id", "customer_id", "timestamp") VALUES (-2147483647, 2, 247012447);

INSERT INTO "ads" ("ad_id", "customer_id", "timestamp") VALUES (-2147483646, 2, -1980249628);

INSERT INTO "ads" ("ad_id", "customer_id", "timestamp") VALUES (2, 1, -1633151678);

INSERT INTO "ads" ("ad_id", "customer_id", "timestamp") VALUES (3, 1, -252690330);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT session_id FROM playback AS pb LEFT JOIN ads AS ad ON pb.customer_id = ad.customer_id AND ad.timestamp BETWEEN start_time AND end_time WHERE ad.customer_id IS NULL;

/*
Gold Result:
(-2147483647,)
(1,)
*/

-- Prediction Query
SELECT DISTINCT SESSION_ID FROM PLAYBACK WHERE NOT SESSION_ID IN (SELECT DISTINCT P.SESSION_ID FROM ADS AS A LEFT JOIN PLAYBACK AS P ON A.CUSTOMER_ID = P.CUSTOMER_ID AND A.TIMESTAMP BETWEEN P.START_TIME AND P.END_TIME);

/*
Prediction Result:
*/