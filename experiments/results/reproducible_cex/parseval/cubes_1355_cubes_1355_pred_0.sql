-- Schema DDL
CREATE TABLE "Person" ("name" TEXT(20) PRIMARY KEY, "age" INTEGER, "city" TEXT, "gender" TEXT, "job" TEXT);

CREATE TABLE "PersonFriend" ("friend" TEXT(20), "name" TEXT(20), "year" INTEGER, FOREIGN KEY ("friend") REFERENCES "Person" ("name"), FOREIGN KEY ("name") REFERENCES "Person" ("name"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: person --
INSERT INTO "person" ("name", "age", "city", "gender", "job") VALUES ('lhs_8bcbd6', 1, 'lhs_543fc0', 'lhs_af6270', 'lhs_158cdb');

INSERT INTO "person" ("name", "age", "city", "gender", "job") VALUES ('Dan', -55602865, 'swwqcgsk', '9n8c4pgu7v', 'e4');

INSERT INTO "person" ("name", "age", "city", "gender", "job") VALUES ('lhs_9ce73d', 1, 'lhs_929b23', 'lhs_f540d7', 'lhs_e094d3');

INSERT INTO "person" ("name", "age", "city", "gender", "job") VALUES ('C', 1, 'lhs_543fc0', 'lhs_af6270', 'lhs_158cdb');

INSERT INTO "person" ("name", "age", "city", "gender", "job") VALUES ('A', 1160656988, 'ia2yp', 'uzhsrwbbp6lu', 'hvdlttilbnpr');

INSERT INTO "person" ("name", "age", "city", "gender", "job") VALUES ('Q', 2087640001, 'dposiie5unw', 'klfa9000t', 'c4ecigce');

INSERT INTO "person" ("name", "age", "city", "gender", "job") VALUES ('O', -1585009206, '52zb', 'uo4nrqrofqy', '5s5b');

INSERT INTO "person" ("name", "age", "city", "gender", "job") VALUES ('rhs_dedda3', 1, 'lhs_543fc0', 'lhs_af6270', 'lhs_158cdb');

INSERT INTO "person" ("name", "age", "city", "gender", "job") VALUES ('rhs_485ce7', 2107872094, '02eutliqa11r', 'ytoo3o9', 'l7');

-- Inserting into table: personfriend --
INSERT INTO "personfriend" ("friend", "name", "year") VALUES ('Dan', 'lhs_8bcbd6', 1);

INSERT INTO "personfriend" ("friend", "name", "year") VALUES ('Dan', 'lhs_8bcbd6', 1);

INSERT INTO "personfriend" ("friend", "name", "year") VALUES ('Dan', 'lhs_8bcbd6', 1);

INSERT INTO "personfriend" ("friend", "name", "year") VALUES ('Dan', 'A', 1);

INSERT INTO "personfriend" ("friend", "name", "year") VALUES ('Dan', 'Q', 1);

INSERT INTO "personfriend" ("friend", "name", "year") VALUES ('Dan', 'O', 1);

INSERT INTO "personfriend" ("friend", "name", "year") VALUES ('Dan', 'O', 1);

INSERT INTO "personfriend" ("friend", "name", "year") VALUES ('Dan', 'O', 1);

INSERT INTO "personfriend" ("friend", "name", "year") VALUES ('Dan', 'rhs_dedda3', 1);

INSERT INTO "personfriend" ("friend", "name", "year") VALUES ('Dan', 'rhs_dedda3', 1);

INSERT INTO "personfriend" ("friend", "name", "year") VALUES ('Dan', 'rhs_dedda3', 1);

INSERT INTO "personfriend" ("friend", "name", "year") VALUES ('Dan', 'rhs_dedda3', 1);

INSERT INTO "personfriend" ("friend", "name", "year") VALUES ('Dan', 'rhs_dedda3', 1);

INSERT INTO "personfriend" ("friend", "name", "year") VALUES ('Dan', 'rhs_dedda3', 1);

INSERT INTO "personfriend" ("friend", "name", "year") VALUES ('Dan', 'rhs_dedda3', 1);

INSERT INTO "personfriend" ("friend", "name", "year") VALUES ('Dan', 'rhs_dedda3', 1);

INSERT INTO "personfriend" ("friend", "name", "year") VALUES ('Dan', 'rhs_dedda3', 1);

INSERT INTO "personfriend" ("friend", "name", "year") VALUES ('Dan', 'rhs_dedda3', 1);

INSERT INTO "personfriend" ("friend", "name", "year") VALUES ('rhs_485ce7', 'lhs_8bcbd6', 1);

INSERT INTO "personfriend" ("friend", "name", "year") VALUES ('Dan', 'lhs_8bcbd6', NULL);

INSERT INTO "personfriend" ("friend", "name", "year") VALUES ('Dan', 'lhs_8bcbd6', 1);

INSERT INTO "personfriend" ("friend", "name", "year") VALUES ('Dan', 'lhs_8bcbd6', 1);

INSERT INTO "personfriend" ("friend", "name", "year") VALUES ('Dan', 'lhs_8bcbd6', 1);

INSERT INTO "personfriend" ("friend", "name", "year") VALUES ('Dan', 'lhs_8bcbd6', 1);

INSERT INTO "personfriend" ("friend", "name", "year") VALUES ('Dan', 'lhs_8bcbd6', 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "name", "age" FROM (SELECT "LHS"."name" AS "name", "LHS"."age" AS "age", "LHS"."city" AS "city", "LHS"."gender" AS "gender", "LHS"."job" AS "job", "RHS"."friend" AS "friend", "RHS"."year" AS "year" FROM "person" AS "LHS" INNER JOIN "personfriend" AS "RHS" ON ("LHS"."name" = "RHS"."name")) WHERE ("friend" = 'Dan' AND "friend" <> 'Alice') ORDER BY name, "name" NULLS LAST, "age" NULLS LAST;

/*
Gold Result:
('A', 1160656988)
('O', -1585009206)
('O', -1585009206)
('O', -1585009206)
('Q', 2087640001)
('lhs_8bcbd6', 1)
('lhs_8bcbd6', 1)
('lhs_8bcbd6', 1)
('lhs_8bcbd6', 1)
('lhs_8bcbd6', 1)
('lhs_8bcbd6', 1)
('lhs_8bcbd6', 1)
('lhs_8bcbd6', 1)
('lhs_8bcbd6', 1)
('rhs_dedda3', 1)
('rhs_dedda3', 1)
('rhs_dedda3', 1)
('rhs_dedda3', 1)
('rhs_dedda3', 1)
('rhs_dedda3', 1)
('rhs_dedda3', 1)
('rhs_dedda3', 1)
('rhs_dedda3', 1)
('rhs_dedda3', 1)
*/

-- Prediction Query
SELECT DISTINCT T1.name, T1.age FROM Person AS T1 JOIN PersonFriend AS T2 ON T1.name = T2.name WHERE T2.friend = 'Dan' OR T2.friend = 'Alice';

/*
Prediction Result:
('lhs_8bcbd6', 1)
('A', 1160656988)
('Q', 2087640001)
('O', -1585009206)
('rhs_dedda3', 1)
*/