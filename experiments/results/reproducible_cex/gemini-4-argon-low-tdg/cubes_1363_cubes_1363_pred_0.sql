-- Schema DDL
CREATE TABLE "Person" ("name" TEXT(20) PRIMARY KEY, "age" INTEGER, "city" TEXT, "gender" TEXT, "job" TEXT);

CREATE TABLE "PersonFriend" ("friend" TEXT(20), "name" TEXT(20), "year" INTEGER, FOREIGN KEY ("friend") REFERENCES "Person" ("name"), FOREIGN KEY ("name") REFERENCES "Person" ("name"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "Person" ("name", "age", "city", "gender", "job") VALUES ('Zach', 30, 'Boston', 'male', 'engineer');
INSERT INTO "Person" ("name", "age", "city", "gender", "job") VALUES ('Adam', 25, 'Austin', 'male', 'doctor');
INSERT INTO "Person" ("name", "age", "city", "gender", "job") VALUES ('Mary', 28, 'Seattle', 'female', 'artist');
INSERT INTO "Person" ("name", "age", "city", "gender", "job") VALUES ('Carl', 40, 'Denver', 'male', 'teacher');
INSERT INTO "Person" ("name", "age", "city", "gender", "job") VALUES ('Pat', 35, 'Miami', NULL, 'nurse');
INSERT INTO "Person" ("name", "age", "city", "gender", "job") VALUES ('Alex', 22, 'Chicago', 'non-binary', 'student');
INSERT INTO "PersonFriend" ("friend", "name", "year") VALUES ('Adam', 'Zach', 2015);
INSERT INTO "PersonFriend" ("friend", "name", "year") VALUES ('Mary', 'Zach', 2018);
INSERT INTO "PersonFriend" ("friend", "name", "year") VALUES ('Zach', 'Adam', 2020);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "name" FROM "person" WHERE ("gender" = 'male') ORDER BY name;

/*
Gold Result:
('Adam',)
('Carl',)
('Zach',)
*/

-- Prediction Query
SELECT name FROM Person WHERE gender = 'male' ORDER BY age, Person.name NULLS LAST;

/*
Prediction Result:
('Adam',)
('Zach',)
('Carl',)
*/