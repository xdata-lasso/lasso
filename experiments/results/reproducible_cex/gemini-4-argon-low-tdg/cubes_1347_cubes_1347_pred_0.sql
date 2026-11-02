-- Schema DDL
CREATE TABLE "Person" ("name" TEXT(20) PRIMARY KEY, "age" INTEGER, "city" TEXT, "gender" TEXT, "job" TEXT);

CREATE TABLE "PersonFriend" ("friend" TEXT(20), "name" TEXT(20), "year" INTEGER, FOREIGN KEY ("friend") REFERENCES "Person" ("name"), FOREIGN KEY ("name") REFERENCES "Person" ("name"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO "Person" ("name", "age", "city", "gender", "job") VALUES ('Bob', 30, 'New York', 'Male', 'Engineer');
INSERT INTO "Person" ("name", "age", "city", "gender", "job") VALUES ('Alice', 25, 'Boston', 'Female', 'Doctor');
INSERT INTO "Person" ("name", "age", "city", "gender", "job") VALUES ('Zack', 40, 'Seattle', 'Male', 'Artist');
INSERT INTO "PersonFriend" ("friend", "name", "year") VALUES ('Zack', 'Bob', 2018);
INSERT INTO "PersonFriend" ("friend", "name", "year") VALUES ('Alice', 'Bob', 2020);
INSERT INTO "PersonFriend" ("friend", "name", "year") VALUES ('Alice', 'Bob', 2022);
INSERT INTO "PersonFriend" ("friend", "name", "year") VALUES (NULL, 'Bob', 2023);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "friend" FROM (SELECT * FROM "personfriend" AS "LHS" WHERE NOT EXISTS(SELECT 1 FROM (SELECT * FROM "person" WHERE ("name" <> 'Bob')) AS RHS WHERE (LHS.name = RHS.name))) ORDER BY friend, "friend" NULLS LAST;

/*
Gold Result:
(None,)
('Alice',)
('Alice',)
('Zack',)
*/

-- Prediction Query
SELECT T2.friend FROM Person AS T1 JOIN PersonFriend AS T2 ON T1.name = T2.name WHERE T1.name = 'Bob';

/*
Prediction Result:
('Zack',)
('Alice',)
('Alice',)
(None,)
*/