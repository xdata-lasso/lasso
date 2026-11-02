-- Schema DDL
CREATE TABLE "department" ("Department_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Creation" TEXT, "Ranking" INTEGER, "Budget_in_Billions" REAL, "Num_Employees" REAL);

CREATE TABLE "head" ("head_ID" INTEGER PRIMARY KEY, "name" TEXT, "born_state" TEXT, "age" REAL);

CREATE TABLE "management" ("department_ID" INTEGER, "head_ID" INTEGER, "temporary_acting" TEXT, PRIMARY KEY ("department_ID", "head_ID"), FOREIGN KEY ("head_ID") REFERENCES "head" ("head_ID"), FOREIGN KEY ("department_ID") REFERENCES "department" ("Department_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: department --
INSERT INTO "department" ("department_id", "name", "creation", "ranking", "budget_in_billions", "num_employees") VALUES (1, 'Homeland Security', 'dep_46f8c9', 1, 1.0, 1.0);

INSERT INTO "department" ("department_id", "name", "creation", "ranking", "budget_in_billions", "num_employees") VALUES (-2147483647, 'Homeland Security', 'dep_74f8d9', 1, 1.0, 1.0);

INSERT INTO "department" ("department_id", "name", "creation", "ranking", "budget_in_billions", "num_employees") VALUES (2, 'lhs_f77f35', 'lhs_9fb07a', 1, 1.0, 1.0);

INSERT INTO "department" ("department_id", "name", "creation", "ranking", "budget_in_billions", "num_employees") VALUES (3, '4h', 'ia2yp', -1670923962, 663.049759, 711.020062);

-- Inserting into table: head --
INSERT INTO "head" ("head_id", "name", "born_state", "age") VALUES (1, 'hea_d1472c', '5k5swwqcgs', 171.746906);

INSERT INTO "head" ("head_id", "name", "born_state", "age") VALUES (-2147483647, 'hea_d1e237', 'n8c4pgu7v', 86.520366);

-- Inserting into table: management --
INSERT INTO "management" ("department_id", "head_id", "temporary_acting") VALUES (1, 1, 'rhs_eef812');

INSERT INTO "management" ("department_id", "head_id", "temporary_acting") VALUES (3, 1, 'rhs_eef812');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "born_state" FROM (SELECT "LHS"."department_id" AS "department_id", "LHS"."name" AS "name", "LHS"."creation" AS "creation", "LHS"."ranking" AS "ranking", "LHS"."budget_in_billions" AS "budget_in_billions", "LHS"."num_employees" AS "num_employees", "LHS"."head_id" AS "head_id", "LHS"."temporary_acting" AS "temporary_acting", "RHS"."name_other" AS "name_other", "RHS"."born_state" AS "born_state", "RHS"."age" AS "age" FROM (SELECT "LHS"."department_id" AS "department_id", "LHS"."name" AS "name", "LHS"."creation" AS "creation", "LHS"."ranking" AS "ranking", "LHS"."budget_in_billions" AS "budget_in_billions", "LHS"."num_employees" AS "num_employees", "RHS"."head_id" AS "head_id", "RHS"."temporary_acting" AS "temporary_acting" FROM "department" AS "LHS" INNER JOIN "management" AS "RHS" ON ("LHS"."department_id" = "RHS"."department_id")) AS "LHS" INNER JOIN (SELECT * FROM (SELECT "LHS"."department_id" AS "department_id", "LHS"."name" AS "name", "LHS"."creation" AS "creation", "LHS"."ranking" AS "ranking", "LHS"."budget_in_billions" AS "budget_in_billions", "LHS"."num_employees" AS "num_employees", "RHS"."head_id" AS "head_id", "RHS"."name" AS "name_other", "RHS"."born_state" AS "born_state", "RHS"."age" AS "age" FROM (SELECT * FROM "department" WHERE ("name" <> 'Treasury' AND "name" = 'Homeland Security')) AS LHS CROSS JOIN head AS RHS) WHERE (name <> name_other)) AS RHS ON (LHS.department_id = RHS.department_id AND LHS.name = RHS.name AND LHS.creation = RHS.creation AND LHS.ranking = RHS.ranking AND LHS.budget_in_billions = RHS.budget_in_billions AND LHS.num_employees = RHS.num_employees AND LHS.head_id = RHS.head_id)) ORDER BY born_state, "born_state" NULLS LAST;

/*
Gold Result:
('5k5swwqcgs',)
*/

-- Prediction Query
SELECT T3.born_state FROM department AS T1 JOIN management AS T2 ON T1.department_id = T2.department_id JOIN head AS T3 ON T2.head_id = T3.head_id WHERE T1.name = 'Treasury' INTERSECT SELECT T3.born_state FROM department AS T1 JOIN management AS T2 ON T1.department_id = T2.department_id JOIN head AS T3 ON T2.head_id = T3.head_id WHERE T1.name = 'Homeland Security';

/*
Prediction Result:
*/