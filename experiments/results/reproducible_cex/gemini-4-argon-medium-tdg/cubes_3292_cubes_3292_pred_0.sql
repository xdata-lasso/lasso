-- Schema DDL
CREATE TABLE "follows" ("f1" INTEGER(11), "f2" INTEGER(11), PRIMARY KEY ("f1", "f2"), FOREIGN KEY ("f2") REFERENCES "user_profiles" ("uid"), FOREIGN KEY ("f1") REFERENCES "user_profiles" ("uid"));

CREATE TABLE "tweets" ("id" INTEGER(20) PRIMARY KEY, "uid" INTEGER(11), "text" TEXT(140), "createdate" DATETIME, FOREIGN KEY ("uid") REFERENCES "user_profiles" ("uid"));

CREATE TABLE "user_profiles" ("uid" INTEGER(11) PRIMARY KEY, "name" TEXT(255), "email" TEXT(255), "partitionid" INTEGER(11), "followers" INTEGER(11));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "user_profiles" ("uid", "name", "email", "partitionid", "followers") VALUES (30, 'Iron Man', 'tony1@stark.com', 1, 100);
INSERT INTO "user_profiles" ("uid", "name", "email", "partitionid", "followers") VALUES (10, 'Iron Man', 'tony2@stark.com', 3, 200);
INSERT INTO "user_profiles" ("uid", "name", "email", "partitionid", "followers") VALUES (20, 'Iron Man', 'tony3@stark.com', 2, 150);
INSERT INTO "user_profiles" ("uid", "name", "email", "partitionid", "followers") VALUES (15, 'iron man', 'lower@stark.com', 4, 50);
INSERT INTO "user_profiles" ("uid", "name", "email", "partitionid", "followers") VALUES (25, 'Iron Man ', 'space@stark.com', 5, 60);
INSERT INTO "user_profiles" ("uid", "name", "email", "partitionid", "followers") VALUES (35, 'Captain America', 'cap@avengers.com', 1, 300);
INSERT INTO "user_profiles" ("uid", "name", "email", "partitionid", "followers") VALUES (40, NULL, 'null@stark.com', 1, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "uid" AS "partitionid" FROM "user_profiles" WHERE ("name" = 'Iron Man') ORDER BY partitionid, user_profiles.uid NULLS LAST;

/*
Gold Result:
(10,)
(20,)
(30,)
*/

-- Prediction Query
SELECT partitionid FROM user_profiles WHERE name = 'Iron Man';

/*
Prediction Result:
(1,)
(3,)
(2,)
*/