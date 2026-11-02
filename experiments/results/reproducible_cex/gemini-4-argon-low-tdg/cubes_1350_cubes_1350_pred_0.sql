-- Schema DDL
CREATE TABLE "Person" ("name" TEXT(20) PRIMARY KEY, "age" INTEGER, "city" TEXT, "gender" TEXT, "job" TEXT);

CREATE TABLE "PersonFriend" ("friend" TEXT(20), "name" TEXT(20), "year" INTEGER, FOREIGN KEY ("friend") REFERENCES "Person" ("name"), FOREIGN KEY ("name") REFERENCES "Person" ("name"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "Person" ("name", "age", "city", "gender", "job") VALUES ('Zach', 20, 'NY', 'male', 'Clerk');
INSERT INTO "Person" ("name", "age", "city", "gender", "job") VALUES ('Adam', 10, 'LA', 'male', 'Student');
INSERT INTO "Person" ("name", "age", "city", "gender", "job") VALUES ('Bob', 30, 'SF', 'male', 'Manager');
INSERT INTO "Person" ("name", "age", "city", "gender", "job") VALUES ('Charlie', 30, 'TX', 'male', 'Chef');
INSERT INTO "Person" ("name", "age", "city", "gender", "job") VALUES ('Eve', 5, 'NY', 'female', 'Child');
INSERT INTO "Person" ("name", "age", "city", "gender", "job") VALUES ('Fay', 40, 'LA', 'female', 'CEO');
INSERT INTO "PersonFriend" ("friend", "name", "year") VALUES ('Bob', 'Adam', 2020);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "name" FROM (SELECT "LHS"."name" AS "name", "LHS"."age" AS "age", "LHS"."city" AS "city", "LHS"."gender" AS "gender", "LHS"."job" AS "job", "RHS"."age" AS "age_other", "RHS"."minage" AS "minage" FROM "person" AS "LHS" INNER JOIN (SELECT "age", "gender", MIN("age") AS "minage" FROM "person" GROUP BY "age", "gender") AS "RHS" ON ("LHS"."gender" = "RHS"."gender")) WHERE ("gender" = 'male' AND minage > age) ORDER BY name, "name" NULLS LAST;

/*
Gold Result:
('Adam',)
('Adam',)
('Zach',)
*/

-- Prediction Query
SELECT name FROM Person WHERE gender = 'male' AND age = (SELECT MIN(age) FROM person WHERE gender = 'male');

/*
Prediction Result:
('Adam',)
*/