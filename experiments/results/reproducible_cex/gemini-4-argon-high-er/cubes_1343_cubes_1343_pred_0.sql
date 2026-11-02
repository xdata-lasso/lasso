-- Schema DDL
CREATE TABLE "Person" ("name" TEXT(20) PRIMARY KEY, "age" INTEGER, "city" TEXT, "gender" TEXT, "job" TEXT);

CREATE TABLE "PersonFriend" ("friend" TEXT(20), "name" TEXT(20), "year" INTEGER, FOREIGN KEY ("friend") REFERENCES "Person" ("name"), FOREIGN KEY ("name") REFERENCES "Person" ("name"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Person" ("name", "age", "city", "gender", "job") VALUES ('Zoe', 25, 'boston', 'F', 'artist');
INSERT INTO "Person" ("name", "age", "city", "gender", "job") VALUES ('Zack', 30, 'new york city', 'M', 'engineer');
INSERT INTO "Person" ("name", "age", "city", "gender", "job") VALUES ('Amy', 22, 'chicago', 'F', 'student');
INSERT INTO "Person" ("name", "age", "city", "gender", "job") VALUES ('Alice', 28, 'new york city', 'F', 'doctor');
INSERT INTO "PersonFriend" ("friend", "name", "year") VALUES ('Zack', 'Zoe', 5);
INSERT INTO "PersonFriend" ("friend", "name", "year") VALUES ('Alice', 'Amy', 3);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "name_other" AS "name" FROM (SELECT "LHS"."name" AS "name", "LHS"."age" AS "age", "LHS"."city" AS "city", "LHS"."gender" AS "gender", "LHS"."job" AS "job", "RHS"."name" AS "name_other", "RHS"."year" AS "year" FROM (SELECT * FROM "person" WHERE ("city" = 'new york city')) AS LHS INNER JOIN personfriend AS RHS ON (LHS.name = RHS.friend)) ORDER BY name;

/*
Gold Result:
('Amy',)
('Zoe',)
*/

-- Prediction Query
SELECT T2.name FROM Person AS T1 JOIN PersonFriend AS T2 ON T1.name = T2.friend WHERE T1.city = 'new york city';

/*
Prediction Result:
('Zoe',)
('Amy',)
*/