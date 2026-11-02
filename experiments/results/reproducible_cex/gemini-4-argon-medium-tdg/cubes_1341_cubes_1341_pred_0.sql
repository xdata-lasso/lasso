-- Schema DDL
CREATE TABLE "Person" ("name" TEXT(20) PRIMARY KEY, "age" INTEGER, "city" TEXT, "gender" TEXT, "job" TEXT);

CREATE TABLE "PersonFriend" ("friend" TEXT(20), "name" TEXT(20), "year" INTEGER, FOREIGN KEY ("friend") REFERENCES "Person" ("name"), FOREIGN KEY ("name") REFERENCES "Person" ("name"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "Person" ("name", "age", "city", "gender", "job") VALUES ('Zach', 30, 'Boston', 'M', 'engineer');
INSERT INTO "Person" ("name", "age", "city", "gender", "job") VALUES ('Alice', 45, 'New York', 'F', 'doctor');
INSERT INTO "Person" ("name", "age", "city", "gender", "job") VALUES ('Bob', 25, 'Chicago', 'M', 'teacher');
INSERT INTO "Person" ("name", "age", "city", "gender", "job") VALUES ('Charlie', 50, 'Seattle', 'M', 'Doctor');
INSERT INTO "Person" ("name", "age", "city", "gender", "job") VALUES ('zach', 22, 'Austin', 'M', 'artist');
INSERT INTO "PersonFriend" ("friend", "name", "year") VALUES ('Alice', 'Bob', 2018);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "age" FROM "person" WHERE ("job" = 'doctor' OR "name" = 'Zach') ORDER BY age, person.name NULLS LAST;

/*
Gold Result:
(30,)
(45,)
*/

-- Prediction Query
SELECT age FROM Person WHERE job = 'doctor' AND name = 'Zach';

/*
Prediction Result:
*/