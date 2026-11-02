-- Schema DDL
CREATE TABLE "Person" ("name" TEXT(20) PRIMARY KEY, "age" INTEGER, "city" TEXT, "gender" TEXT, "job" TEXT);

CREATE TABLE "PersonFriend" ("friend" TEXT(20), "name" TEXT(20), "year" INTEGER, FOREIGN KEY ("friend") REFERENCES "Person" ("name"), FOREIGN KEY ("name") REFERENCES "Person" ("name"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Person" ("name", "age", "city", "gender", "job") VALUES ('Bob', 25, 'NYC', 'M', 'Dev');
INSERT INTO "Person" ("name", "age", "city", "gender", "job") VALUES ('Dan', 30, 'NYC', 'M', 'Dev');
INSERT INTO "PersonFriend" ("friend", "name", "year") VALUES ('Dan', 'Bob', 2020);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "name", "age" FROM (SELECT "LHS"."name" AS "name", "LHS"."age" AS "age", "LHS"."city" AS "city", "LHS"."gender" AS "gender", "LHS"."job" AS "job", "RHS"."friend" AS "friend", "RHS"."year" AS "year" FROM "person" AS "LHS" INNER JOIN "personfriend" AS "RHS" ON ("LHS"."name" = "RHS"."name")) WHERE ("friend" = 'Dan' AND "friend" <> 'Alice') ORDER BY name, "name" NULLS LAST, "age" NULLS LAST;

/*
Gold Result:
('Bob', 25)
*/

-- Prediction Query
SELECT T1.name, T1.age FROM Person AS T1 JOIN PersonFriend AS T2 ON T1.name = T2.name WHERE T2.friend = 'Dan' INTERSECT SELECT T1.name, T1.age FROM Person AS T1 JOIN PersonFriend AS T2 ON T1.name = T2.name WHERE T2.friend = 'Alice';

/*
Prediction Result:
*/