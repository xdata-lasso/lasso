-- Schema DDL
CREATE TABLE "Person" ("name" TEXT(20) PRIMARY KEY, "age" INTEGER, "city" TEXT, "gender" TEXT, "job" TEXT);

CREATE TABLE "PersonFriend" ("friend" TEXT(20), "name" TEXT(20), "year" INTEGER, FOREIGN KEY ("friend") REFERENCES "Person" ("name"), FOREIGN KEY ("name") REFERENCES "Person" ("name"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Person" ("name", "age", "city", "gender", "job") VALUES ('6', NULL, '9', '8', '9');
INSERT INTO "Person" ("name", "age", "city", "gender", "job") VALUES ('5', NULL, '9', NULL, '9');
INSERT INTO "PersonFriend" ("friend", "name", "year") VALUES ('6', '5', 9);
INSERT INTO "PersonFriend" ("friend", "name", "year") VALUES ('5', '6', 9);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT meanage AS avg_age_, job FROM (SELECT gender, job, AVG(age) AS meanage FROM person GROUP BY gender, job) ORDER BY avg_age_, job NULLS LAST;

/*
Gold Result:
(None, '9')
(None, '9')
*/

-- Prediction Query
SELECT AVG(age), job FROM Person GROUP BY job;

/*
Prediction Result:
(None, '9')
*/