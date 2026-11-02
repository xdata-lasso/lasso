-- Schema DDL
CREATE TABLE "Person" ("name" TEXT(20) PRIMARY KEY, "age" INTEGER, "city" TEXT, "gender" TEXT, "job" TEXT);

CREATE TABLE "PersonFriend" ("friend" TEXT(20), "name" TEXT(20), "year" INTEGER, FOREIGN KEY ("friend") REFERENCES "Person" ("name"), FOREIGN KEY ("name") REFERENCES "Person" ("name"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "person" ("name", "age", "city", "gender", "job") VALUES ('Javier Johnson', 1002, 'South Bridget', 'table', 'Surveyor, mining');
INSERT INTO "person" ("name", "age", "city", "gender", "job") VALUES ('Matthew Gardner', 1003, 'East William', 'agreement', 'Accounting technician');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM person ORDER BY name;

/*
Gold Result:
('Javier Johnson',)
('Matthew Gardner',)
*/

-- Prediction Query
SELECT name FROM Person ORDER BY age DESC, Person.name NULLS LAST;

/*
Prediction Result:
('Matthew Gardner',)
('Javier Johnson',)
*/