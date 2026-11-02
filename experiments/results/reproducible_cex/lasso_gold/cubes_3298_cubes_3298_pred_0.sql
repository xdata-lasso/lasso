-- Schema DDL
CREATE TABLE "follows" ("f1" INTEGER(11), "f2" INTEGER(11), PRIMARY KEY ("f1", "f2"), FOREIGN KEY ("f2") REFERENCES "user_profiles" ("uid"), FOREIGN KEY ("f1") REFERENCES "user_profiles" ("uid"));

CREATE TABLE "tweets" ("id" INTEGER(20) PRIMARY KEY, "uid" INTEGER(11), "text" TEXT(140), "createdate" DATETIME, FOREIGN KEY ("uid") REFERENCES "user_profiles" ("uid"));

CREATE TABLE "user_profiles" ("uid" INTEGER(11) PRIMARY KEY, "name" TEXT(255), "email" TEXT(255), "partitionid" INTEGER(11), "followers" INTEGER(11));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "user_profiles" ("uid", "name", "email", "partitionid", "followers") VALUES (1147, 'Mary', 'briannasmith@example.net', 1149, 1151);
INSERT INTO "user_profiles" ("uid", "name", "email", "partitionid", "followers") VALUES (1148, 'Susan', 'perezrebecca@example.com', 1158.0, 1162.0);
INSERT INTO "user_profiles" ("uid", "name", "email", "partitionid", "followers") VALUES (1154, 'Mary', 'palmerjoshua@example.com', 1156, 1158);
INSERT INTO "user_profiles" ("uid", "name", "email", "partitionid", "followers") VALUES (1155, 'Susan', 'ambercummings@example.net', 1165.0, 1169.0);
INSERT INTO "user_profiles" ("uid", "name", "email", "partitionid", "followers") VALUES (1160, NULL, NULL, NULL, NULL);
INSERT INTO "user_profiles" ("uid", "name", "email", "partitionid", "followers") VALUES (1153, NULL, NULL, NULL, NULL);
INSERT INTO "follows" ("f1", "f2") VALUES (1160, 1147);
INSERT INTO "follows" ("f1", "f2") VALUES (1153, 1154);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "f1" FROM (SELECT "f1", "f2", "name", "email", "partitionid", "followers", "f2" AS "uid" FROM (SELECT "LHS"."f1" AS "f1", "LHS"."f2" AS "f2", "RHS"."name" AS "name", "RHS"."email" AS "email", "RHS"."partitionid" AS "partitionid", "RHS"."followers" AS "followers" FROM "follows" AS "LHS" INNER JOIN "user_profiles" AS "RHS" ON ("LHS"."f2" = "RHS"."uid"))) WHERE ("name" = 'Mary' OR "name" = 'Susan') ORDER BY f1, "f1" NULLS LAST;

/*
Gold Result:
(1153,)
(1160,)
*/

-- Prediction Query
SELECT T2.f1 FROM user_profiles AS T1 JOIN follows AS T2 ON T1.uid = T2.f2 WHERE T1.name = 'Mary' OR T1.name = 'Susan';

/*
Prediction Result:
(1160,)
(1153,)
*/