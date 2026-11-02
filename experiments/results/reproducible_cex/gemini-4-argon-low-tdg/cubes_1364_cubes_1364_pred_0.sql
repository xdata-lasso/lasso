-- Schema DDL
CREATE TABLE "Person" ("name" TEXT(20) PRIMARY KEY, "age" INTEGER, "city" TEXT, "gender" TEXT, "job" TEXT);

CREATE TABLE "PersonFriend" ("friend" TEXT(20), "name" TEXT(20), "year" INTEGER, FOREIGN KEY ("friend") REFERENCES "Person" ("name"), FOREIGN KEY ("name") REFERENCES "Person" ("name"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "Person" ("name", "age", "city", "gender", "job") VALUES ('Charlie', 35, 'Chicago', 'M', 'Doctor');
INSERT INTO "Person" ("name", "age", "city", "gender", "job") VALUES ('Alice', 28, 'New York', 'F', 'Engineer');
INSERT INTO "Person" ("name", "age", "city", "gender", "job") VALUES ('Bob', 42, 'Los Angeles', 'M', 'Artist');
INSERT INTO "PersonFriend" ("friend", "name", "year") VALUES ('Alice', 'Bob', 2018);
INSERT INTO "PersonFriend" ("friend", "name", "year") VALUES ('Bob', 'Alice', 2018);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM person ORDER BY name;

/*
Gold Result:
('Alice',)
('Bob',)
('Charlie',)
*/

-- Prediction Query
SELECT name FROM Person ORDER BY age DESC, Person.name NULLS LAST;

/*
Prediction Result:
('Bob',)
('Charlie',)
('Alice',)
*/