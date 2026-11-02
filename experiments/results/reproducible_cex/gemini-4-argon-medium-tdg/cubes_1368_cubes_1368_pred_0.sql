-- Schema DDL
CREATE TABLE "Person" ("name" TEXT(20) PRIMARY KEY, "age" INTEGER, "city" TEXT, "gender" TEXT, "job" TEXT);

CREATE TABLE "PersonFriend" ("friend" TEXT(20), "name" TEXT(20), "year" INTEGER, FOREIGN KEY ("friend") REFERENCES "Person" ("name"), FOREIGN KEY ("name") REFERENCES "Person" ("name"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests boundary values around 30 (29, 30, 31) and ensures ORDER BY name differs from ORDER BY age and insertion order.
INSERT INTO "Person" ("name", "age", "city", "gender", "job") VALUES ('Zoe', 20, 'Boston', 'F', 'Student');
INSERT INTO "Person" ("name", "age", "city", "gender", "job") VALUES ('Alice', 29, 'New York', 'F', 'Engineer');
INSERT INTO "Person" ("name", "age", "city", "gender", "job") VALUES ('Bob', 30, 'Chicago', 'M', 'Doctor');
INSERT INTO "Person" ("name", "age", "city", "gender", "job") VALUES ('Charlie', 31, 'Seattle', 'M', 'Teacher');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM person WHERE (age < 30) ORDER BY name;

/*
Gold Result:
('Alice',)
('Zoe',)
*/

-- Prediction Query
SELECT name FROM Person WHERE age < 30;

/*
Prediction Result:
('Zoe',)
('Alice',)
*/