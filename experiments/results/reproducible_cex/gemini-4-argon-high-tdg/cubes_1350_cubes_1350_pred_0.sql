-- Schema DDL
CREATE TABLE "Person" ("name" TEXT(20) PRIMARY KEY, "age" INTEGER, "city" TEXT, "gender" TEXT, "job" TEXT);

CREATE TABLE "PersonFriend" ("friend" TEXT(20), "name" TEXT(20), "year" INTEGER, FOREIGN KEY ("friend") REFERENCES "Person" ("name"), FOREIGN KEY ("name") REFERENCES "Person" ("name"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Person (name, age, city, gender, job) VALUES ('Charlie', 20, 'Boston', 'male', 'Clerk');
INSERT INTO Person (name, age, city, gender, job) VALUES ('Alice', 25, 'Austin', 'male', 'Engineer');
INSERT INTO Person (name, age, city, gender, job) VALUES ('Bob', 15, 'Chicago', 'male', 'Student');
INSERT INTO Person (name, age, city, gender, job) VALUES ('Zane', 40, 'Denver', 'male', 'Manager');
INSERT INTO Person (name, age, city, gender, job) VALUES ('Yuri', 40, 'Denver', 'male', 'Director');
INSERT INTO Person (name, age, city, gender, job) VALUES ('Diana', 60, 'Boston', 'female', 'CEO');
INSERT INTO PersonFriend (friend, name, year) VALUES ('Alice', 'Bob', 2018);
INSERT INTO PersonFriend (friend, name, year) VALUES ('Zane', 'Charlie', 2020);
INSERT INTO PersonFriend (friend, name, year) VALUES ('Diana', 'Alice', 2015);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "name" FROM (SELECT "LHS"."name" AS "name", "LHS"."age" AS "age", "LHS"."city" AS "city", "LHS"."gender" AS "gender", "LHS"."job" AS "job", "RHS"."age" AS "age_other", "RHS"."minage" AS "minage" FROM "person" AS "LHS" INNER JOIN (SELECT "age", "gender", MIN("age") AS "minage" FROM "person" GROUP BY "age", "gender") AS "RHS" ON ("LHS"."gender" = "RHS"."gender")) WHERE ("gender" = 'male' AND minage > age) ORDER BY name, "name" NULLS LAST;

/*
Gold Result:
('Alice',)
('Bob',)
('Bob',)
('Bob',)
('Charlie',)
('Charlie',)
*/

-- Prediction Query
SELECT name FROM Person WHERE gender = 'male' AND age = (SELECT MIN(age) FROM person WHERE gender = 'male');

/*
Prediction Result:
('Bob',)
*/