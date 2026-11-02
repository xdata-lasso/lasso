-- Schema DDL
CREATE TABLE "Person" ("name" TEXT(20) PRIMARY KEY, "age" INTEGER, "city" TEXT, "gender" TEXT, "job" TEXT);

CREATE TABLE "PersonFriend" ("friend" TEXT(20), "name" TEXT(20), "year" INTEGER, FOREIGN KEY ("friend") REFERENCES "Person" ("name"), FOREIGN KEY ("name") REFERENCES "Person" ("name"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "person" ("name", "age", "city", "gender", "job") VALUES ('Kimberly Burgess', 1012, 'Hurstfurt', 'male', 'Fine artist');
INSERT INTO "person" ("name", "age", "city", "gender", "job") VALUES ('Jonathan Wilkerson', 1013, 'Thomasberg', 'male', 'Medical illustrator');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "name" FROM "person" WHERE ("gender" = 'male') ORDER BY name;

/*
Gold Result:
('Jonathan Wilkerson',)
('Kimberly Burgess',)
*/

-- Prediction Query
SELECT name FROM Person WHERE gender = 'male' ORDER BY age, Person.name NULLS LAST;

/*
Prediction Result:
('Kimberly Burgess',)
('Jonathan Wilkerson',)
*/