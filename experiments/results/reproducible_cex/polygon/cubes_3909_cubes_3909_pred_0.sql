-- Schema DDL
CREATE TABLE "Person" ("name" TEXT(20) PRIMARY KEY, "age" INTEGER, "city" TEXT, "gender" TEXT, "job" TEXT);

CREATE TABLE "PersonFriend" ("friend" TEXT(20), "name" TEXT(20), "year" INTEGER, FOREIGN KEY ("friend") REFERENCES "Person" ("name"), FOREIGN KEY ("name") REFERENCES "Person" ("name"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Person" ("name", "age", "city", "gender", "job") VALUES ('9', -320, '16', '14', '10');
INSERT INTO "Person" ("name", "age", "city", "gender", "job") VALUES ('8', 40, '1', '15', NULL);
INSERT INTO "PersonFriend" ("friend", "name", "year") VALUES ('8', '8', 1);
INSERT INTO "PersonFriend" ("friend", "name", "year") VALUES ('8', '8', 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT n AS count___, gender FROM (SELECT gender, job, COUNT(*) AS n FROM person GROUP BY gender, job) WHERE (n < 40) ORDER BY count___, gender NULLS LAST;

/*
Gold Result:
(1, '14')
(1, '15')
*/

-- Prediction Query
SELECT COUNT(*), gender FROM Person WHERE age < 40 GROUP BY gender;

/*
Prediction Result:
(1, '14')
*/