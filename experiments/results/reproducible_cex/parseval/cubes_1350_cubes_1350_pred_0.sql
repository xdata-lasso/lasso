-- Schema DDL
CREATE TABLE "Person" ("name" TEXT(20) PRIMARY KEY, "age" INTEGER, "city" TEXT, "gender" TEXT, "job" TEXT);

CREATE TABLE "PersonFriend" ("friend" TEXT(20), "name" TEXT(20), "year" INTEGER, FOREIGN KEY ("friend") REFERENCES "Person" ("name"), FOREIGN KEY ("name") REFERENCES "Person" ("name"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: person --
INSERT INTO "person" ("name", "age", "city", "gender", "job") VALUES ('name_1', 1, '5k5swwqcgs', 'male', '9n8');

INSERT INTO "person" ("name", "age", "city", "gender", "job") VALUES ('name_2', 1, '4', 'male', 'gu7v');

INSERT INTO "person" ("name", "age", "city", "gender", "job") VALUES ('name_3', 1, 'e4', 'male', 'hria2ypuzhs');

INSERT INTO "person" ("name", "age", "city", "gender", "job") VALUES ('lhs_881523', 1, 'lhs_544abc', 'male', 'lhs_26a630');

INSERT INTO "person" ("name", "age", "city", "gender", "job") VALUES ('name_5', 1, 'rwbbp6luhvd', 'male', 'tti');

INSERT INTO "person" ("name", "age", "city", "gender", "job") VALUES ('name_6', 1, 'bnp', 'male', 'mdpos');

INSERT INTO "person" ("name", "age", "city", "gender", "job") VALUES ('name_7', 1, 'ie5', 'male', 'nw6klf');

INSERT INTO "person" ("name", "age", "city", "gender", "job") VALUES ('lhs_8332ed', 1, 'lhs_2a0841', 'male', 'lhs_1cfaaf');

INSERT INTO "person" ("name", "age", "city", "gender", "job") VALUES ('name_9', NULL, 'a9000t5c4eci', 'gce376nium52', 'zbuo4nrqrof');

INSERT INTO "person" ("name", "age", "city", "gender", "job") VALUES ('name_10', NULL, 'qyp5s5bbp0', 'male', '2eutliqa11r');

INSERT INTO "person" ("name", "age", "city", "gender", "job") VALUES ('name_11', NULL, 'ytoo3o9', 'male', 'l7');

INSERT INTO "person" ("name", "age", "city", "gender", "job") VALUES ('name_12', NULL, 'klex14ji', 'male', '7zwau2dwyr');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "name" FROM (SELECT "LHS"."name" AS "name", "LHS"."age" AS "age", "LHS"."city" AS "city", "LHS"."gender" AS "gender", "LHS"."job" AS "job", "RHS"."age" AS "age_other", "RHS"."minage" AS "minage" FROM "person" AS "LHS" INNER JOIN (SELECT "age", "gender", MIN("age") AS "minage" FROM "person" GROUP BY "age", "gender") AS "RHS" ON ("LHS"."gender" = "RHS"."gender")) WHERE ("gender" = 'male' AND minage > age) ORDER BY name, "name" NULLS LAST;

/*
Gold Result:
*/

-- Prediction Query
SELECT name FROM Person WHERE gender = 'male' AND age = (SELECT MIN(age) FROM person WHERE gender = 'male');

/*
Prediction Result:
('name_1',)
('name_2',)
('name_3',)
('lhs_881523',)
('name_5',)
('name_6',)
('name_7',)
('lhs_8332ed',)
*/