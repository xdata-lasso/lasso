-- Schema DDL
CREATE TABLE "follows" ("f1" INTEGER(11), "f2" INTEGER(11), PRIMARY KEY ("f1", "f2"), FOREIGN KEY ("f2") REFERENCES "user_profiles" ("uid"), FOREIGN KEY ("f1") REFERENCES "user_profiles" ("uid"));

CREATE TABLE "tweets" ("id" INTEGER(20) PRIMARY KEY, "uid" INTEGER(11), "text" TEXT(140), "createdate" DATETIME, FOREIGN KEY ("uid") REFERENCES "user_profiles" ("uid"));

CREATE TABLE "user_profiles" ("uid" INTEGER(11) PRIMARY KEY, "name" TEXT(255), "email" TEXT(255), "partitionid" INTEGER(11), "followers" INTEGER(11));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests column aliasing vs table column confusion (uid vs partitionid vs followers),
-- ORDER BY ambiguity resolution (alias 'partitionid' resolves to uid, vs user_profiles.partitionid),
-- and basic WHERE filtering (including case sensitivity, partial matches, and NULLs).
INSERT INTO "user_profiles" ("uid", "name", "email", "partitionid", "followers") VALUES (30, 'Iron Man', 'tony1@stark.com', 10, 100);
INSERT INTO "user_profiles" ("uid", "name", "email", "partitionid", "followers") VALUES (10, 'Iron Man', 'tony2@stark.com', 30, 200);
INSERT INTO "user_profiles" ("uid", "name", "email", "partitionid", "followers") VALUES (20, 'Iron Man', 'tony3@stark.com', 20, 300);
INSERT INTO "user_profiles" ("uid", "name", "email", "partitionid", "followers") VALUES (40, 'iron man', 'lower@stark.com', 5, 400);
INSERT INTO "user_profiles" ("uid", "name", "email", "partitionid", "followers") VALUES (50, 'Iron Man ', 'trailing@stark.com', 1, 500);
INSERT INTO "user_profiles" ("uid", "name", "email", "partitionid", "followers") VALUES (60, 'Captain America', 'Iron Man', 2, 600);
INSERT INTO "user_profiles" ("uid", "name", "email", "partitionid", "followers") VALUES (70, NULL, 'null@stark.com', 3, 700);
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
(10,)
(30,)
(20,)
*/