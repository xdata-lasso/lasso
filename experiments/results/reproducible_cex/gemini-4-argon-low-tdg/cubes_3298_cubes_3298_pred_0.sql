-- Schema DDL
CREATE TABLE "follows" ("f1" INTEGER(11), "f2" INTEGER(11), PRIMARY KEY ("f1", "f2"), FOREIGN KEY ("f2") REFERENCES "user_profiles" ("uid"), FOREIGN KEY ("f1") REFERENCES "user_profiles" ("uid"));

CREATE TABLE "tweets" ("id" INTEGER(20) PRIMARY KEY, "uid" INTEGER(11), "text" TEXT(140), "createdate" DATETIME, FOREIGN KEY ("uid") REFERENCES "user_profiles" ("uid"));

CREATE TABLE "user_profiles" ("uid" INTEGER(11) PRIMARY KEY, "name" TEXT(255), "email" TEXT(255), "partitionid" INTEGER(11), "followers" INTEGER(11));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 3
INSERT INTO "user_profiles" ("uid", "name", "email", "partitionid", "followers") VALUES (1, 'Mary', 'm@example.com', 1, 10);
INSERT INTO "user_profiles" ("uid", "name", "email", "partitionid", "followers") VALUES (2, 'Susan', 's@example.com', 1, 20);
INSERT INTO "user_profiles" ("uid", "name", "email", "partitionid", "followers") VALUES (5, 'Dave', 'd@example.com', 1, 30);
INSERT INTO "user_profiles" ("uid", "name", "email", "partitionid", "followers") VALUES (10, 'Eve', 'e@example.com', 1, 40);
INSERT INTO "user_profiles" ("uid", "name", "email", "partitionid", "followers") VALUES (15, 'Frank', 'f@example.com', 1, 50);
INSERT INTO "follows" ("f1", "f2") VALUES (15, 1);
INSERT INTO "follows" ("f1", "f2") VALUES (5, 2);
INSERT INTO "follows" ("f1", "f2") VALUES (10, 1);
INSERT INTO "follows" ("f1", "f2") VALUES (1, 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "f1" FROM (SELECT "f1", "f2", "name", "email", "partitionid", "followers", "f2" AS "uid" FROM (SELECT "LHS"."f1" AS "f1", "LHS"."f2" AS "f2", "RHS"."name" AS "name", "RHS"."email" AS "email", "RHS"."partitionid" AS "partitionid", "RHS"."followers" AS "followers" FROM "follows" AS "LHS" INNER JOIN "user_profiles" AS "RHS" ON ("LHS"."f2" = "RHS"."uid"))) WHERE ("name" = 'Mary' OR "name" = 'Susan') ORDER BY f1, "f1" NULLS LAST;

/*
Gold Result:
(1,)
(5,)
(10,)
(15,)
*/

-- Prediction Query
SELECT T2.f1 FROM user_profiles AS T1 JOIN follows AS T2 ON T1.uid = T2.f2 WHERE T1.name = 'Mary' OR T1.name = 'Susan';

/*
Prediction Result:
(15,)
(5,)
(10,)
(1,)
*/