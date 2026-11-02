-- Schema DDL
CREATE TABLE "Person" ("name" TEXT(20) PRIMARY KEY, "age" INTEGER, "city" TEXT, "gender" TEXT, "job" TEXT);

CREATE TABLE "PersonFriend" ("friend" TEXT(20), "name" TEXT(20), "year" INTEGER, FOREIGN KEY ("friend") REFERENCES "Person" ("name"), FOREIGN KEY ("name") REFERENCES "Person" ("name"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 4
INSERT INTO "Person" ("name", "age", "city", "gender", "job") VALUES ('a_nyc', 19, 'new york city', 'F', 'student');
INSERT INTO "Person" ("name", "age", "city", "gender", "job") VALUES ('z_nyc', 60, 'new york city', 'M', 'retired');
INSERT INTO "Person" ("name", "age", "city", "gender", "job") VALUES ('m_friend', 45, 'new york city', 'F', 'manager');
INSERT INTO "PersonFriend" ("friend", "name", "year") VALUES ('a_nyc', 'z_nyc', 2000);
INSERT INTO "PersonFriend" ("friend", "name", "year") VALUES ('z_nyc', 'a_nyc', 1995);
INSERT INTO "PersonFriend" ("friend", "name", "year") VALUES ('m_friend', 'm_friend', 2010);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "name_other" AS "name" FROM (SELECT "LHS"."name" AS "name", "LHS"."age" AS "age", "LHS"."city" AS "city", "LHS"."gender" AS "gender", "LHS"."job" AS "job", "RHS"."name" AS "name_other", "RHS"."year" AS "year" FROM (SELECT * FROM "person" WHERE ("city" = 'new york city')) AS LHS INNER JOIN personfriend AS RHS ON (LHS.name = RHS.friend)) ORDER BY name;

/*
Gold Result:
('a_nyc',)
('m_friend',)
('z_nyc',)
*/

-- Prediction Query
SELECT T2.name FROM Person AS T1 JOIN PersonFriend AS T2 ON T1.name = T2.friend WHERE T1.city = 'new york city';

/*
Prediction Result:
('z_nyc',)
('a_nyc',)
('m_friend',)
*/