-- Schema DDL
CREATE TABLE "department" ("Department_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Creation" TEXT, "Ranking" INTEGER, "Budget_in_Billions" REAL, "Num_Employees" REAL);

CREATE TABLE "head" ("head_ID" INTEGER PRIMARY KEY, "name" TEXT, "born_state" TEXT, "age" REAL);

CREATE TABLE "management" ("department_ID" INTEGER, "head_ID" INTEGER, "temporary_acting" TEXT, PRIMARY KEY ("department_ID", "head_ID"), FOREIGN KEY ("head_ID") REFERENCES "head" ("head_ID"), FOREIGN KEY ("department_ID") REFERENCES "department" ("Department_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO head (head_id, name, born_state, age) VALUES (0, 'default2', 'Alabama', 1.0), (1, 'default1', 'default2', NULL), (2, 'default1', NULL, 2.0);
INSERT INTO department (department_id, name, creation, ranking, budget_in_billions, num_employees) VALUES (0, 'default2', 'default1', 2, NULL, 0.0), (2, 'default1', NULL, 1, NULL, NULL), (1, 'default1', 'Alabama', 0, NULL, 1.0), (3, 'Alabama', 'default1', 1, NULL, 0.0), (4, 'default2', 'default2', 2, NULL, NULL), (5, 'default2', 'default2', 1, NULL, NULL), (6, NULL, NULL, 2, NULL, 2.0);
INSERT INTO management (department_id, head_id, temporary_acting) VALUES (3, 0, 'default1'), (6, 2, 'default2'), (6, 0, 'default1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "creation" FROM (SELECT "LHS"."department_id" AS "department_id", "LHS"."head_id" AS "head_id", "LHS"."temporary_acting" AS "temporary_acting", "RHS"."name" AS "name", "RHS"."creation" AS "creation", "RHS"."ranking" AS "ranking", "RHS"."budget_in_billions" AS "budget_in_billions", "RHS"."num_employees" AS "num_employees" FROM (SELECT * FROM "management" AS "LHS" WHERE EXISTS(SELECT 1 FROM (SELECT * FROM "head" WHERE ("born_state" = 'Alabama')) AS RHS WHERE (LHS.head_id = RHS.head_id))) AS LHS LEFT JOIN department AS RHS ON (LHS.department_id = RHS.department_id)) ORDER BY creation, "creation" NULLS LAST;

/*
Gold Result:
(None,)
('default1',)
*/

-- Prediction Query
SELECT DISTINCT T1.creation FROM department AS T1 JOIN management AS T2 ON T1.department_id = T2.department_id JOIN head AS T3 ON T2.head_id = T3.head_id WHERE T3.born_state = 'Alabama';

/*
Prediction Result:
('default1',)
(None,)
*/