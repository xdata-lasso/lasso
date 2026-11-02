-- Schema DDL
CREATE TABLE "follows" ("f1" INTEGER(11), "f2" INTEGER(11), PRIMARY KEY ("f1", "f2"), FOREIGN KEY ("f2") REFERENCES "user_profiles" ("uid"), FOREIGN KEY ("f1") REFERENCES "user_profiles" ("uid"));

CREATE TABLE "tweets" ("id" INTEGER(20) PRIMARY KEY, "uid" INTEGER(11), "text" TEXT(140), "createdate" DATETIME, FOREIGN KEY ("uid") REFERENCES "user_profiles" ("uid"));

CREATE TABLE "user_profiles" ("uid" INTEGER(11) PRIMARY KEY, "name" TEXT(255), "email" TEXT(255), "partitionid" INTEGER(11), "followers" INTEGER(11));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: user_profiles --
INSERT INTO "user_profiles" ("uid", "name", "email", "partitionid", "followers") VALUES (1, 't1__97f2cb', 't1__d21203', -55602865, -59984348);

INSERT INTO "user_profiles" ("uid", "name", "email", "partitionid", "followers") VALUES (-2147483647, 'use_9bbfbd', 'use_dc6265', -1022641847, -1726781632);

INSERT INTO "user_profiles" ("uid", "name", "email", "partitionid", "followers") VALUES (-2147483646, 'use_9bbfbd', 'use_dc6265', 1610062532, -106629402);

INSERT INTO "user_profiles" ("uid", "name", "email", "partitionid", "followers") VALUES (2, 't1__97f2cb', 't1__d21203', 1871297066, 809183447);

INSERT INTO "user_profiles" ("uid", "name", "email", "partitionid", "followers") VALUES (3, 't1__97f2cb', 't1__d21203', 89267185, -1865039888);

INSERT INTO "user_profiles" ("uid", "name", "email", "partitionid", "followers") VALUES (4, 'use_9bbfbd', 'use_dc6265', 1268590800, 1219478689);

INSERT INTO "user_profiles" ("uid", "name", "email", "partitionid", "followers") VALUES (-2147483642, 'use_9bbfbd', 'use_dc6265', -1349201381, 1019800248);

INSERT INTO "user_profiles" ("uid", "name", "email", "partitionid", "followers") VALUES (-2147483641, 'use_9bbfbd', 'use_dc6265', 1526238907, -1377057208);

INSERT INTO "user_profiles" ("uid", "name", "email", "partitionid", "followers") VALUES (-2147483640, 'use_9bbfbd', 'use_dc6265', -1364429300, -1257178728);

INSERT INTO "user_profiles" ("uid", "name", "email", "partitionid", "followers") VALUES (-2147483639, 'use_9bbfbd', 'use_dc6265', 2087640001, 907682809);

INSERT INTO "user_profiles" ("uid", "name", "email", "partitionid", "followers") VALUES (-2147483638, 'use_9bbfbd', 'use_dc6265', -918961358, -1602639011);

INSERT INTO "user_profiles" ("uid", "name", "email", "partitionid", "followers") VALUES (-2147483637, 'use_9bbfbd', 'use_dc6265', -1209887326, -1399556171);

INSERT INTO "user_profiles" ("uid", "name", "email", "partitionid", "followers") VALUES (-2147483636, 'use_9bbfbd', 'use_dc6265', 1620389964, 546571701);

INSERT INTO "user_profiles" ("uid", "name", "email", "partitionid", "followers") VALUES (-2147483635, 'use_9bbfbd', 'use_dc6265', 700088193, 374105386);

INSERT INTO "user_profiles" ("uid", "name", "email", "partitionid", "followers") VALUES (-2147483634, 'use_9bbfbd', 'use_dc6265', 1274489983, -1683203397);

INSERT INTO "user_profiles" ("uid", "name", "email", "partitionid", "followers") VALUES (-2147483633, 'use_9bbfbd', 'use_dc6265', -1833165707, 1155439218);

INSERT INTO "user_profiles" ("uid", "name", "email", "partitionid", "followers") VALUES (-2147483632, 'use_9bbfbd', 'use_dc6265', -761141909, 283598170);

INSERT INTO "user_profiles" ("uid", "name", "email", "partitionid", "followers") VALUES (-2147483631, 'use_9bbfbd', 'use_dc6265', -443340271, 757448742);

INSERT INTO "user_profiles" ("uid", "name", "email", "partitionid", "followers") VALUES (-2147483630, 'use_9bbfbd', 'use_dc6265', 902887186, -967741825);

INSERT INTO "user_profiles" ("uid", "name", "email", "partitionid", "followers") VALUES (-2147483629, 'use_9bbfbd', 'use_dc6265', 373262291, -472966518);

INSERT INTO "user_profiles" ("uid", "name", "email", "partitionid", "followers") VALUES (-2147483628, 'use_9bbfbd', 'use_dc6265', 1884179925, 902551284);

INSERT INTO "user_profiles" ("uid", "name", "email", "partitionid", "followers") VALUES (-2147483627, 'use_9bbfbd', 'use_dc6265', 328305758, -751275471);

INSERT INTO "user_profiles" ("uid", "name", "email", "partitionid", "followers") VALUES (-2147483626, 'use_9bbfbd', 'use_dc6265', 1673584235, -2118135981);

INSERT INTO "user_profiles" ("uid", "name", "email", "partitionid", "followers") VALUES (-2147483625, 'use_9bbfbd', 'use_dc6265', 274769912, -188151580);

INSERT INTO "user_profiles" ("uid", "name", "email", "partitionid", "followers") VALUES (-2147483624, 'use_9bbfbd', 'use_dc6265', -1666765085, 1178636309);

INSERT INTO "user_profiles" ("uid", "name", "email", "partitionid", "followers") VALUES (-2147483623, 'use_9bbfbd', 'use_dc6265', -305670381, -1525670226);

INSERT INTO "user_profiles" ("uid", "name", "email", "partitionid", "followers") VALUES (-2147483622, 'use_9bbfbd', 'use_dc6265', 105869088, -2081315180);

-- Inserting into table: follows --
INSERT INTO "follows" ("f1", "f2") VALUES (1, 1);

INSERT INTO "follows" ("f1", "f2") VALUES (1, -2147483647);

INSERT INTO "follows" ("f1", "f2") VALUES (1, -2147483646);

INSERT INTO "follows" ("f1", "f2") VALUES (2, 1);

INSERT INTO "follows" ("f1", "f2") VALUES (2, -2147483646);

INSERT INTO "follows" ("f1", "f2") VALUES (2, -2147483647);

INSERT INTO "follows" ("f1", "f2") VALUES (4, 1);

INSERT INTO "follows" ("f1", "f2") VALUES (4, 4);

INSERT INTO "follows" ("f1", "f2") VALUES (4, -2147483646);

INSERT INTO "follows" ("f1", "f2") VALUES (4, 2);

INSERT INTO "follows" ("f1", "f2") VALUES (4, -2147483642);

INSERT INTO "follows" ("f1", "f2") VALUES (4, -2147483641);

INSERT INTO "follows" ("f1", "f2") VALUES (4, 3);

INSERT INTO "follows" ("f1", "f2") VALUES (4, -2147483640);

INSERT INTO "follows" ("f1", "f2") VALUES (4, -2147483639);

INSERT INTO "follows" ("f1", "f2") VALUES (4, -2147483638);

INSERT INTO "follows" ("f1", "f2") VALUES (4, -2147483637);

INSERT INTO "follows" ("f1", "f2") VALUES (4, -2147483636);

INSERT INTO "follows" ("f1", "f2") VALUES (1, -2147483636);

INSERT INTO "follows" ("f1", "f2") VALUES (1, -2147483639);

INSERT INTO "follows" ("f1", "f2") VALUES (1, -2147483638);

INSERT INTO "follows" ("f1", "f2") VALUES (1, -2147483637);

INSERT INTO "follows" ("f1", "f2") VALUES (1, -2147483642);

INSERT INTO "follows" ("f1", "f2") VALUES (1, 3);

INSERT INTO "follows" ("f1", "f2") VALUES (1, -2147483641);

INSERT INTO "follows" ("f1", "f2") VALUES (1, -2147483635);

INSERT INTO "follows" ("f1", "f2") VALUES (1, -2147483634);

INSERT INTO "follows" ("f1", "f2") VALUES (1, -2147483633);

INSERT INTO "follows" ("f1", "f2") VALUES (1, -2147483632);

INSERT INTO "follows" ("f1", "f2") VALUES (1, -2147483631);

INSERT INTO "follows" ("f1", "f2") VALUES (1, -2147483630);

INSERT INTO "follows" ("f1", "f2") VALUES (1, -2147483629);

INSERT INTO "follows" ("f1", "f2") VALUES (1, -2147483628);

INSERT INTO "follows" ("f1", "f2") VALUES (1, -2147483627);

INSERT INTO "follows" ("f1", "f2") VALUES (1, 4);

INSERT INTO "follows" ("f1", "f2") VALUES (1, -2147483626);

INSERT INTO "follows" ("f1", "f2") VALUES (1, -2147483625);

INSERT INTO "follows" ("f1", "f2") VALUES (1, -2147483624);

INSERT INTO "follows" ("f1", "f2") VALUES (1, -2147483623);

INSERT INTO "follows" ("f1", "f2") VALUES (1, -2147483622);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, email FROM (SELECT email, name, COUNT(*) AS n FROM (SELECT f1, f2, name, email, partitionid, followers, f1 AS UID FROM (SELECT LHS.f1 AS f1, LHS.f2 AS f2, RHS.name AS name, RHS.email AS email, RHS.partitionid AS partitionid, RHS.followers AS followers FROM follows AS LHS INNER JOIN user_profiles AS RHS ON (LHS.f1 = RHS.uid))) GROUP BY email, name) WHERE (n > 1) ORDER BY name, email NULLS LAST;

/*
Gold Result:
('t1__97f2cb', 't1__d21203')
('use_9bbfbd', 'use_dc6265')
*/

-- Prediction Query
SELECT T1.name, T1.email FROM user_profiles AS T1 JOIN follows AS T2 ON T1.uid = T2.f1 GROUP BY T2.f1 HAVING COUNT(*) > 1;

/*
Prediction Result:
('t1__97f2cb', 't1__d21203')
('t1__97f2cb', 't1__d21203')
('use_9bbfbd', 'use_dc6265')
*/