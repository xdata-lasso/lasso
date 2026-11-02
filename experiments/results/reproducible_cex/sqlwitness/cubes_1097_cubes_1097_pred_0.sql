-- Schema DDL
CREATE TABLE "department" ("Department_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Creation" TEXT, "Ranking" INTEGER, "Budget_in_Billions" REAL, "Num_Employees" REAL);

CREATE TABLE "head" ("head_ID" INTEGER PRIMARY KEY, "name" TEXT, "born_state" TEXT, "age" REAL);

CREATE TABLE "management" ("department_ID" INTEGER, "head_ID" INTEGER, "temporary_acting" TEXT, PRIMARY KEY ("department_ID", "head_ID"), FOREIGN KEY ("head_ID") REFERENCES "head" ("head_ID"), FOREIGN KEY ("department_ID") REFERENCES "department" ("Department_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO head (head_id, name, born_state, age) VALUES (1, 'default2', 'default2', 0.0), (0, 'default2', 'default1', NULL), (2, 'default1', 'default1', 1.0), (3, NULL, 'default1', NULL), (4, 'Yes', 'default1', 1.0), (5, NULL, 'Yes', NULL), (6, NULL, 'default1', 0.0), (7, 'default1', NULL, 1.0), (8, 'default1', NULL, 0.0), (9, NULL, 'default1', NULL), (10, NULL, 'default1', 0.0), (11, NULL, 'Yes', NULL), (12, 'default1', 'default1', 0.0), (13, 'Yes', 'default2', 1.0), (14, NULL, 'default2', 1.0), (15, 'Yes', 'Yes', 1.0), (16, NULL, 'Yes', NULL), (17, 'default1', 'default2', 1.0);
INSERT INTO department (department_id, name, creation, ranking, budget_in_billions, num_employees) VALUES (1, 'default1', NULL, NULL, 1.0, NULL), (0, NULL, NULL, NULL, 1.0, 0.0), (2, 'Yes', NULL, 1, 1.0, NULL), (3, 'default2', 'default2', 0, NULL, NULL), (4, 'default2', 'Yes', 0, NULL, 0.0), (5, 'default2', 'default2', 0, NULL, 0.0), (6, NULL, 'default2', 1, 0.0, NULL), (7, 'default2', 'default2', 0, 0.0, 0.0), (8, NULL, 'default2', NULL, 0.0, 0.0), (9, 'Yes', 'default2', NULL, 1.0, 0.0), (10, NULL, 'Yes', 1, 0.0, NULL), (11, 'default2', NULL, 0, NULL, 0.0), (12, 'Yes', 'default2', NULL, NULL, 0.0), (13, 'Yes', 'Yes', 1, 0.0, 0.0), (14, 'Yes', 'default1', 1, 0.0, 1.0), (15, 'default1', 'default1', 0, 1.0, 0.0);
INSERT INTO management (department_id, head_id, temporary_acting) VALUES (2, 17, 'Yes'), (8, 0, 'default2'), (5, 16, 'default2'), (6, 12, 'default1'), (8, 5, 'Yes'), (15, 6, 'Yes');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "age" FROM (SELECT "LHS"."head_id" AS "head_id", "LHS"."name" AS "name", "LHS"."born_state" AS "born_state", "LHS"."age" AS "age", "RHS"."department_id" AS "department_id", "RHS"."temporary_acting" AS "temporary_acting" FROM "head" AS "LHS" INNER JOIN "management" AS "RHS" ON ("LHS"."head_id" = "RHS"."head_id")) WHERE ("temporary_acting" = 'Yes') ORDER BY age, "age" NULLS LAST;

/*
Gold Result:
(None,)
(0.0,)
(1.0,)
*/

-- Prediction Query
SELECT DISTINCT T1.age FROM management AS T2 JOIN head AS T1 ON T1.head_id = T2.head_id WHERE T2.temporary_acting = 'Yes';

/*
Prediction Result:
(1.0,)
(None,)
(0.0,)
*/