-- Schema DDL
CREATE TABLE "Person" ("name" TEXT(20) PRIMARY KEY, "age" INTEGER, "city" TEXT, "gender" TEXT, "job" TEXT);

CREATE TABLE "PersonFriend" ("friend" TEXT(20), "name" TEXT(20), "year" INTEGER, FOREIGN KEY ("friend") REFERENCES "Person" ("name"), FOREIGN KEY ("name") REFERENCES "Person" ("name"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic filtering (male, female, NULL, case-sensitivity) and alphabetical ordering vs insertion order vs age/city/job ordering.
-- Also tests extraneous INNER JOIN or LEFT JOIN without DISTINCT with PersonFriend.
INSERT INTO "Person" ("name", "age", "city", "gender", "job") VALUES ('Charlie', 25, 'Boston', 'male', 'Artist');
INSERT INTO "Person" ("name", "age", "city", "gender", "job") VALUES ('Alice', 20, 'New York', 'female', 'Engineer');
INSERT INTO "Person" ("name", "age", "city", "gender", "job") VALUES ('Bob', 40, 'Chicago', 'male', 'Doctor');
INSERT INTO "Person" ("name", "age", "city", "gender", "job") VALUES ('David', 30, 'Austin', NULL, 'Teacher');
INSERT INTO "Person" ("name", "age", "city", "gender", "job") VALUES ('Aaron', 35, 'Seattle', 'male', 'Nurse');
INSERT INTO "Person" ("name", "age", "city", "gender", "job") VALUES ('Eve', 22, 'Miami', 'Male', 'Lawyer');
INSERT INTO "PersonFriend" ("friend", "name", "year") VALUES ('Alice', 'Bob', 2020);
INSERT INTO "PersonFriend" ("friend", "name", "year") VALUES ('Charlie', 'Bob', 2021);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "name" FROM "person" WHERE ("gender" = 'male') ORDER BY name;

/*
Gold Result:
('Aaron',)
('Bob',)
('Charlie',)
*/

-- Prediction Query
SELECT name FROM Person WHERE gender = 'male' ORDER BY age, Person.name NULLS LAST;

/*
Prediction Result:
('Charlie',)
('Aaron',)
('Bob',)
*/