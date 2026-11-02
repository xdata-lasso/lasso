-- Schema DDL
CREATE TABLE "Person" ("name" TEXT(20) PRIMARY KEY, "age" INTEGER, "city" TEXT, "gender" TEXT, "job" TEXT);

CREATE TABLE "PersonFriend" ("friend" TEXT(20), "name" TEXT(20), "year" INTEGER, FOREIGN KEY ("friend") REFERENCES "Person" ("name"), FOREIGN KEY ("name") REFERENCES "Person" ("name"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Person" ("name", "age", "city", "gender", "job") VALUES ('Alice', 20, 'NYC', 'male', 'Eng');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "name" FROM (SELECT "LHS"."name" AS "name", "LHS"."age" AS "age", "LHS"."city" AS "city", "LHS"."gender" AS "gender", "LHS"."job" AS "job", "RHS"."age" AS "age_other", "RHS"."minage" AS "minage" FROM "person" AS "LHS" INNER JOIN (SELECT "age", "gender", MIN("age") AS "minage" FROM "person" GROUP BY "age", "gender") AS "RHS" ON ("LHS"."gender" = "RHS"."gender")) WHERE ("gender" = 'male' AND minage > age) ORDER BY name, "name" NULLS LAST;

/*
Gold Result:
*/

-- Prediction Query
SELECT name FROM Person WHERE gender = 'male' AND age = (SELECT MIN(age) FROM person WHERE gender = 'male');

/*
Prediction Result:
('Alice',)
*/