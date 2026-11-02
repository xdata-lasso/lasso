-- Schema DDL
CREATE TABLE "Person" ("name" TEXT(20) PRIMARY KEY, "age" INTEGER, "city" TEXT, "gender" TEXT, "job" TEXT);

CREATE TABLE "PersonFriend" ("friend" TEXT(20), "name" TEXT(20), "year" INTEGER, FOREIGN KEY ("friend") REFERENCES "Person" ("name"), FOREIGN KEY ("name") REFERENCES "Person" ("name"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Person (name, age, city, gender, job) VALUES ('Zoe', 25, 'Boston', 'F', 'Doctor');
INSERT INTO Person (name, age, city, gender, job) VALUES ('Alice', 30, 'Chicago', 'M', 'Artist');
INSERT INTO Person (name, age, city, gender, job) VALUES ('David', 20, 'Austin', 'F', 'Engineer');
INSERT INTO Person (name, age, city, gender, job) VALUES ('Bob', 40, 'Denver', 'M', 'Chef');
INSERT INTO PersonFriend (friend, name, year) VALUES ('Bob', 'Alice', 2020);
INSERT INTO PersonFriend (friend, name, year) VALUES ('David', 'Alice', 2021);
INSERT INTO PersonFriend (friend, name, year) VALUES ('Alice', 'Bob', 2019);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM person ORDER BY name;

/*
Gold Result:
('Alice',)
('Bob',)
('David',)
('Zoe',)
*/

-- Prediction Query
SELECT name FROM Person ORDER BY age DESC, Person.name NULLS LAST;

/*
Prediction Result:
('Bob',)
('Alice',)
('Zoe',)
('David',)
*/