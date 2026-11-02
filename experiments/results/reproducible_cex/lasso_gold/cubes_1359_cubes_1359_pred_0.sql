-- Schema DDL
CREATE TABLE "Person" ("name" TEXT(20) PRIMARY KEY, "age" INTEGER, "city" TEXT, "gender" TEXT, "job" TEXT);

CREATE TABLE "PersonFriend" ("friend" TEXT(20), "name" TEXT(20), "year" INTEGER, FOREIGN KEY ("friend") REFERENCES "Person" ("name"), FOREIGN KEY ("name") REFERENCES "Person" ("name"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "person" ("name", "age", "city", "gender", "job") VALUES ('Matthew Mejia', 1004, 'Port Jesseville', 'male', 'Museum/gallery conservator');
INSERT INTO "person" ("name", "age", "city", "gender", "job") VALUES ('Mark Diaz', NULL, 'Michaelview', 'male', 'Building surveyor');
INSERT INTO "person" ("name", "age", "city", "gender", "job") VALUES ('Carolyn Daniel', 1006, 'South Noah', 'male', 'Building surveyor');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "meanage" AS "avg_age_", "job" FROM (SELECT "gender", "job", AVG("age") AS "meanage" FROM "person" GROUP BY "gender", "job") WHERE ("gender" = 'male') ORDER BY avg_age_, "job" NULLS LAST;

/*
Gold Result:
(1004.0, 'Museum/gallery conservator')
(1006.0, 'Building surveyor')
*/

-- Prediction Query
SELECT AVG(age), job FROM Person WHERE gender = 'male' GROUP BY job;

/*
Prediction Result:
(1006.0, 'Building surveyor')
(1004.0, 'Museum/gallery conservator')
*/