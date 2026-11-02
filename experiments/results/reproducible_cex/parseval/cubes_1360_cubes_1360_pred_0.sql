-- Schema DDL
CREATE TABLE "Person" ("name" TEXT(20) PRIMARY KEY, "age" INTEGER, "city" TEXT, "gender" TEXT, "job" TEXT);

CREATE TABLE "PersonFriend" ("friend" TEXT(20), "name" TEXT(20), "year" INTEGER, FOREIGN KEY ("friend") REFERENCES "Person" ("name"), FOREIGN KEY ("name") REFERENCES "Person" ("name"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: person --
INSERT INTO "person" ("name", "age", "city", "gender", "job") VALUES ('Alice', 1, 'per_a77132', 'per_95929b', 'per_e97067');

INSERT INTO "person" ("name", "age", "city", "gender", "job") VALUES ('per_e80dcc', -1437333179, 'wwqcg', 'k9n8c', 'pgu7vfe4');

INSERT INTO "person" ("name", "age", "city", "gender", "job") VALUES ('rhs_d5b00b', -992890117, 'a2ypuzhsrwbb', 'p6luhvdlttil', 'n');

INSERT INTO "person" ("name", "age", "city", "gender", "job") VALUES ('per_1ce8ed', 907682809, 'siie', 'unw6klfa', '9000t5c4ec');

INSERT INTO "person" ("name", "age", "city", "gender", "job") VALUES ('rhs_f2cdcc', 528680845, '76nium52', 'zbuo4nrqrof', 'qyp5s5bbp0');

-- Inserting into table: personfriend --
INSERT INTO "personfriend" ("friend", "name", "year") VALUES ('Alice', 'per_e80dcc', 1160656988);

INSERT INTO "personfriend" ("friend", "name", "year") VALUES ('Alice', 'rhs_d5b00b', 1);

INSERT INTO "personfriend" ("friend", "name", "year") VALUES ('Alice', 'per_e80dcc', 1236688122);

INSERT INTO "personfriend" ("friend", "name", "year") VALUES ('Alice', 'per_1ce8ed', -1683203397);

INSERT INTO "personfriend" ("friend", "name", "year") VALUES ('Alice', 'rhs_d5b00b', 1);

INSERT INTO "personfriend" ("friend", "name", "year") VALUES ('Alice', 'rhs_f2cdcc', 1);

INSERT INTO "personfriend" ("friend", "name", "year") VALUES ('per_1ce8ed', 'rhs_f2cdcc', -1822992503);

INSERT INTO "personfriend" ("friend", "name", "year") VALUES ('Alice', 'rhs_d5b00b', 1);

INSERT INTO "personfriend" ("friend", "name", "year") VALUES ('rhs_d5b00b', 'per_e80dcc', NULL);

INSERT INTO "personfriend" ("friend", "name", "year") VALUES ('Alice', 'rhs_d5b00b', NULL);

INSERT INTO "personfriend" ("friend", "name", "year") VALUES ('per_e80dcc', 'per_e80dcc', -1068298341);

INSERT INTO "personfriend" ("friend", "name", "year") VALUES ('Alice', 'rhs_d5b00b', 1);

INSERT INTO "personfriend" ("friend", "name", "year") VALUES ('per_1ce8ed', 'per_e80dcc', 2074205376);

INSERT INTO "personfriend" ("friend", "name", "year") VALUES ('Alice', 'rhs_d5b00b', 1);

INSERT INTO "personfriend" ("friend", "name", "year") VALUES ('rhs_d5b00b', 'per_e80dcc', 2137741668);

INSERT INTO "personfriend" ("friend", "name", "year") VALUES ('Alice', 'rhs_d5b00b', 1);

INSERT INTO "personfriend" ("friend", "name", "year") VALUES ('rhs_f2cdcc', 'per_e80dcc', -525979501);

INSERT INTO "personfriend" ("friend", "name", "year") VALUES ('Alice', 'rhs_d5b00b', 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "name_other" AS "name" FROM (SELECT "LHS"."name" AS "name", "LHS"."age" AS "age", "LHS"."city" AS "city", "LHS"."gender" AS "gender", "LHS"."job" AS "job", "RHS"."name" AS "name_other", "RHS"."year" AS "year" FROM (SELECT * FROM "person" WHERE ("name" = 'Alice')) AS LHS INNER JOIN personfriend AS RHS ON (LHS.name = RHS.friend)) ORDER BY name;

/*
Gold Result:
('per_1ce8ed',)
('per_e80dcc',)
('per_e80dcc',)
('rhs_d5b00b',)
('rhs_d5b00b',)
('rhs_d5b00b',)
('rhs_d5b00b',)
('rhs_d5b00b',)
('rhs_d5b00b',)
('rhs_d5b00b',)
('rhs_d5b00b',)
('rhs_f2cdcc',)
*/

-- Prediction Query
SELECT DISTINCT T4.name FROM PersonFriend AS T1 JOIN Person AS T2 ON T1.name = T2.name JOIN PersonFriend AS T3 ON T1.friend = T3.name JOIN PersonFriend AS T4 ON T3.friend = T4.name WHERE T2.name = 'Alice' AND T4.name <> 'Alice';

/*
Prediction Result:
*/