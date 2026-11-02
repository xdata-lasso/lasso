-- Schema DDL
CREATE TABLE "Person" ("name" TEXT(20) PRIMARY KEY, "age" INTEGER, "city" TEXT, "gender" TEXT, "job" TEXT);

CREATE TABLE "PersonFriend" ("friend" TEXT(20), "name" TEXT(20), "year" INTEGER, FOREIGN KEY ("friend") REFERENCES "Person" ("name"), FOREIGN KEY ("name") REFERENCES "Person" ("name"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: person --
INSERT INTO "person" ("name", "age", "city", "gender", "job") VALUES ('per_496d5d', -55602865, 'swwqcgsk', '9n8c4pgu7v', 'e4');

INSERT INTO "person" ("name", "age", "city", "gender", "job") VALUES ('per_77c361', 1, 'per_cd98e6', 'per_631e5f', 'per_e432fc');

INSERT INTO "person" ("name", "age", "city", "gender", "job") VALUES ('per_45c23b', 1, 'per_606318', 'per_6364ca', 'per_a0f01f');

INSERT INTO "person" ("name", "age", "city", "gender", "job") VALUES ('per_320581', 1160656988, 'ia2yp', 'uzhsrwbbp6lu', 'hvdlttilbnpr');

INSERT INTO "person" ("name", "age", "city", "gender", "job") VALUES ('per_dcb384', 1, 'per_e65c1c', 'per_b9bd43', 'per_82deec');

INSERT INTO "person" ("name", "age", "city", "gender", "job") VALUES ('per_bbde35', 1, 'per_a34183', 'per_d103b1', 'per_5dc61e');

INSERT INTO "person" ("name", "age", "city", "gender", "job") VALUES ('A', 2087640001, 'dposiie5unw', 'klfa9000t', 'per_ecd7fd');

INSERT INTO "person" ("name", "age", "city", "gender", "job") VALUES ('!', 1408123494, '4', 'ecigce376n', 'per_7e446c');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "name" FROM (SELECT "LHS"."name" AS "name", "LHS"."age" AS "age", "LHS"."city" AS "city", "LHS"."gender" AS "gender", "LHS"."job" AS "job", "LHS"."minjob" AS "minjob", "RHS"."name" AS "name_other", "RHS"."city" AS "city_other", "RHS"."gender" AS "gender_other", "RHS"."minjob" AS "minjob_other" FROM (SELECT "name", "age", "city", "gender", "job", MIN("job") OVER () AS "minjob" FROM "person" WHERE ("job" <> 'engineer')) AS "LHS" INNER JOIN (SELECT "name", "age", "city", "gender", "job", MIN("job") OVER () AS "minjob" FROM "person" WHERE ("job" <> 'engineer')) AS RHS ON (LHS.age = RHS.age AND LHS.minjob = RHS.job)) ORDER BY name, "name" NULLS LAST;

/*
Gold Result:
('per_496d5d',)
*/

-- Prediction Query
SELECT name FROM Person WHERE age > (SELECT MIN(age) FROM person WHERE job = 'engineer') ORDER BY age, Person.name NULLS LAST;

/*
Prediction Result:
*/