-- Schema DDL
CREATE TABLE "Person" ("name" TEXT(20) PRIMARY KEY, "age" INTEGER, "city" TEXT, "gender" TEXT, "job" TEXT);

CREATE TABLE "PersonFriend" ("friend" TEXT(20), "name" TEXT(20), "year" INTEGER, FOREIGN KEY ("friend") REFERENCES "Person" ("name"), FOREIGN KEY ("name") REFERENCES "Person" ("name"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests: Reverse insertion order, NULLs in all non-PK columns, unnecessary INNER JOINs with PersonFriend, and duplicate rows from 1-to-many joins.
INSERT INTO "Person" ("name", "age", "city", "gender", "job") VALUES ('Zack', 30, 'New York', 'male', 'engineer');
INSERT INTO "Person" ("name", "age", "city", "gender", "job") VALUES ('Bob', 25, 'Chicago', 'female', 'doctor');
INSERT INTO "Person" ("name", "age", "city", "gender", "job") VALUES ('Alice', NULL, NULL, NULL, NULL);
INSERT INTO "PersonFriend" ("friend", "name", "year") VALUES ('Bob', 'Zack', 5);
INSERT INTO "PersonFriend" ("friend", "name", "year") VALUES ('Alice', 'Zack', 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM person ORDER BY name;

/*
Gold Result:
('Alice',)
('Bob',)
('Zack',)
*/

-- Prediction Query
SELECT name FROM Person ORDER BY age DESC, Person.name NULLS LAST;

/*
Prediction Result:
('Zack',)
('Bob',)
('Alice',)
*/