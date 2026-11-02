-- Schema DDL
CREATE TABLE "Person" ("name" TEXT(20) PRIMARY KEY, "age" INTEGER, "city" TEXT, "gender" TEXT, "job" TEXT);

CREATE TABLE "PersonFriend" ("friend" TEXT(20), "name" TEXT(20), "year" INTEGER, FOREIGN KEY ("friend") REFERENCES "Person" ("name"), FOREIGN KEY ("name") REFERENCES "Person" ("name"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "person" ("name", "age", "city", "gender", "job") VALUES ('Kevin Pacheco', 1003, 'Port Lindachester', 'grow', 'Health physicist');
INSERT INTO "person" ("name", "age", "city", "gender", "job") VALUES ('Tyler Rogers', NULL, 'South Colinstad', 'PM', 'Geneticist, molecular');
INSERT INTO "person" ("name", "age", "city", "gender", "job") VALUES ('Monica Herrera', 1005, 'Millerport', 'themselves', 'Geneticist, molecular');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT age AS min_age_, job FROM (SELECT job, MIN(age) AS age FROM person GROUP BY job) ORDER BY min_age_, job NULLS LAST;

/*
Gold Result:
(1003, 'Health physicist')
(1005, 'Geneticist, molecular')
*/

-- Prediction Query
SELECT MIN(age), job FROM Person GROUP BY job;

/*
Prediction Result:
(1005, 'Geneticist, molecular')
(1003, 'Health physicist')
*/