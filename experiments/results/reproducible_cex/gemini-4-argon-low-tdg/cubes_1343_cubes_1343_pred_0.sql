-- Schema DDL
CREATE TABLE "Person" ("name" TEXT(20) PRIMARY KEY, "age" INTEGER, "city" TEXT, "gender" TEXT, "job" TEXT);

CREATE TABLE "PersonFriend" ("friend" TEXT(20), "name" TEXT(20), "year" INTEGER, FOREIGN KEY ("friend") REFERENCES "Person" ("name"), FOREIGN KEY ("name") REFERENCES "Person" ("name"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "Person" ("name", "age", "city", "gender", "job") VALUES ('Alice', 30, 'new york city', 'F', 'Engineer');
INSERT INTO "Person" ("name", "age", "city", "gender", "job") VALUES ('Bob', 25, 'new york city', 'M', 'Artist');
INSERT INTO "Person" ("name", "age", "city", "gender", "job") VALUES ('Charlie', 35, 'boston', 'M', 'Doctor');
INSERT INTO "Person" ("name", "age", "city", "gender", "job") VALUES ('David', 28, 'Chicago', 'M', 'Teacher');
INSERT INTO "Person" ("name", "age", "city", "gender", "job") VALUES ('Eve', 40, 'New York City', 'F', 'Lawyer');
INSERT INTO "Person" ("name", "age", "city", "gender", "job") VALUES ('Frank', 22, NULL, 'M', 'Student');
INSERT INTO "PersonFriend" ("friend", "name", "year") VALUES ('Alice', 'Charlie', 2015);
INSERT INTO "PersonFriend" ("friend", "name", "year") VALUES ('Alice', 'David', 2018);
INSERT INTO "PersonFriend" ("friend", "name", "year") VALUES ('Bob', 'Charlie', 2020);
INSERT INTO "PersonFriend" ("friend", "name", "year") VALUES ('Charlie', 'Eve', 2012);
INSERT INTO "PersonFriend" ("friend", "name", "year") VALUES ('Eve', 'Frank', 2019);
INSERT INTO "PersonFriend" ("friend", "name", "year") VALUES ('David', 'Alice', 2021);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "name_other" AS "name" FROM (SELECT "LHS"."name" AS "name", "LHS"."age" AS "age", "LHS"."city" AS "city", "LHS"."gender" AS "gender", "LHS"."job" AS "job", "RHS"."name" AS "name_other", "RHS"."year" AS "year" FROM (SELECT * FROM "person" WHERE ("city" = 'new york city')) AS LHS INNER JOIN personfriend AS RHS ON (LHS.name = RHS.friend)) ORDER BY name;

/*
Gold Result:
('Charlie',)
('Charlie',)
('David',)
*/

-- Prediction Query
SELECT T2.name FROM Person AS T1 JOIN PersonFriend AS T2 ON T1.name = T2.friend WHERE T1.city = 'new york city';

/*
Prediction Result:
('Charlie',)
('David',)
('Charlie',)
*/