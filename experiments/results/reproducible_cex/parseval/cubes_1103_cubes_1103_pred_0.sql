-- Schema DDL
CREATE TABLE "department" ("Department_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Creation" TEXT, "Ranking" INTEGER, "Budget_in_Billions" REAL, "Num_Employees" REAL);

CREATE TABLE "head" ("head_ID" INTEGER PRIMARY KEY, "name" TEXT, "born_state" TEXT, "age" REAL);

CREATE TABLE "management" ("department_ID" INTEGER, "head_ID" INTEGER, "temporary_acting" TEXT, PRIMARY KEY ("department_ID", "head_ID"), FOREIGN KEY ("head_ID") REFERENCES "head" ("head_ID"), FOREIGN KEY ("department_ID") REFERENCES "department" ("Department_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: department --
INSERT INTO "department" ("department_id", "name", "creation", "ranking", "budget_in_billions", "num_employees") VALUES (2, '5k5swwqcgs', 't1__92e80f', 247012447, 868.436572, 537.136345);

INSERT INTO "department" ("department_id", "name", "creation", "ranking", "budget_in_billions", "num_employees") VALUES (1, '4', 't1__92e80f', -734455130, 906.21648, 483.665643);

INSERT INTO "department" ("department_id", "name", "creation", "ranking", "budget_in_billions", "num_employees") VALUES (-2147483646, 'ilbnp', 't1__92e80f', 1236688122, 986.066566, 666.330692);

INSERT INTO "department" ("department_id", "name", "creation", "ranking", "budget_in_billions", "num_employees") VALUES (3, 'p', 'siie', -45536098, 933.422701, 345.718563);

INSERT INTO "department" ("department_id", "name", "creation", "ranking", "budget_in_billions", "num_employees") VALUES (-2147483644, 'o9hl72kl', 't1__92e80f', -305670381, 144.777217, 598.409165);

INSERT INTO "department" ("department_id", "name", "creation", "ranking", "budget_in_billions", "num_employees") VALUES (-2147483643, 'wau2dwy', 't1__92e80f', -953437896, 433.533777, 458.991081);

INSERT INTO "department" ("department_id", "name", "creation", "ranking", "budget_in_billions", "num_employees") VALUES (-2147483642, 'yu78', 't1__92e80f', 244829661, 182.777264, 943.791649);

INSERT INTO "department" ("department_id", "name", "creation", "ranking", "budget_in_billions", "num_employees") VALUES (-2147483641, 'p5qi2rkf9v', 't1__92e80f', 556727997, 860.770887, 774.274643);

INSERT INTO "department" ("department_id", "name", "creation", "ranking", "budget_in_billions", "num_employees") VALUES (-2147483640, 'pz0f8jegd', 't1__92e80f', -283454505, 390.34832, 585.585659);

INSERT INTO "department" ("department_id", "name", "creation", "ranking", "budget_in_billions", "num_employees") VALUES (4, 'n8c4pgu7v', 'e4', 1160656988, 268.82475, 710.998147);

-- Inserting into table: head --
INSERT INTO "head" ("head_id", "name", "born_state", "age") VALUES (1, 'hria2ypuzhs', 'Alabama', 663.049759);

INSERT INTO "head" ("head_id", "name", "born_state", "age") VALUES (2, 'c4ecigce', 'Alabama', 467.07027);

INSERT INTO "head" ("head_id", "name", "born_state", "age") VALUES (3, 'nium52zbu', '4nrq', 597.420508);

INSERT INTO "head" ("head_id", "name", "born_state", "age") VALUES (4, 's5bbp02e', 'tliqa1', 982.938576);

INSERT INTO "head" ("head_id", "name", "born_state", "age") VALUES (5, '5k5swwqcgs', NULL, 171.746906);

-- Inserting into table: management --
INSERT INTO "management" ("department_id", "head_id", "temporary_acting") VALUES (2, 1, 'wbbp6luhvdlt');

INSERT INTO "management" ("department_id", "head_id", "temporary_acting") VALUES (3, 1, 'klfa9000t');

INSERT INTO "management" ("department_id", "head_id", "temporary_acting") VALUES (2, 3, 'fqyp');

INSERT INTO "management" ("department_id", "head_id", "temporary_acting") VALUES (2, 4, 'yytoo');

INSERT INTO "management" ("department_id", "head_id", "temporary_acting") VALUES (1, 1, 'l0b4y');

INSERT INTO "management" ("department_id", "head_id", "temporary_acting") VALUES (4, 5, '2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "creation" FROM (SELECT "LHS"."department_id" AS "department_id", "LHS"."head_id" AS "head_id", "LHS"."temporary_acting" AS "temporary_acting", "RHS"."name" AS "name", "RHS"."creation" AS "creation", "RHS"."ranking" AS "ranking", "RHS"."budget_in_billions" AS "budget_in_billions", "RHS"."num_employees" AS "num_employees" FROM (SELECT * FROM "management" AS "LHS" WHERE EXISTS(SELECT 1 FROM (SELECT * FROM "head" WHERE ("born_state" = 'Alabama')) AS RHS WHERE (LHS.head_id = RHS.head_id))) AS LHS LEFT JOIN department AS RHS ON (LHS.department_id = RHS.department_id)) ORDER BY creation, "creation" NULLS LAST;

/*
Gold Result:
('siie',)
('t1__92e80f',)
('t1__92e80f',)
*/

-- Prediction Query
SELECT DISTINCT T1.creation FROM department AS T1 JOIN management AS T2 ON T1.department_id = T2.department_id JOIN head AS T3 ON T2.head_id = T3.head_id WHERE T3.born_state = 'Alabama';

/*
Prediction Result:
('t1__92e80f',)
('siie',)
*/