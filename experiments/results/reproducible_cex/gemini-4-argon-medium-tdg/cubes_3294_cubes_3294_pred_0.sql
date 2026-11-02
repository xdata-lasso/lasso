-- Schema DDL
CREATE TABLE "follows" ("f1" INTEGER(11), "f2" INTEGER(11), PRIMARY KEY ("f1", "f2"), FOREIGN KEY ("f2") REFERENCES "user_profiles" ("uid"), FOREIGN KEY ("f1") REFERENCES "user_profiles" ("uid"));

CREATE TABLE "tweets" ("id" INTEGER(20) PRIMARY KEY, "uid" INTEGER(11), "text" TEXT(140), "createdate" DATETIME, FOREIGN KEY ("uid") REFERENCES "user_profiles" ("uid"));

CREATE TABLE "user_profiles" ("uid" INTEGER(11) PRIMARY KEY, "name" TEXT(255), "email" TEXT(255), "partitionid" INTEGER(11), "followers" INTEGER(11));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic filtering, case sensitivity, substring matching, whitespace, NULL names, sorting by email, duplicate emails (testing DISTINCT mutants), and NULL emails.
INSERT INTO "user_profiles" ("uid", "name", "email", "partitionid", "followers") VALUES (10, 'Mary', 'z@example.com', 1, 100);
INSERT INTO "user_profiles" ("uid", "name", "email", "partitionid", "followers") VALUES (5, 'Mary', 'a@example.com', 1, 200);
INSERT INTO "user_profiles" ("uid", "name", "email", "partitionid", "followers") VALUES (8, 'Mary', 'a@example.com', 2, 50);
INSERT INTO "user_profiles" ("uid", "name", "email", "partitionid", "followers") VALUES (12, 'Mary', NULL, 1, 10);
INSERT INTO "user_profiles" ("uid", "name", "email", "partitionid", "followers") VALUES (1, 'mary', 'lower@example.com', 1, 10);
INSERT INTO "user_profiles" ("uid", "name", "email", "partitionid", "followers") VALUES (2, 'Mary ', 'space@example.com', 1, 10);
INSERT INTO "user_profiles" ("uid", "name", "email", "partitionid", "followers") VALUES (3, 'Maryanne', 'prefix@example.com', 1, 10);
INSERT INTO "user_profiles" ("uid", "name", "email", "partitionid", "followers") VALUES (4, 'John', 'john@example.com', 1, 10);
INSERT INTO "user_profiles" ("uid", "name", "email", "partitionid", "followers") VALUES (6, NULL, 'nullname@example.com', 1, 10);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "email" FROM "user_profiles" WHERE ("name" = 'Mary') ORDER BY email, user_profiles.uid NULLS LAST;

/*
Gold Result:
(None,)
('a@example.com',)
('a@example.com',)
('z@example.com',)
*/

-- Prediction Query
SELECT email FROM user_profiles WHERE name = 'Mary';

/*
Prediction Result:
('z@example.com',)
('a@example.com',)
('a@example.com',)
(None,)
*/