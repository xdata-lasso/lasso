-- Schema DDL
CREATE TABLE "Person" ("name" TEXT(20) PRIMARY KEY, "age" INTEGER, "city" TEXT, "gender" TEXT, "job" TEXT);

CREATE TABLE "PersonFriend" ("friend" TEXT(20), "name" TEXT(20), "year" INTEGER, FOREIGN KEY ("friend") REFERENCES "Person" ("name"), FOREIGN KEY ("name") REFERENCES "Person" ("name"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Person" ("name", "age", "city", "gender", "job") VALUES ('Alice25', 5206110276854648058, 'Alice', 'Alice', 'Alice');
INSERT INTO "Person" ("name", "age", "city", "gender", "job") VALUES ('Alice', NULL, 'Alice32', 'Alice33', 'Alice36');
INSERT INTO "PersonFriend" ("friend", "name", "year") VALUES (NULL, 'Alice', 31);
INSERT INTO "PersonFriend" ("friend", "name", "year") VALUES ('Alice', 'Alice', -886);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "name", "age", "job" FROM (SELECT "LHS"."name" AS "name", "LHS"."age" AS "age", "LHS"."city" AS "city", "LHS"."gender" AS "gender", "LHS"."job" AS "job", "LHS"."friend" AS "friend", "LHS"."year" AS "year", "RHS"."maxyear" AS "maxyear" FROM (SELECT "LHS"."name" AS "name", "LHS"."age" AS "age", "LHS"."city" AS "city", "LHS"."gender" AS "gender", "LHS"."job" AS "job", "RHS"."friend" AS "friend", "RHS"."year" AS "year" FROM "person" AS "LHS" INNER JOIN "personfriend" AS "RHS" ON ("LHS"."name" = "RHS"."name")) AS "LHS" INNER JOIN (SELECT "name", "year", MAX("year") AS "maxyear" FROM "personfriend" WHERE ("friend" = 'Alice') GROUP BY name, YEAR) AS RHS ON (LHS.name = RHS.name AND LHS.year = RHS.year)) ORDER BY name, "name" NULLS LAST, "age" NULLS LAST, "job" NULLS LAST;

/*
Gold Result:
('Alice', None, 'Alice36')
*/

-- Prediction Query
SELECT T1.name, T1.age, T1.job FROM Person AS T1 JOIN PersonFriend AS T2 ON T1.name = T2.name WHERE T2.friend = 'Alice' AND T2.year = (SELECT MAX(YEAR) FROM PersonFriend WHERE friend = 'Alice');

/*
Prediction Result:
('Alice', None, 'Alice36')
*/