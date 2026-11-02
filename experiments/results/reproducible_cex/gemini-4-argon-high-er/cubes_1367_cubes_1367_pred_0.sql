-- Schema DDL
CREATE TABLE "Person" ("name" TEXT(20) PRIMARY KEY, "age" INTEGER, "city" TEXT, "gender" TEXT, "job" TEXT);

CREATE TABLE "PersonFriend" ("friend" TEXT(20), "name" TEXT(20), "year" INTEGER, FOREIGN KEY ("friend") REFERENCES "Person" ("name"), FOREIGN KEY ("name") REFERENCES "Person" ("name"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Person" ("name", "age", "city", "gender", "job") VALUES ('Alice', 35, 'NYC', 'F', 'doctor');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(*) OVER () AS "count___" FROM "person" WHERE ("job" <> 'engineer' AND age >= 30) ORDER BY count___, person.name NULLS LAST;

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT COUNT(*) FROM Person WHERE age > 30 AND job = 'engineer';

/*
Prediction Result:
(0,)
*/