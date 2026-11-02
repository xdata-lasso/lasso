-- Schema DDL
CREATE TABLE "Person" ("name" TEXT(20) PRIMARY KEY, "age" INTEGER, "city" TEXT, "gender" TEXT, "job" TEXT);

CREATE TABLE "PersonFriend" ("friend" TEXT(20), "name" TEXT(20), "year" INTEGER, FOREIGN KEY ("friend") REFERENCES "Person" ("name"), FOREIGN KEY ("name") REFERENCES "Person" ("name"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "person" ("name", "age", "city", "gender", "job") VALUES ('Patricia Galloway', 1004, 'Port Craig', 'fall', 'Professor Emeritus');
INSERT INTO "person" ("name", "age", "city", "gender", "job") VALUES ('Holly Wood', NULL, 'Lake Joseph', 'write', 'Building surveyor');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT meanage AS avg_age_, gender FROM (SELECT gender, AVG(age) AS meanage FROM person GROUP BY gender) ORDER BY avg_age_, gender NULLS LAST;

/*
Gold Result:
(None, 'write')
(1004.0, 'fall')
*/

-- Prediction Query
SELECT AVG(age), gender FROM Person GROUP BY gender;

/*
Prediction Result:
(1004.0, 'fall')
(None, 'write')
*/