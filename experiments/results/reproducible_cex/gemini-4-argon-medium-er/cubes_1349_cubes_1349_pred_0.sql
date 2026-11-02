-- Schema DDL
CREATE TABLE "Person" ("name" TEXT(20) PRIMARY KEY, "age" INTEGER, "city" TEXT, "gender" TEXT, "job" TEXT);

CREATE TABLE "PersonFriend" ("friend" TEXT(20), "name" TEXT(20), "year" INTEGER, FOREIGN KEY ("friend") REFERENCES "Person" ("name"), FOREIGN KEY ("name") REFERENCES "Person" ("name"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Person" ("name", "age", "city", "gender", "job") VALUES ('Alice', 30, 'NY', 'F', 'Dev');
INSERT INTO "Person" ("name", "age", "city", "gender", "job") VALUES ('Bob', 20, 'LA', 'M', 'QA');
INSERT INTO "Person" ("name", "age", "city", "gender", "job") VALUES ('Charlie', 40, 'SF', NULL, 'PM');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT meanage AS avg_age_, gender FROM (SELECT gender, AVG(age) AS meanage FROM person GROUP BY gender) ORDER BY avg_age_, gender NULLS LAST;

/*
Gold Result:
(20.0, 'M')
(30.0, 'F')
(40.0, None)
*/

-- Prediction Query
SELECT AVG(age), gender FROM Person GROUP BY gender;

/*
Prediction Result:
(40.0, None)
(30.0, 'F')
(20.0, 'M')
*/