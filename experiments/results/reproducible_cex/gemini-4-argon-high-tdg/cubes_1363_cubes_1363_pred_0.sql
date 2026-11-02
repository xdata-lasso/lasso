-- Schema DDL
CREATE TABLE "Person" ("name" TEXT(20) PRIMARY KEY, "age" INTEGER, "city" TEXT, "gender" TEXT, "job" TEXT);

CREATE TABLE "PersonFriend" ("friend" TEXT(20), "name" TEXT(20), "year" INTEGER, FOREIGN KEY ("friend") REFERENCES "Person" ("name"), FOREIGN KEY ("name") REFERENCES "Person" ("name"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "Person" ("name", "age", "city", "gender", "job") VALUES ('Bob', 10, 'Seattle', 'male', 'Engineer');
INSERT INTO "Person" ("name", "age", "city", "gender", "job") VALUES ('Zack', 30, 'Miami', 'male', 'Chef');
INSERT INTO "Person" ("name", "age", "city", "gender", "job") VALUES ('Aaron', 20, 'Denver', 'male', 'Pilot');
INSERT INTO "Person" ("name", "age", "city", "gender", "job") VALUES ('Eve', 25, 'Boston', 'female', 'Doctor');
INSERT INTO "Person" ("name", "age", "city", "gender", "job") VALUES ('Sam', 35, 'Austin', 'other', 'Teacher');
INSERT INTO "Person" ("name", "age", "city", "gender", "job") VALUES ('Pat', 40, 'Chicago', NULL, 'Lawyer');
INSERT INTO "PersonFriend" ("friend", "name", "year") VALUES ('Aaron', 'Zack', 2020);
INSERT INTO "PersonFriend" ("friend", "name", "year") VALUES ('Eve', 'Zack', 2021);
INSERT INTO "PersonFriend" ("friend", "name", "year") VALUES ('Zack', 'Aaron', 2019);
INSERT INTO "PersonFriend" ("friend", "name", "year") VALUES ('Eve', 'Aaron', 2022);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "name" FROM "person" WHERE ("gender" = 'male') ORDER BY name;

/*
Gold Result:
('Aaron',)
('Bob',)
('Zack',)
*/

-- Prediction Query
SELECT name FROM Person WHERE gender = 'male' ORDER BY age, Person.name NULLS LAST;

/*
Prediction Result:
('Bob',)
('Aaron',)
('Zack',)
*/