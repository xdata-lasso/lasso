-- Schema DDL
CREATE TABLE "follows" ("f1" INTEGER(11), "f2" INTEGER(11), PRIMARY KEY ("f1", "f2"), FOREIGN KEY ("f2") REFERENCES "user_profiles" ("uid"), FOREIGN KEY ("f1") REFERENCES "user_profiles" ("uid"));

CREATE TABLE "tweets" ("id" INTEGER(20) PRIMARY KEY, "uid" INTEGER(11), "text" TEXT(140), "createdate" DATETIME, FOREIGN KEY ("uid") REFERENCES "user_profiles" ("uid"));

CREATE TABLE "user_profiles" ("uid" INTEGER(11) PRIMARY KEY, "name" TEXT(255), "email" TEXT(255), "partitionid" INTEGER(11), "followers" INTEGER(11));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "user_profiles" ("uid", "name", "email", "partitionid", "followers") VALUES (1, 'Mary', 'mary@test.com', 1, 100);
INSERT INTO "user_profiles" ("uid", "name", "email", "partitionid", "followers") VALUES (2, 'Susan', 'susan@test.com', 1, 200);
INSERT INTO "user_profiles" ("uid", "name", "email", "partitionid", "followers") VALUES (3, 'John', 'john@test.com', 2, 50);
INSERT INTO "user_profiles" ("uid", "name", "email", "partitionid", "followers") VALUES (4, 'Alice', 'alice@test.com', 2, 300);
INSERT INTO "user_profiles" ("uid", "name", "email", "partitionid", "followers") VALUES (5, 'Bob', 'bob@test.com', 3, 10);
INSERT INTO "follows" ("f1", "f2") VALUES (3, 1);
INSERT INTO "follows" ("f1", "f2") VALUES (4, 2);
INSERT INTO "follows" ("f1", "f2") VALUES (3, 2);
INSERT INTO "follows" ("f1", "f2") VALUES (1, 5);
INSERT INTO "follows" ("f1", "f2") VALUES (2, 5);
INSERT INTO "follows" ("f1", "f2") VALUES (5, 4);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "f1" FROM (SELECT "f1", "f2", "name", "email", "partitionid", "followers", "f2" AS "uid" FROM (SELECT "LHS"."f1" AS "f1", "LHS"."f2" AS "f2", "RHS"."name" AS "name", "RHS"."email" AS "email", "RHS"."partitionid" AS "partitionid", "RHS"."followers" AS "followers" FROM "follows" AS "LHS" INNER JOIN "user_profiles" AS "RHS" ON ("LHS"."f2" = "RHS"."uid"))) WHERE ("name" = 'Mary' OR "name" = 'Susan') ORDER BY f1, "f1" NULLS LAST;

/*
Gold Result:
(3,)
(3,)
(4,)
*/

-- Prediction Query
SELECT T2.f1 FROM user_profiles AS T1 JOIN follows AS T2 ON T1.uid = T2.f2 WHERE T1.name = 'Mary' OR T1.name = 'Susan';

/*
Prediction Result:
(3,)
(4,)
(3,)
*/