-- Schema DDL
CREATE TABLE "Person" ("name" TEXT(20) PRIMARY KEY, "age" INTEGER, "city" TEXT, "gender" TEXT, "job" TEXT);

CREATE TABLE "PersonFriend" ("friend" TEXT(20), "name" TEXT(20), "year" INTEGER, FOREIGN KEY ("friend") REFERENCES "Person" ("name"), FOREIGN KEY ("name") REFERENCES "Person" ("name"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Person" ("name", "age", "city", "gender", "job") VALUES ('Alice', 20, 'CityA', 'F', 'JobA');
INSERT INTO "Person" ("name", "age", "city", "gender", "job") VALUES ('Bob', 25, 'CityB', 'M', 'JobB');
INSERT INTO "Person" ("name", "age", "city", "gender", "job") VALUES ('Charlie', 30, 'CityC', 'M', 'JobC');
INSERT INTO "PersonFriend" ("friend", "name", "year") VALUES ('Charlie', 'Bob', 2020);
INSERT INTO "PersonFriend" ("friend", "name", "year") VALUES ('Alice', 'Bob', 2021);
INSERT INTO "PersonFriend" ("friend", "name", "year") VALUES ('Alice', NULL, 2022);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "friend" FROM (SELECT * FROM "personfriend" AS "LHS" WHERE NOT EXISTS(SELECT 1 FROM (SELECT * FROM "person" WHERE ("name" <> 'Bob')) AS RHS WHERE (LHS.name = RHS.name))) ORDER BY friend, "friend" NULLS LAST;

/*
Gold Result:
('Alice',)
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