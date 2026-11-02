-- Schema DDL
CREATE TABLE "Person" ("name" TEXT(20) PRIMARY KEY, "age" INTEGER, "city" TEXT, "gender" TEXT, "job" TEXT);

CREATE TABLE "PersonFriend" ("friend" TEXT(20), "name" TEXT(20), "year" INTEGER, FOREIGN KEY ("friend") REFERENCES "Person" ("name"), FOREIGN KEY ("name") REFERENCES "Person" ("name"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "Person" ("name", "age", "city", "gender", "job") VALUES ('Bob', 30, 'New York', 'Male', 'Engineer');
INSERT INTO "Person" ("name", "age", "city", "gender", "job") VALUES ('Alice', 25, 'Boston', 'Female', 'Doctor');
INSERT INTO "Person" ("name", "age", "city", "gender", "job") VALUES ('Charlie', 35, 'Chicago', 'Male', 'Teacher');
INSERT INTO "Person" ("name", "age", "city", "gender", "job") VALUES ('David', 28, 'Seattle', 'Male', 'Artist');
INSERT INTO "Person" ("name", "age", "city", "gender", "job") VALUES ('Eve', 22, 'Austin', 'Female', 'Student');
INSERT INTO "PersonFriend" ("friend", "name", "year") VALUES ('Bob', 'Alice', 2020);
INSERT INTO "PersonFriend" ("friend", "name", "year") VALUES ('Bob', 'Alice', 2021);
INSERT INTO "PersonFriend" ("friend", "name", "year") VALUES ('Bob', 'Charlie', 2019);
INSERT INTO "PersonFriend" ("friend", "name", "year") VALUES ('David', 'Bob', 2018);
INSERT INTO "PersonFriend" ("friend", "name", "year") VALUES ('Alice', 'Eve', 2022);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "name" FROM (SELECT * FROM "person" AS "LHS" WHERE EXISTS(SELECT 1 FROM (SELECT * FROM "personfriend" WHERE ("friend" = 'Bob')) AS RHS WHERE (LHS.name = RHS.name))) ORDER BY name, "name" NULLS LAST;

/*
Gold Result:
('Alice',)
('Charlie',)
*/

-- Prediction Query
SELECT T1.name FROM Person AS T1 JOIN PersonFriend AS T2 ON T1.name = T2.name WHERE T2.friend = 'Bob';

/*
Prediction Result:
('Alice',)
('Alice',)
('Charlie',)
*/