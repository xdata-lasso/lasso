-- Schema DDL
CREATE TABLE "Person" ("name" TEXT(20) PRIMARY KEY, "age" INTEGER, "city" TEXT, "gender" TEXT, "job" TEXT);

CREATE TABLE "PersonFriend" ("friend" TEXT(20), "name" TEXT(20), "year" INTEGER, FOREIGN KEY ("friend") REFERENCES "Person" ("name"), FOREIGN KEY ("name") REFERENCES "Person" ("name"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Person" ("name", "age", "city", "gender", "job") VALUES ('Alice', 25, 'New York', 'Female', 'Engineer');
INSERT INTO "Person" ("name", "age", "city", "gender", "job") VALUES ('Bob', 30, 'New York', 'Male', 'Doctor');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT n AS count_distinct_city_ FROM (SELECT COUNT(*) AS n FROM person) ORDER BY count_distinct_city_;

/*
Gold Result:
(2,)
*/

-- Prediction Query
SELECT COUNT(DISTINCT city) FROM Person;

/*
Prediction Result:
(1,)
*/