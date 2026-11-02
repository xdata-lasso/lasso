-- Schema DDL
CREATE TABLE "Playback" ("session_id" INTEGER PRIMARY KEY, "customer_id" INTEGER UNIQUE, "start_time" INTEGER, "end_time" INTEGER, CHECK ("start_time" <= 'Playback.end_time'));

CREATE TABLE "Ads" ("ad_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "timestamp" INTEGER, FOREIGN KEY ("customer_id") REFERENCES "Playback" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "playback" ("session_id", "customer_id", "start_time", "end_time") VALUES (1140, 1138, 1139, 1140);
INSERT INTO "playback" ("session_id", "customer_id", "start_time", "end_time") VALUES (1144, NULL, 1139, 1140);
INSERT INTO "playback" ("session_id", "customer_id", "start_time", "end_time") VALUES (1137, 1145, 1146, 1141);
INSERT INTO "playback" ("session_id", "customer_id", "start_time", "end_time") VALUES (1147, NULL, 1146, 1141);
INSERT INTO "ads" ("ad_id", "customer_id", "timestamp") VALUES (1143, 1138, 1139);
INSERT INTO "ads" ("ad_id", "customer_id", "timestamp") VALUES (1142, NULL, 1139);
INSERT INTO "ads" ("ad_id", "customer_id", "timestamp") VALUES (1150, 1145, 1146);
INSERT INTO "ads" ("ad_id", "customer_id", "timestamp") VALUES (1149, NULL, 1146);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT session_id FROM playback AS pb LEFT JOIN ads AS ad ON pb.customer_id = ad.customer_id AND ad.timestamp BETWEEN start_time AND end_time WHERE ad.customer_id IS NULL;

/*
Gold Result:
(1137,)
(1144,)
(1147,)
*/

-- Prediction Query
SELECT DISTINCT SESSION_ID FROM PLAYBACK AS P LEFT JOIN ADS AS A ON P.CUSTOMER_ID = A.CUSTOMER_ID WHERE NOT SESSION_ID IN (SELECT DISTINCT SESSION_ID FROM PLAYBACK AS P LEFT JOIN ADS AS A ON P.CUSTOMER_ID = A.CUSTOMER_ID WHERE TIMESTAMP BETWEEN START_TIME AND END_TIME OR START_TIME = TIMESTAMP OR END_TIME = TIMESTAMP);

/*
Prediction Result:
(1144,)
(1147,)
*/