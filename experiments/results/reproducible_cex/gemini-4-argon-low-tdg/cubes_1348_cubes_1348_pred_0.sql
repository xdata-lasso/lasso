-- Schema DDL
CREATE TABLE "Person" ("name" TEXT(20) PRIMARY KEY, "age" INTEGER, "city" TEXT, "gender" TEXT, "job" TEXT);

CREATE TABLE "PersonFriend" ("friend" TEXT(20), "name" TEXT(20), "year" INTEGER, FOREIGN KEY ("friend") REFERENCES "Person" ("name"), FOREIGN KEY ("name") REFERENCES "Person" ("name"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Comprehensive dataset: tests COUNT(*) vs COUNT(city), COUNT(DISTINCT city), NULL handling across columns, and INNER/LEFT JOIN with PersonFriend (isolated nodes, 1-to-1, and 1-to-many relationships).
-- Gold Query returns: 5
-- Mutant COUNT(city) returns: 4
-- Mutant COUNT(DISTINCT city) returns: 3
-- Mutant COUNT(*) with INNER JOIN PersonFriend returns: 3
-- Mutant COUNT(*) with LEFT JOIN PersonFriend returns: 6
INSERT INTO "Person" ("name", "age", "city", "gender", "job") VALUES ('Alice', 25, 'New York', 'F', 'Engineer');
INSERT INTO "Person" ("name", "age", "city", "gender", "job") VALUES ('Bob', 30, 'New York', 'M', 'Doctor');
INSERT INTO "Person" ("name", "age", "city", "gender", "job") VALUES ('Charlie', 35, 'Boston', 'M', NULL);
INSERT INTO "Person" ("name", "age", "city", "gender", "job") VALUES ('David', 40, NULL, 'M', 'Artist');
INSERT INTO "Person" ("name", "age", "city", "gender", "job") VALUES ('Eve', NULL, 'Chicago', NULL, 'Lawyer');
INSERT INTO "PersonFriend" ("friend", "name", "year") VALUES ('Bob', 'Alice', 2018);
INSERT INTO "PersonFriend" ("friend", "name", "year") VALUES ('Charlie', 'Alice', 2019);
INSERT INTO "PersonFriend" ("friend", "name", "year") VALUES ('David', 'Bob', 2020);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT n AS count_distinct_city_ FROM (SELECT COUNT(*) AS n FROM person) ORDER BY count_distinct_city_;

/*
Gold Result:
(5,)
*/

-- Prediction Query
SELECT COUNT(DISTINCT city) FROM Person;

/*
Prediction Result:
(3,)
*/