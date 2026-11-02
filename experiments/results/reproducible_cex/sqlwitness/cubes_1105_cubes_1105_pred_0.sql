-- Schema DDL
CREATE TABLE "department" ("Department_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Creation" TEXT, "Ranking" INTEGER, "Budget_in_Billions" REAL, "Num_Employees" REAL);

CREATE TABLE "head" ("head_ID" INTEGER PRIMARY KEY, "name" TEXT, "born_state" TEXT, "age" REAL);

CREATE TABLE "management" ("department_ID" INTEGER, "head_ID" INTEGER, "temporary_acting" TEXT, PRIMARY KEY ("department_ID", "head_ID"), FOREIGN KEY ("head_ID") REFERENCES "head" ("head_ID"), FOREIGN KEY ("department_ID") REFERENCES "department" ("Department_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO head (head_id, name, born_state, age) VALUES (0, 'default1', 'Yes', 0.0), (1, 'default2', 'Yes', 0.0), (2, NULL, 'default2', 1.0), (3, 'default2', 'default1', NULL), (4, NULL, 'default1', NULL), (5, 'default2', 'Yes', 0.0), (6, 'default1', 'Yes', NULL), (7, 'default2', 'default2', 0.0), (8, 'Yes', 'Yes', 0.0), (9, 'default1', 'default2', 0.0), (10, 'Yes', 'Yes', 0.0), (11, 'default1', 'default1', 1.0), (12, 'Yes', 'Yes', 1.0);
INSERT INTO department (department_id, name, creation, ranking, budget_in_billions, num_employees) VALUES (1, 'Yes', 'Yes', 1, 0.0, 1.0), (0, 'Yes', NULL, 1, 0.0, NULL), (2, NULL, 'default1', 0, NULL, 0.0), (3, 'default2', 'default1', 1, 1.0, NULL), (4, NULL, NULL, 1, 0.0, 0.0), (5, NULL, 'default1', 1, 1.0, NULL), (6, 'Yes', NULL, NULL, 0.0, 0.0), (7, NULL, 'default1', NULL, 0.0, 0.0), (8, 'Yes', 'Yes', 1, NULL, NULL), (9, 'default1', 'default2', 1, 0.0, 0.0);
INSERT INTO management (department_id, head_id, temporary_acting) VALUES (2, 11, 'default1'), (0, 3, 'default2'), (9, 1, NULL), (4, 10, 'default2'), (8, 12, 'Yes'), (3, 1, 'Yes'), (0, 11, 'default2'), (7, 0, 'default2'), (0, 1, 'Yes'), (9, 9, 'default1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "name", "num_employees" FROM (SELECT "LHS"."department_id" AS "department_id", "LHS"."head_id" AS "head_id", "LHS"."temporary_acting" AS "temporary_acting", "RHS"."department_id" AS "department_id_other", "RHS"."name" AS "name", "RHS"."creation" AS "creation", "RHS"."budget_in_billions" AS "budget_in_billions", "RHS"."num_employees" AS "num_employees" FROM (SELECT * FROM "management" WHERE ("temporary_acting" = 'Yes')) AS LHS INNER JOIN department AS RHS ON (LHS.department_id = RHS.ranking)) ORDER BY name, "name" NULLS LAST, "num_employees" NULLS LAST;

/*
Gold Result:
(None, 0.0)
*/

-- Prediction Query
SELECT T1.name, T1.num_employees FROM department AS T1 JOIN management AS T2 ON T1.department_id = T2.department_id WHERE T2.temporary_acting = 'Yes';

/*
Prediction Result:
('Yes', None)
('default2', None)
('Yes', None)
*/