-- Schema DDL
CREATE TABLE "Person" ("name" TEXT(20) PRIMARY KEY, "age" INTEGER, "city" TEXT, "gender" TEXT, "job" TEXT);

CREATE TABLE "PersonFriend" ("friend" TEXT(20), "name" TEXT(20), "year" INTEGER, FOREIGN KEY ("friend") REFERENCES "Person" ("name"), FOREIGN KEY ("name") REFERENCES "Person" ("name"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "Person" ("name", "age", "city", "gender", "job") VALUES ('Zach', 25, 'Austin', 'M', 'engineer');
INSERT INTO "Person" ("name", "age", "city", "gender", "job") VALUES ('Alice', 40, 'Boston', 'F', 'doctor');
INSERT INTO "Person" ("name", "age", "city", "gender", "job") VALUES ('Bob', 40, 'Chicago', 'M', 'doctor');
INSERT INTO "Person" ("name", "age", "city", "gender", "job") VALUES ('Charlie', 30, 'Denver', 'M', 'lawyer');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "age" FROM "person" WHERE ("job" = 'doctor' OR "name" = 'Zach') ORDER BY age, person.name NULLS LAST;

/*
Gold Result:
(25,)
(40,)
(40,)
*/

-- Prediction Query
SELECT age FROM Person WHERE job = 'doctor' AND name = 'Zach';

/*
Prediction Result:
*/