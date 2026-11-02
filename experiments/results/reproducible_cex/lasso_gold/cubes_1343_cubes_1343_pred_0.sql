-- Schema DDL
CREATE TABLE "Person" ("name" TEXT(20) PRIMARY KEY, "age" INTEGER, "city" TEXT, "gender" TEXT, "job" TEXT);

CREATE TABLE "PersonFriend" ("friend" TEXT(20), "name" TEXT(20), "year" INTEGER, FOREIGN KEY ("friend") REFERENCES "Person" ("name"), FOREIGN KEY ("name") REFERENCES "Person" ("name"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "person" ("name", "age", "city", "gender", "job") VALUES ('Kevin Hurst', 1021, 'new york city', 'inside', 'Medical illustrator');
INSERT INTO "person" ("name", "age", "city", "gender", "job") VALUES ('Zachary Rice', 1025, 'new york city', 'on', 'Administrator, arts');
INSERT INTO "person" ("name", "age", "city", "gender", "job") VALUES ('Anthony Rodriguez', NULL, NULL, NULL, NULL);
INSERT INTO "personfriend" ("friend", "name", "year") VALUES ('Kevin Hurst', 'Kevin Hurst', 1022);
INSERT INTO "personfriend" ("friend", "name", "year") VALUES ('Kevin Hurst', 'Anthony Rodriguez', 1024);
INSERT INTO "personfriend" ("friend", "name", "year") VALUES ('Zachary Rice', 'Zachary Rice', 1026);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "name_other" AS "name" FROM (SELECT "LHS"."name" AS "name", "LHS"."age" AS "age", "LHS"."city" AS "city", "LHS"."gender" AS "gender", "LHS"."job" AS "job", "RHS"."name" AS "name_other", "RHS"."year" AS "year" FROM (SELECT * FROM "person" WHERE ("city" = 'new york city')) AS LHS INNER JOIN personfriend AS RHS ON (LHS.name = RHS.friend)) ORDER BY name;

/*
Gold Result:
('Anthony Rodriguez',)
('Kevin Hurst',)
('Zachary Rice',)
*/

-- Prediction Query
SELECT T2.name FROM Person AS T1 JOIN PersonFriend AS T2 ON T1.name = T2.friend WHERE T1.city = 'new york city';

/*
Prediction Result:
('Kevin Hurst',)
('Anthony Rodriguez',)
('Zachary Rice',)
*/