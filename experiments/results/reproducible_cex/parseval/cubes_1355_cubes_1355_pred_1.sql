-- Schema DDL
CREATE TABLE "Person" ("name" TEXT(20) PRIMARY KEY, "age" INTEGER, "city" TEXT, "gender" TEXT, "job" TEXT);

CREATE TABLE "PersonFriend" ("friend" TEXT(20), "name" TEXT(20), "year" INTEGER, FOREIGN KEY ("friend") REFERENCES "Person" ("name"), FOREIGN KEY ("name") REFERENCES "Person" ("name"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: person --
INSERT INTO "person" ("name", "age", "city", "gender", "job") VALUES ('lhs_4112ba', 1, 'lhs_aeb300', 'lhs_c86d39', 'lhs_fdcc48');

INSERT INTO "person" ("name", "age", "city", "gender", "job") VALUES ('Dan', -55602865, 'swwqcgsk', '9n8c4pgu7v', 'e4');

INSERT INTO "person" ("name", "age", "city", "gender", "job") VALUES ('lhs_0a8f5b', 1, 'lhs_ae2999', 'lhs_a08192', 'lhs_37ed4c');

INSERT INTO "person" ("name", "age", "city", "gender", "job") VALUES ('A', 1, 'lhs_aeb300', 'lhs_c86d39', 'lhs_fdcc48');

INSERT INTO "person" ("name", "age", "city", "gender", "job") VALUES ('C', 1160656988, 'ia2yp', 'uzhsrwbbp6lu', 'hvdlttilbnpr');

INSERT INTO "person" ("name", "age", "city", "gender", "job") VALUES ('Q', 1, 'lhs_aeb300', 'lhs_c86d39', 'lhs_fdcc48');

INSERT INTO "person" ("name", "age", "city", "gender", "job") VALUES ('O', 1, 'lhs_aeb300', 'lhs_c86d39', 'lhs_fdcc48');

INSERT INTO "person" ("name", "age", "city", "gender", "job") VALUES ('rhs_44acfa', 1, 'lhs_aeb300', 'lhs_c86d39', 'lhs_fdcc48');

INSERT INTO "person" ("name", "age", "city", "gender", "job") VALUES ('rhs_365f18', 2087640001, 'dposiie5unw', 'klfa9000t', 'c4ecigce');

-- Inserting into table: personfriend --
INSERT INTO "personfriend" ("friend", "name", "year") VALUES ('Dan', 'lhs_4112ba', 1);

INSERT INTO "personfriend" ("friend", "name", "year") VALUES ('Dan', 'lhs_4112ba', 1);

INSERT INTO "personfriend" ("friend", "name", "year") VALUES ('Dan', 'lhs_4112ba', 1);

INSERT INTO "personfriend" ("friend", "name", "year") VALUES ('Dan', 'C', 1);

INSERT INTO "personfriend" ("friend", "name", "year") VALUES ('Dan', 'A', 1);

INSERT INTO "personfriend" ("friend", "name", "year") VALUES ('Dan', 'A', 1);

INSERT INTO "personfriend" ("friend", "name", "year") VALUES ('Dan', 'A', 1);

INSERT INTO "personfriend" ("friend", "name", "year") VALUES ('Dan', 'A', 1);

INSERT INTO "personfriend" ("friend", "name", "year") VALUES ('Dan', 'rhs_44acfa', 1);

INSERT INTO "personfriend" ("friend", "name", "year") VALUES ('Dan', 'rhs_44acfa', 1);

INSERT INTO "personfriend" ("friend", "name", "year") VALUES ('Dan', 'rhs_44acfa', 1);

INSERT INTO "personfriend" ("friend", "name", "year") VALUES ('Dan', 'rhs_44acfa', 1);

INSERT INTO "personfriend" ("friend", "name", "year") VALUES ('Dan', 'rhs_44acfa', 1);

INSERT INTO "personfriend" ("friend", "name", "year") VALUES ('Dan', 'rhs_44acfa', 1);

INSERT INTO "personfriend" ("friend", "name", "year") VALUES ('Dan', 'rhs_44acfa', 1);

INSERT INTO "personfriend" ("friend", "name", "year") VALUES ('Dan', 'rhs_44acfa', 1);

INSERT INTO "personfriend" ("friend", "name", "year") VALUES ('Dan', 'rhs_44acfa', 1);

INSERT INTO "personfriend" ("friend", "name", "year") VALUES ('Dan', 'rhs_44acfa', 1);

INSERT INTO "personfriend" ("friend", "name", "year") VALUES ('rhs_365f18', 'lhs_4112ba', 1);

INSERT INTO "personfriend" ("friend", "name", "year") VALUES ('Dan', 'lhs_4112ba', 1);

INSERT INTO "personfriend" ("friend", "name", "year") VALUES ('Dan', 'lhs_4112ba', 1);

INSERT INTO "personfriend" ("friend", "name", "year") VALUES ('Dan', 'lhs_4112ba', 1);

INSERT INTO "personfriend" ("friend", "name", "year") VALUES ('Dan', 'lhs_4112ba', 1);

INSERT INTO "personfriend" ("friend", "name", "year") VALUES ('Dan', 'lhs_4112ba', NULL);

INSERT INTO "personfriend" ("friend", "name", "year") VALUES ('Dan', 'lhs_4112ba', 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "name", "age" FROM (SELECT "LHS"."name" AS "name", "LHS"."age" AS "age", "LHS"."city" AS "city", "LHS"."gender" AS "gender", "LHS"."job" AS "job", "RHS"."friend" AS "friend", "RHS"."year" AS "year" FROM "person" AS "LHS" INNER JOIN "personfriend" AS "RHS" ON ("LHS"."name" = "RHS"."name")) WHERE ("friend" = 'Dan' AND "friend" <> 'Alice') ORDER BY name, "name" NULLS LAST, "age" NULLS LAST;

/*
Gold Result:
('A', 1)
('A', 1)
('A', 1)
('A', 1)
('C', 1160656988)
('lhs_4112ba', 1)
('lhs_4112ba', 1)
('lhs_4112ba', 1)
('lhs_4112ba', 1)
('lhs_4112ba', 1)
('lhs_4112ba', 1)
('lhs_4112ba', 1)
('lhs_4112ba', 1)
('lhs_4112ba', 1)
('rhs_44acfa', 1)
('rhs_44acfa', 1)
('rhs_44acfa', 1)
('rhs_44acfa', 1)
('rhs_44acfa', 1)
('rhs_44acfa', 1)
('rhs_44acfa', 1)
('rhs_44acfa', 1)
('rhs_44acfa', 1)
('rhs_44acfa', 1)
*/

-- Prediction Query
SELECT T1.name, T1.age FROM Person AS T1 JOIN PersonFriend AS T2 ON T1.name = T2.name WHERE T2.friend = 'Dan' INTERSECT SELECT T1.name, T1.age FROM Person AS T1 JOIN PersonFriend AS T2 ON T1.name = T2.name WHERE T2.friend = 'Alice';

/*
Prediction Result:
*/