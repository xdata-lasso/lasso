-- Schema DDL
CREATE TABLE "Person" ("name" TEXT(20) PRIMARY KEY, "age" INTEGER, "city" TEXT, "gender" TEXT, "job" TEXT);

CREATE TABLE "PersonFriend" ("friend" TEXT(20), "name" TEXT(20), "year" INTEGER, FOREIGN KEY ("friend") REFERENCES "Person" ("name"), FOREIGN KEY ("name") REFERENCES "Person" ("name"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests behavior with duplicate cities, NULL values across columns, and asymmetric foreign key relationships in PersonFriend.
INSERT INTO "Person" ("name", "age", "city", "gender", "job") VALUES ('Alice', 30, 'New York', 'F', 'Engineer');
INSERT INTO "Person" ("name", "age", "city", "gender", "job") VALUES ('Bob', 25, 'New York', 'M', 'Artist');
INSERT INTO "Person" ("name", "age", "city", "gender", "job") VALUES ('Charlie', 35, NULL, 'M', NULL);
INSERT INTO "Person" ("name", "age", "city", "gender", "job") VALUES ('Diana', NULL, 'Boston', NULL, 'Doctor');
INSERT INTO "PersonFriend" ("friend", "name", "year") VALUES ('Bob', 'Alice', 2018);
INSERT INTO "PersonFriend" ("friend", "name", "year") VALUES ('Charlie', 'Alice', 2019);
INSERT INTO "PersonFriend" ("friend", "name", "year") VALUES ('Diana', 'Alice', 2020);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT n AS count_distinct_city_ FROM (SELECT COUNT(*) AS n FROM person) ORDER BY count_distinct_city_;

/*
Gold Result:
(4,)
*/

-- Prediction Query
SELECT COUNT(DISTINCT city) FROM Person;

/*
Prediction Result:
(2,)
*/