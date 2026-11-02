-- Schema DDL
CREATE TABLE "Person" ("name" TEXT(20) PRIMARY KEY, "age" INTEGER, "city" TEXT, "gender" TEXT, "job" TEXT);

CREATE TABLE "PersonFriend" ("friend" TEXT(20), "name" TEXT(20), "year" INTEGER, FOREIGN KEY ("friend") REFERENCES "Person" ("name"), FOREIGN KEY ("name") REFERENCES "Person" ("name"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "Person" ("name", "age", "city", "gender", "job") VALUES ('Bob', 30, 'New York', 'M', 'Engineer');
INSERT INTO "Person" ("name", "age", "city", "gender", "job") VALUES ('Alice', 25, 'Boston', 'F', 'Doctor');
INSERT INTO "Person" ("name", "age", "city", "gender", "job") VALUES ('Charlie', 35, 'Chicago', 'M', 'Artist');
INSERT INTO "Person" ("name", "age", "city", "gender", "job") VALUES ('Diana', 28, 'Seattle', 'F', 'Lawyer');
INSERT INTO "PersonFriend" ("friend", "name", "year") VALUES ('Charlie', 'Bob', 2010);
INSERT INTO "PersonFriend" ("friend", "name", "year") VALUES ('Alice', 'Bob', 2020);
INSERT INTO "PersonFriend" ("friend", "name", "year") VALUES ('Bob', 'Alice', 2015);
INSERT INTO "PersonFriend" ("friend", "name", "year") VALUES ('Diana', 'Charlie', 2018);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "friend" FROM (SELECT * FROM "personfriend" AS "LHS" WHERE NOT EXISTS(SELECT 1 FROM (SELECT * FROM "person" WHERE ("name" <> 'Bob')) AS RHS WHERE (LHS.name = RHS.name))) ORDER BY friend, "friend" NULLS LAST;

/*
Gold Result:
('Alice',)
('Charlie',)
*/

-- Prediction Query
SELECT T2.friend FROM Person AS T1 JOIN PersonFriend AS T2 ON T1.name = T2.name WHERE T1.name = 'Bob';

/*
Prediction Result:
('Charlie',)
('Alice',)
*/