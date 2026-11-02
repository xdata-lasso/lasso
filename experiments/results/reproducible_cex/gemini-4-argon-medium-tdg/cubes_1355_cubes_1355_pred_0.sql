-- Schema DDL
CREATE TABLE "Person" ("name" TEXT(20) PRIMARY KEY, "age" INTEGER, "city" TEXT, "gender" TEXT, "job" TEXT);

CREATE TABLE "PersonFriend" ("friend" TEXT(20), "name" TEXT(20), "year" INTEGER, FOREIGN KEY ("friend") REFERENCES "Person" ("name"), FOREIGN KEY ("name") REFERENCES "Person" ("name"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO "Person" ("name", "age", "city", "gender", "job") VALUES ('Dan', 40, 'Austin', 'M', 'Manager');
INSERT INTO "Person" ("name", "age", "city", "gender", "job") VALUES ('Alice', 35, 'Denver', 'F', 'Lawyer');
INSERT INTO "Person" ("name", "age", "city", "gender", "job") VALUES ('Zoe', 19, 'Miami', 'F', 'Chef');
INSERT INTO "Person" ("name", "age", "city", "gender", "job") VALUES ('Aaron', 50, 'Miami', 'M', 'Writer');
INSERT INTO "PersonFriend" ("friend", "name", "year") VALUES ('Dan', 'Zoe', 2015);
INSERT INTO "PersonFriend" ("friend", "name", "year") VALUES ('Dan', 'Zoe', 2020);
INSERT INTO "PersonFriend" ("friend", "name", "year") VALUES ('Dan', 'Aaron', 2017);
INSERT INTO "PersonFriend" ("friend", "name", "year") VALUES ('Alice', 'Zoe', 2018);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "name", "age" FROM (SELECT "LHS"."name" AS "name", "LHS"."age" AS "age", "LHS"."city" AS "city", "LHS"."gender" AS "gender", "LHS"."job" AS "job", "RHS"."friend" AS "friend", "RHS"."year" AS "year" FROM "person" AS "LHS" INNER JOIN "personfriend" AS "RHS" ON ("LHS"."name" = "RHS"."name")) WHERE ("friend" = 'Dan' AND "friend" <> 'Alice') ORDER BY name, "name" NULLS LAST, "age" NULLS LAST;

/*
Gold Result:
('Aaron', 50)
('Zoe', 19)
('Zoe', 19)
*/

-- Prediction Query
SELECT DISTINCT T1.name, T1.age FROM Person AS T1 JOIN PersonFriend AS T2 ON T1.name = T2.name WHERE T2.friend = 'Dan' OR T2.friend = 'Alice';

/*
Prediction Result:
('Zoe', 19)
('Aaron', 50)
*/