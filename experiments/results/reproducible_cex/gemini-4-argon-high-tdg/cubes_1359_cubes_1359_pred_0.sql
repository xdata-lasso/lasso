-- Schema DDL
CREATE TABLE "Person" ("name" TEXT(20) PRIMARY KEY, "age" INTEGER, "city" TEXT, "gender" TEXT, "job" TEXT);

CREATE TABLE "PersonFriend" ("friend" TEXT(20), "name" TEXT(20), "year" INTEGER, FOREIGN KEY ("friend") REFERENCES "Person" ("name"), FOREIGN KEY ("name") REFERENCES "Person" ("name"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "Person" ("name", "age", "city", "gender", "job") VALUES ('p1', 20, 'NY', 'male', 'engineer');
INSERT INTO "Person" ("name", "age", "city", "gender", "job") VALUES ('p2', 20, 'LA', 'male', 'engineer');
INSERT INTO "Person" ("name", "age", "city", "gender", "job") VALUES ('p3', 50, 'SF', 'male', 'engineer');
INSERT INTO "Person" ("name", "age", "city", "gender", "job") VALUES ('p4', 100, 'NY', 'female', 'engineer');
INSERT INTO "Person" ("name", "age", "city", "gender", "job") VALUES ('p5', 30, 'Boston', 'male', 'baker');
INSERT INTO "Person" ("name", "age", "city", "gender", "job") VALUES ('p6', 30, 'Chicago', 'male', 'actor');
INSERT INTO "Person" ("name", "age", "city", "gender", "job") VALUES ('p7', 30, 'Seattle', 'male', NULL);
INSERT INTO "Person" ("name", "age", "city", "gender", "job") VALUES ('p8', 25, 'Miami', 'female', 'doctor');
INSERT INTO "PersonFriend" ("friend", "name", "year") VALUES ('p2', 'p1', 2015);
INSERT INTO "PersonFriend" ("friend", "name", "year") VALUES ('p3', 'p1', 2018);
INSERT INTO "PersonFriend" ("friend", "name", "year") VALUES ('p4', 'p1', 2020);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "meanage" AS "avg_age_", "job" FROM (SELECT "gender", "job", AVG("age") AS "meanage" FROM "person" GROUP BY "gender", "job") WHERE ("gender" = 'male') ORDER BY avg_age_, "job" NULLS LAST;

/*
Gold Result:
(30.0, 'actor')
(30.0, 'baker')
(30.0, 'engineer')
(30.0, None)
*/

-- Prediction Query
SELECT AVG(age), job FROM Person WHERE gender = 'male' GROUP BY job;

/*
Prediction Result:
(30.0, None)
(30.0, 'actor')
(30.0, 'baker')
(30.0, 'engineer')
*/