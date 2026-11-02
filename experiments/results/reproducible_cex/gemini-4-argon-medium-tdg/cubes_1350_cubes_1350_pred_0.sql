-- Schema DDL
CREATE TABLE "Person" ("name" TEXT(20) PRIMARY KEY, "age" INTEGER, "city" TEXT, "gender" TEXT, "job" TEXT);

CREATE TABLE "PersonFriend" ("friend" TEXT(20), "name" TEXT(20), "year" INTEGER, FOREIGN KEY ("friend") REFERENCES "Person" ("name"), FOREIGN KEY ("name") REFERENCES "Person" ("name"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Core multiplicity, ordering, and gender filtering:
-- Tests DISTINCT vs ALL (Charlie matches two distinct older male ages, so Charlie appears twice),
-- ascending vs descending ORDER BY (Bob vs Charlie),
-- and gender filtering (Eve and Frank are females with different ages, must be ignored).
INSERT INTO "Person" ("name", "age", "city", "gender", "job") VALUES ('Charlie', 20, 'NY', 'male', 'dev');
INSERT INTO "Person" ("name", "age", "city", "gender", "job") VALUES ('Bob', 30, 'LA', 'male', 'qa');
INSERT INTO "Person" ("name", "age", "city", "gender", "job") VALUES ('Alice', 40, 'SF', 'male', 'mgr');
INSERT INTO "Person" ("name", "age", "city", "gender", "job") VALUES ('Eve', 10, 'NY', 'female', 'dev');
INSERT INTO "Person" ("name", "age", "city", "gender", "job") VALUES ('Frank', 50, 'LA', 'female', 'ceo');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "name" FROM (SELECT "LHS"."name" AS "name", "LHS"."age" AS "age", "LHS"."city" AS "city", "LHS"."gender" AS "gender", "LHS"."job" AS "job", "RHS"."age" AS "age_other", "RHS"."minage" AS "minage" FROM "person" AS "LHS" INNER JOIN (SELECT "age", "gender", MIN("age") AS "minage" FROM "person" GROUP BY "age", "gender") AS "RHS" ON ("LHS"."gender" = "RHS"."gender")) WHERE ("gender" = 'male' AND minage > age) ORDER BY name, "name" NULLS LAST;

/*
Gold Result:
('Bob',)
('Charlie',)
('Charlie',)
*/

-- Prediction Query
SELECT name FROM Person WHERE gender = 'male' AND age = (SELECT MIN(age) FROM person WHERE gender = 'male');

/*
Prediction Result:
('Charlie',)
*/