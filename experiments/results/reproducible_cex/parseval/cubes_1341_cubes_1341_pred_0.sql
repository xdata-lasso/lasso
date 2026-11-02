-- Schema DDL
CREATE TABLE "Person" ("name" TEXT(20) PRIMARY KEY, "age" INTEGER, "city" TEXT, "gender" TEXT, "job" TEXT);

CREATE TABLE "PersonFriend" ("friend" TEXT(20), "name" TEXT(20), "year" INTEGER, FOREIGN KEY ("friend") REFERENCES "Person" ("name"), FOREIGN KEY ("name") REFERENCES "Person" ("name"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: person --
INSERT INTO "person" ("name", "age", "city", "gender", "job") VALUES ('Zach', 1, '5k5swwqcgs', '9n8', NULL);

INSERT INTO "person" ("name", "age", "city", "gender", "job") VALUES ('name_2', 1, '4', 'gu7v', NULL);

INSERT INTO "person" ("name", "age", "city", "gender", "job") VALUES ('per_0ebfbf', 1, 'e4', 'hria2ypuzhs', 'per_d9f5bd');

INSERT INTO "person" ("name", "age", "city", "gender", "job") VALUES ('A', 700293388, 'wbbp6luhvdlt', 'ilbnp', 'doctor');

INSERT INTO "person" ("name", "age", "city", "gender", "job") VALUES ('@', NULL, '5k5swwqcgs', '9n8', 'doctor');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "age" FROM "person" WHERE ("job" = 'doctor' OR "name" = 'Zach') ORDER BY age, person.name NULLS LAST;

/*
Gold Result:
(None,)
(1,)
(700293388,)
*/

-- Prediction Query
SELECT age FROM Person WHERE job = 'doctor' AND name = 'Zach';

/*
Prediction Result:
*/