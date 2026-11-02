-- Schema DDL
CREATE TABLE "Person" ("name" TEXT(20) PRIMARY KEY, "age" INTEGER, "city" TEXT, "gender" TEXT, "job" TEXT);

CREATE TABLE "PersonFriend" ("friend" TEXT(20), "name" TEXT(20), "year" INTEGER, FOREIGN KEY ("friend") REFERENCES "Person" ("name"), FOREIGN KEY ("name") REFERENCES "Person" ("name"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: person --
INSERT INTO "person" ("name", "age", "city", "gender", "job") VALUES ('A', -55602865, 'per_cd185a', 'swwqcgsk', '9n8c4pgu7v');

INSERT INTO "person" ("name", "age", "city", "gender", "job") VALUES ('C', -1865039888, 'per_cd185a', 'hria2ypuzhs', 'rwbbp6luhvd');

INSERT INTO "person" ("name", "age", "city", "gender", "job") VALUES ('@', -1377057208, 'ilbnp', 'mdpos', 'ie5');

INSERT INTO "person" ("name", "age", "city", "gender", "job") VALUES ('H', -1209887326, 'klfa9000t', 'c4ecigce', '76nium52');

INSERT INTO "person" ("name", "age", "city", "gender", "job") VALUES ('I', -443340271, 'uo4nrqrofqy', '5s5b', 'p');

INSERT INTO "person" ("name", "age", "city", "gender", "job") VALUES ('D', 882961052, '2eutliqa11r', 'ytoo3o9', 'l7');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT n AS count_distinct_city_ FROM (SELECT COUNT(*) AS n FROM person) ORDER BY count_distinct_city_;

/*
Gold Result:
(6,)
*/

-- Prediction Query
SELECT COUNT(DISTINCT city) FROM Person;

/*
Prediction Result:
(5,)
*/