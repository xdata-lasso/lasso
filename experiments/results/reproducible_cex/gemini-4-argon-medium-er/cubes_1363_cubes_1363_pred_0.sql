-- Schema DDL
CREATE TABLE "Person" ("name" TEXT(20) PRIMARY KEY, "age" INTEGER, "city" TEXT, "gender" TEXT, "job" TEXT);

CREATE TABLE "PersonFriend" ("friend" TEXT(20), "name" TEXT(20), "year" INTEGER, FOREIGN KEY ("friend") REFERENCES "Person" ("name"), FOREIGN KEY ("name") REFERENCES "Person" ("name"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Person" ("name", "age", "city", "gender", "job") VALUES ('A', 30, 'CityA', 'male', 'JobA');
INSERT INTO "Person" ("name", "age", "city", "gender", "job") VALUES ('B', 20, 'CityB', 'male', 'JobB');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "name" FROM "person" WHERE ("gender" = 'male') ORDER BY name;

/*
Gold Result:
('A',)
('B',)
*/

-- Prediction Query
SELECT name FROM Person WHERE gender = 'male' ORDER BY age, Person.name NULLS LAST;

/*
Prediction Result:
('B',)
('A',)
*/