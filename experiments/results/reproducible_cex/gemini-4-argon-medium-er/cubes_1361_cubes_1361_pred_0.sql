-- Schema DDL
CREATE TABLE "Person" ("name" TEXT(20) PRIMARY KEY, "age" INTEGER, "city" TEXT, "gender" TEXT, "job" TEXT);

CREATE TABLE "PersonFriend" ("friend" TEXT(20), "name" TEXT(20), "year" INTEGER, FOREIGN KEY ("friend") REFERENCES "Person" ("name"), FOREIGN KEY ("name") REFERENCES "Person" ("name"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Person" ("name", "age", "city", "gender", "job") VALUES ('Alice', 25, 'NYC', 'female', 'doctor');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "name" FROM (SELECT "LHS"."name" AS "name", "LHS"."age" AS "age", "LHS"."city" AS "city", "LHS"."gender" AS "gender", "LHS"."job" AS "job", "LHS"."minjob" AS "minjob", "RHS"."name" AS "name_other", "RHS"."city" AS "city_other", "RHS"."gender" AS "gender_other", "RHS"."minjob" AS "minjob_other" FROM (SELECT "name", "age", "city", "gender", "job", MIN("job") OVER () AS "minjob" FROM "person" WHERE ("job" <> 'engineer')) AS "LHS" INNER JOIN (SELECT "name", "age", "city", "gender", "job", MIN("job") OVER () AS "minjob" FROM "person" WHERE ("job" <> 'engineer')) AS RHS ON (LHS.age = RHS.age AND LHS.minjob = RHS.job)) ORDER BY name, "name" NULLS LAST;

/*
Gold Result:
('Alice',)
*/

-- Prediction Query
SELECT name FROM Person WHERE age > (SELECT MIN(age) FROM person WHERE job = 'engineer') ORDER BY age, Person.name NULLS LAST;

/*
Prediction Result:
*/