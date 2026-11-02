-- Schema DDL
CREATE TABLE "Person" ("name" TEXT(20) PRIMARY KEY, "age" INTEGER, "city" TEXT, "gender" TEXT, "job" TEXT);

CREATE TABLE "PersonFriend" ("friend" TEXT(20), "name" TEXT(20), "year" INTEGER, FOREIGN KEY ("friend") REFERENCES "Person" ("name"), FOREIGN KEY ("name") REFERENCES "Person" ("name"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "Person" ("name", "age", "city", "gender", "job") VALUES ('Alice', 30, 'New York', 'female', 'doctor');
INSERT INTO "Person" ("name", "age", "city", "gender", "job") VALUES ('Bob', 29, 'Chicago', 'male', 'doctor');
INSERT INTO "Person" ("name", "age", "city", "gender", "job") VALUES ('Charlie', 35, 'Boston', 'male', 'engineer');
INSERT INTO "Person" ("name", "age", "city", "gender", "job") VALUES ('David', 30, 'Seattle', 'male', 'engineer');
INSERT INTO "Person" ("name", "age", "city", "gender", "job") VALUES ('Eve', 40, 'Austin', 'female', 'teacher');
INSERT INTO "Person" ("name", "age", "city", "gender", "job") VALUES ('Frank', 25, 'Denver', 'male', 'engineer');
INSERT INTO "Person" ("name", "age", "city", "gender", "job") VALUES ('Grace', 35, 'Miami', 'female', NULL);
INSERT INTO "Person" ("name", "age", "city", "gender", "job") VALUES ('Heidi', NULL, 'Boston', 'female', 'doctor');
INSERT INTO "Person" ("name", "age", "city", "gender", "job") VALUES ('Ivan', 45, 'Dallas', 'male', 'Engineer');
INSERT INTO "PersonFriend" ("friend", "name", "year") VALUES ('Bob', 'Alice', 2020);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(*) OVER () AS "count___" FROM "person" WHERE ("job" <> 'engineer' AND age >= 30) ORDER BY count___, person.name NULLS LAST;

/*
Gold Result:
(3,)
(3,)
(3,)
*/

-- Prediction Query
SELECT COUNT(*) FROM Person WHERE age > 30 AND job = 'engineer';

/*
Prediction Result:
(1,)
*/