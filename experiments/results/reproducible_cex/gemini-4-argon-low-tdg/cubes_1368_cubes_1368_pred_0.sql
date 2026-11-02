-- Schema DDL
CREATE TABLE "Person" ("name" TEXT(20) PRIMARY KEY, "age" INTEGER, "city" TEXT, "gender" TEXT, "job" TEXT);

CREATE TABLE "PersonFriend" ("friend" TEXT(20), "name" TEXT(20), "year" INTEGER, FOREIGN KEY ("friend") REFERENCES "Person" ("name"), FOREIGN KEY ("name") REFERENCES "Person" ("name"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Person (name, age, city, gender, job) VALUES ('Charlie', 29, 'New York', 'M', 'Engineer');
INSERT INTO Person (name, age, city, gender, job) VALUES ('Alice', 25, 'Boston', 'F', 'Doctor');
INSERT INTO Person (name, age, city, gender, job) VALUES ('Bob', 30, 'Chicago', 'M', 'Artist');
INSERT INTO Person (name, age, city, gender, job) VALUES ('David', 31, 'Seattle', 'M', 'Teacher');
INSERT INTO Person (name, age, city, gender, job) VALUES ('Eve', NULL, 'Austin', 'F', 'Lawyer');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM person WHERE (age < 30) ORDER BY name;

/*
Gold Result:
('Alice',)
('Charlie',)
*/

-- Prediction Query
SELECT name FROM Person WHERE age < 30;

/*
Prediction Result:
('Charlie',)
('Alice',)
*/