-- Schema DDL
CREATE TABLE "Person" ("name" TEXT(20) PRIMARY KEY, "age" INTEGER, "city" TEXT, "gender" TEXT, "job" TEXT);

CREATE TABLE "PersonFriend" ("friend" TEXT(20), "name" TEXT(20), "year" INTEGER, FOREIGN KEY ("friend") REFERENCES "Person" ("name"), FOREIGN KEY ("name") REFERENCES "Person" ("name"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "Person" ("name", "age", "city", "gender", "job") VALUES ('Alice', 30, 'New York', 'F', 'doctor');
INSERT INTO "Person" ("name", "age", "city", "gender", "job") VALUES ('Bob', 31, 'Chicago', 'M', 'teacher');
INSERT INTO "Person" ("name", "age", "city", "gender", "job") VALUES ('Charlie', 45, 'Boston', 'M', 'lawyer');
INSERT INTO "Person" ("name", "age", "city", "gender", "job") VALUES ('David', 29, 'Seattle', 'M', 'doctor');
INSERT INTO "Person" ("name", "age", "city", "gender", "job") VALUES ('Eve', 35, 'Austin', 'F', 'engineer');
INSERT INTO "Person" ("name", "age", "city", "gender", "job") VALUES ('Frank', 30, 'Denver', 'M', 'engineer');
INSERT INTO "Person" ("name", "age", "city", "gender", "job") VALUES ('Grace', 22, 'Miami', 'F', 'engineer');
INSERT INTO "PersonFriend" ("friend", "name", "year") VALUES ('Eve', 'David', 2018);
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