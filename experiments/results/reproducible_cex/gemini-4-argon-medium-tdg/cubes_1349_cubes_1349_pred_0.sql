-- Schema DDL
CREATE TABLE "Person" ("name" TEXT(20) PRIMARY KEY, "age" INTEGER, "city" TEXT, "gender" TEXT, "job" TEXT);

CREATE TABLE "PersonFriend" ("friend" TEXT(20), "name" TEXT(20), "year" INTEGER, FOREIGN KEY ("friend") REFERENCES "Person" ("name"), FOREIGN KEY ("name") REFERENCES "Person" ("name"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "Person" ("name", "age", "city", "gender", "job") VALUES ('Alice', 20, 'NY', 'F', 'Dev');
INSERT INTO "Person" ("name", "age", "city", "gender", "job") VALUES ('Bob', 23, 'LA', 'F', 'QA');
INSERT INTO "Person" ("name", "age", "city", "gender", "job") VALUES ('Charlie', 23, 'NY', 'F', 'Dev');
INSERT INTO "Person" ("name", "age", "city", "gender", "job") VALUES ('David', 10, 'SF', 'M', 'PM');
INSERT INTO "Person" ("name", "age", "city", "gender", "job") VALUES ('Eve', 15, 'SF', 'M', 'PM');
INSERT INTO "Person" ("name", "age", "city", "gender", "job") VALUES ('Frank', 50, 'LA', 'O', 'CEO');
INSERT INTO "PersonFriend" ("friend", "name", "year") VALUES ('Bob', 'Alice', 2020);
INSERT INTO "PersonFriend" ("friend", "name", "year") VALUES ('Charlie', 'Alice', 2021);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT meanage AS avg_age_, gender FROM (SELECT gender, AVG(age) AS meanage FROM person GROUP BY gender) ORDER BY avg_age_, gender NULLS LAST;

/*
Gold Result:
(12.5, 'M')
(22.0, 'F')
(50.0, 'O')
*/

-- Prediction Query
SELECT AVG(age), gender FROM Person GROUP BY gender;

/*
Prediction Result:
(22.0, 'F')
(12.5, 'M')
(50.0, 'O')
*/