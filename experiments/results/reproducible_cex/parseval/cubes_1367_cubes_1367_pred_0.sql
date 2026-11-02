-- Schema DDL
CREATE TABLE "Person" ("name" TEXT(20) PRIMARY KEY, "age" INTEGER, "city" TEXT, "gender" TEXT, "job" TEXT);

CREATE TABLE "PersonFriend" ("friend" TEXT(20), "name" TEXT(20), "year" INTEGER, FOREIGN KEY ("friend") REFERENCES "Person" ("name"), FOREIGN KEY ("name") REFERENCES "Person" ("name"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: person --
INSERT INTO "person" ("name", "age", "city", "gender", "job") VALUES ('per_9329c8', 30, '5k5swwqcgs', '9n8', 'per_f5b6f0');

INSERT INTO "person" ("name", "age", "city", "gender", "job") VALUES ('A', 29, '5k5swwqcgs', '9n8', 'per_b25b66');

INSERT INTO "person" ("name", "age", "city", "gender", "job") VALUES ('@', NULL, '4', 'gu7v', 'per_b25b66');

INSERT INTO "person" ("name", "age", "city", "gender", "job") VALUES ('H', 30, 'e4', 'hria2ypuzhs', 'engineer');

INSERT INTO "person" ("name", "age", "city", "gender", "job") VALUES ('_', 29, 'rwbbp6luhvd', 'tti', 'engineer');

INSERT INTO "person" ("name", "age", "city", "gender", "job") VALUES ('/', NULL, 'bnp', 'mdpos', 'engineer');
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