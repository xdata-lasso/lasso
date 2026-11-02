-- Schema DDL
CREATE TABLE "follows" ("f1" INTEGER(11), "f2" INTEGER(11), PRIMARY KEY ("f1", "f2"), FOREIGN KEY ("f2") REFERENCES "user_profiles" ("uid"), FOREIGN KEY ("f1") REFERENCES "user_profiles" ("uid"));

CREATE TABLE "tweets" ("id" INTEGER(20) PRIMARY KEY, "uid" INTEGER(11), "text" TEXT(140), "createdate" DATETIME, FOREIGN KEY ("uid") REFERENCES "user_profiles" ("uid"));

CREATE TABLE "user_profiles" ("uid" INTEGER(11) PRIMARY KEY, "name" TEXT(255), "email" TEXT(255), "partitionid" INTEGER(11), "followers" INTEGER(11));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: user_profiles --
INSERT INTO "user_profiles" ("uid", "name", "email", "partitionid", "followers") VALUES (-2147483648, 'use_9bbfbd', 'use_dc6265', -55602865, 1);

INSERT INTO "user_profiles" ("uid", "name", "email", "partitionid", "followers") VALUES (-2147483647, 'use_9bbfbd', 'use_dc6265', -59984348, 7719);

INSERT INTO "user_profiles" ("uid", "name", "email", "partitionid", "followers") VALUES (1, 'rhs_297b45', 'rhs_318482', 1, 0);

INSERT INTO "user_profiles" ("uid", "name", "email", "partitionid", "followers") VALUES (-2147483645, 'use_9bbfbd', 'use_dc6265', -664303813, 1);

INSERT INTO "user_profiles" ("uid", "name", "email", "partitionid", "followers") VALUES (-2147483644, 'use_9bbfbd', 'use_dc6265', -1022641847, 1);

INSERT INTO "user_profiles" ("uid", "name", "email", "partitionid", "followers") VALUES (-2147483643, 'use_9bbfbd', 'use_dc6265', -1726781632, 0);

INSERT INTO "user_profiles" ("uid", "name", "email", "partitionid", "followers") VALUES (-2147483642, 'use_9bbfbd', 'use_dc6265', 247012447, 7719);

INSERT INTO "user_profiles" ("uid", "name", "email", "partitionid", "followers") VALUES (-2147483641, 'use_9bbfbd', 'use_dc6265', -1980249628, 1);

INSERT INTO "user_profiles" ("uid", "name", "email", "partitionid", "followers") VALUES (-2147483640, 'use_9bbfbd', 'use_dc6265', -734455130, NULL);

INSERT INTO "user_profiles" ("uid", "name", "email", "partitionid", "followers") VALUES (-2147483639, 'use_9bbfbd', 'use_dc6265', 1744686505, NULL);

INSERT INTO "user_profiles" ("uid", "name", "email", "partitionid", "followers") VALUES (-2147483638, 'use_9bbfbd', 'use_dc6265', NULL, 1);

INSERT INTO "user_profiles" ("uid", "name", "email", "partitionid", "followers") VALUES (-2147483637, 'use_9bbfbd', 'use_dc6265', NULL, NULL);

INSERT INTO "user_profiles" ("uid", "name", "email", "partitionid", "followers") VALUES (-2147483636, 'use_9bbfbd', 'use_dc6265', NULL, NULL);

INSERT INTO "user_profiles" ("uid", "name", "email", "partitionid", "followers") VALUES (-2147483635, 'use_9bbfbd', 'use_dc6265', -1633151678, NULL);

INSERT INTO "user_profiles" ("uid", "name", "email", "partitionid", "followers") VALUES (-2147483634, 'use_9bbfbd', 'use_dc6265', -252690330, NULL);

INSERT INTO "user_profiles" ("uid", "name", "email", "partitionid", "followers") VALUES (-2147483633, 'use_9bbfbd', 'use_dc6265', 1115440883, NULL);

INSERT INTO "user_profiles" ("uid", "name", "email", "partitionid", "followers") VALUES (-2147483632, NULL, 'use_dc6265', 1644814318, 1);

INSERT INTO "user_profiles" ("uid", "name", "email", "partitionid", "followers") VALUES (-2147483631, NULL, 'use_dc6265', 1465859724, NULL);

INSERT INTO "user_profiles" ("uid", "name", "email", "partitionid", "followers") VALUES (-2147483630, NULL, 'use_dc6265', -1349201381, NULL);

INSERT INTO "user_profiles" ("uid", "name", "email", "partitionid", "followers") VALUES (-2147483629, 'use_9bbfbd', NULL, 1019800248, 1);

INSERT INTO "user_profiles" ("uid", "name", "email", "partitionid", "followers") VALUES (-2147483628, 'use_9bbfbd', NULL, -1910425938, NULL);

INSERT INTO "user_profiles" ("uid", "name", "email", "partitionid", "followers") VALUES (-2147483627, 'use_9bbfbd', NULL, -845863578, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, email FROM (SELECT LHS.followers AS followers, RHS.uid AS UID, RHS.name AS name, RHS.email AS email, RHS.partitionid AS partitionid, RHS.followers AS followers_other FROM (SELECT MIN(followers) AS followers FROM user_profiles) AS LHS CROSS JOIN user_profiles AS RHS) WHERE (followers >= followers_other) ORDER BY name, email NULLS LAST;

/*
Gold Result:
('rhs_297b45', 'rhs_318482')
('use_9bbfbd', 'use_dc6265')
*/

-- Prediction Query
SELECT name, email FROM user_profiles ORDER BY followers, user_profiles.uid NULLS LAST LIMIT 1;

/*
Prediction Result:
('use_9bbfbd', 'use_dc6265')
*/