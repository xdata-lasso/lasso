-- Schema DDL
CREATE TABLE "department" ("Department_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Creation" TEXT, "Ranking" INTEGER, "Budget_in_Billions" REAL, "Num_Employees" REAL);

CREATE TABLE "head" ("head_ID" INTEGER PRIMARY KEY, "name" TEXT, "born_state" TEXT, "age" REAL);

CREATE TABLE "management" ("department_ID" INTEGER, "head_ID" INTEGER, "temporary_acting" TEXT, PRIMARY KEY ("department_ID", "head_ID"), FOREIGN KEY ("head_ID") REFERENCES "head" ("head_ID"), FOREIGN KEY ("department_ID") REFERENCES "department" ("Department_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO head (head_id, name, born_state, age) VALUES (0, 'default1', NULL, NULL), (1, 'default2', 'Treasury', NULL), (2, 'default2', 'Treasury', 0.0), (3, 'Treasury', 'Treasury', 0.0), (4, 'default2', 'default2', 1.0), (5, NULL, NULL, 0.0), (6, 'default1', NULL, NULL), (7, 'default2', 'default2', 1.0), (8, 'default2', 'default2', 0.0), (9, 'default2', 'default2', 1.0), (10, NULL, NULL, 1.0);
INSERT INTO department (department_id, name, creation, ranking, budget_in_billions, num_employees) VALUES (0, NULL, 'default1', 0, 0.0, 0.0), (1, 'Homeland Security', 'default1', 1, 1.0, NULL), (2, 'Homeland Security', NULL, NULL, 1.0, 1.0), (3, 'Treasury', 'default1', 0, 0.0, 1.0), (4, 'default2', 'default2', 0, 0.0, NULL), (5, 'Homeland Security', 'Homeland Security', 0, 0.0, 1.0), (6, 'Treasury', 'Homeland Security', 0, 0.0, 1.0), (7, 'default2', NULL, 0, 0.0, NULL), (8, 'Homeland Security', 'default1', 1, 0.0, 0.0), (9, 'Homeland Security', 'default1', 1, 0.0, 0.0), (10, 'default1', NULL, 0, NULL, 0.0), (11, 'Homeland Security', 'Homeland Security', 0, NULL, NULL);
INSERT INTO management (department_id, head_id, temporary_acting) VALUES (11, 10, NULL), (5, 9, 'Treasury'), (7, 0, 'default1'), (2, 1, 'default1'), (11, 0, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "born_state" FROM (SELECT "LHS"."department_id" AS "department_id", "LHS"."name" AS "name", "LHS"."creation" AS "creation", "LHS"."ranking" AS "ranking", "LHS"."budget_in_billions" AS "budget_in_billions", "LHS"."num_employees" AS "num_employees", "LHS"."head_id" AS "head_id", "LHS"."temporary_acting" AS "temporary_acting", "RHS"."name_other" AS "name_other", "RHS"."born_state" AS "born_state", "RHS"."age" AS "age" FROM (SELECT "LHS"."department_id" AS "department_id", "LHS"."name" AS "name", "LHS"."creation" AS "creation", "LHS"."ranking" AS "ranking", "LHS"."budget_in_billions" AS "budget_in_billions", "LHS"."num_employees" AS "num_employees", "RHS"."head_id" AS "head_id", "RHS"."temporary_acting" AS "temporary_acting" FROM "department" AS "LHS" INNER JOIN "management" AS "RHS" ON ("LHS"."department_id" = "RHS"."department_id")) AS "LHS" INNER JOIN (SELECT * FROM (SELECT "LHS"."department_id" AS "department_id", "LHS"."name" AS "name", "LHS"."creation" AS "creation", "LHS"."ranking" AS "ranking", "LHS"."budget_in_billions" AS "budget_in_billions", "LHS"."num_employees" AS "num_employees", "RHS"."head_id" AS "head_id", "RHS"."name" AS "name_other", "RHS"."born_state" AS "born_state", "RHS"."age" AS "age" FROM (SELECT * FROM "department" WHERE ("name" <> 'Treasury' AND "name" = 'Homeland Security')) AS LHS CROSS JOIN head AS RHS) WHERE (name <> name_other)) AS RHS ON (LHS.department_id = RHS.department_id AND LHS.name = RHS.name AND LHS.creation = RHS.creation AND LHS.ranking = RHS.ranking AND LHS.budget_in_billions = RHS.budget_in_billions AND LHS.num_employees = RHS.num_employees AND LHS.head_id = RHS.head_id)) ORDER BY born_state, "born_state" NULLS LAST;

/*
Gold Result:
('default2',)
*/

-- Prediction Query
SELECT T3.born_state FROM department AS T1 JOIN management AS T2 ON T1.department_id = T2.department_id JOIN head AS T3 ON T2.head_id = T3.head_id WHERE T1.name = 'Treasury' INTERSECT SELECT T3.born_state FROM department AS T1 JOIN management AS T2 ON T1.department_id = T2.department_id JOIN head AS T3 ON T2.head_id = T3.head_id WHERE T1.name = 'Homeland Security';

/*
Prediction Result:
*/