-- Schema DDL
CREATE TABLE "follows" ("f1" INTEGER(11), "f2" INTEGER(11), PRIMARY KEY ("f1", "f2"), FOREIGN KEY ("f2") REFERENCES "user_profiles" ("uid"), FOREIGN KEY ("f1") REFERENCES "user_profiles" ("uid"));

CREATE TABLE "tweets" ("id" INTEGER(20) PRIMARY KEY, "uid" INTEGER(11), "text" TEXT(140), "createdate" DATETIME, FOREIGN KEY ("uid") REFERENCES "user_profiles" ("uid"));

CREATE TABLE "user_profiles" ("uid" INTEGER(11) PRIMARY KEY, "name" TEXT(255), "email" TEXT(255), "partitionid" INTEGER(11), "followers" INTEGER(11));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "follows" ("f1", "f2") VALUES (7, 7);
INSERT INTO "follows" ("f1", "f2") VALUES (8, 8);
INSERT INTO "tweets" ("id", "uid", "text", "createdate") VALUES (10, 8, 'Iron Man8', 8);
INSERT INTO "tweets" ("id", "uid", "text", "createdate") VALUES (9, 8, 'Iron Man8', 8);
INSERT INTO "user_profiles" ("uid", "name", "email", "partitionid", "followers") VALUES (7, NULL, 'Iron Man8', 8, 8);
INSERT INTO "user_profiles" ("uid", "name", "email", "partitionid", "followers") VALUES (8, 'Iron Man', 'Iron Man11', NULL, 12);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "uid" AS "partitionid" FROM "user_profiles" WHERE ("name" = 'Iron Man') ORDER BY partitionid, user_profiles.uid NULLS LAST;

/*
Gold Result:
(8,)
*/

-- Prediction Query
SELECT partitionid FROM user_profiles WHERE name = 'Iron Man';

/*
Prediction Result:
(None,)
*/