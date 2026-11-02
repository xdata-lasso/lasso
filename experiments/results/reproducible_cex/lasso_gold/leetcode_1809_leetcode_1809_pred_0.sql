-- Schema DDL
CREATE TABLE "Playback" ("session_id" INTEGER PRIMARY KEY, "customer_id" INTEGER UNIQUE, "start_time" INTEGER, "end_time" INTEGER, CHECK ("start_time" <= 'Playback.end_time'));

CREATE TABLE "Ads" ("ad_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "timestamp" INTEGER, FOREIGN KEY ("customer_id") REFERENCES "Playback" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "playback" ("session_id", "customer_id", "start_time", "end_time") VALUES (1054, 1055, 1056, 1057);
INSERT INTO "playback" ("session_id", "customer_id", "start_time", "end_time") VALUES (1060, NULL, 1056, 1057);
INSERT INTO "playback" ("session_id", "customer_id", "start_time", "end_time") VALUES (1082, 1083, NULL, 1085);
INSERT INTO "playback" ("session_id", "customer_id", "start_time", "end_time") VALUES (1096, NULL, 1092, 1093);
INSERT INTO "playback" ("session_id", "customer_id", "start_time", "end_time") VALUES (1099, 1100, NULL, 1057);
INSERT INTO "playback" ("session_id", "customer_id", "start_time", "end_time") VALUES (1129, 1091, NULL, NULL);
INSERT INTO "ads" ("ad_id", "customer_id", "timestamp") VALUES (1058, 1055, 1059);
INSERT INTO "ads" ("ad_id", "customer_id", "timestamp") VALUES (1062, NULL, 1059);
INSERT INTO "ads" ("ad_id", "customer_id", "timestamp") VALUES (1086, 1083, 1087);
INSERT INTO "ads" ("ad_id", "customer_id", "timestamp") VALUES (1090, NULL, 1087);
INSERT INTO "ads" ("ad_id", "customer_id", "timestamp") VALUES (1094, 1091, 1095);
INSERT INTO "ads" ("ad_id", "customer_id", "timestamp") VALUES (1098, NULL, 1095);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT session_id FROM playback AS pb LEFT JOIN ads AS ad ON pb.customer_id = ad.customer_id AND ad.timestamp BETWEEN start_time AND end_time WHERE ad.customer_id IS NULL;

/*
Gold Result:
(1054,)
(1060,)
(1082,)
(1096,)
(1099,)
(1129,)
*/

-- Prediction Query
SELECT B.SESSION_ID FROM (SELECT A.SESSION_ID, MAX(A.LABEL) AS MAX_LABEL FROM (SELECT P.SESSION_ID, CASE WHEN A.TIMESTAMP < P.START_TIME OR A.TIMESTAMP > P.END_TIME OR A.TIMESTAMP IS NULL THEN 0 ELSE 1 END AS LABEL FROM PLAYBACK AS P LEFT JOIN ADS AS A ON P.CUSTOMER_ID = A.CUSTOMER_ID) AS A GROUP BY A.SESSION_ID) AS B WHERE B.MAX_LABEL = 0;

/*
Prediction Result:
(1054,)
(1060,)
(1082,)
(1096,)
(1099,)
*/