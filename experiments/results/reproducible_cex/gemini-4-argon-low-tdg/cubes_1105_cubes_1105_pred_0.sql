-- Schema DDL
CREATE TABLE "department" ("Department_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Creation" TEXT, "Ranking" INTEGER, "Budget_in_Billions" REAL, "Num_Employees" REAL);

CREATE TABLE "head" ("head_ID" INTEGER PRIMARY KEY, "name" TEXT, "born_state" TEXT, "age" REAL);

CREATE TABLE "management" ("department_ID" INTEGER, "head_ID" INTEGER, "temporary_acting" TEXT, PRIMARY KEY ("department_ID", "head_ID"), FOREIGN KEY ("head_ID") REFERENCES "head" ("head_ID"), FOREIGN KEY ("department_ID") REFERENCES "department" ("Department_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "department" ("Department_ID", "Name", "Creation", "Ranking", "Budget_in_Billions", "Num_Employees") VALUES (1, 'Dept A', '1990', 2, 10.5, 100.0);
INSERT INTO "department" ("Department_ID", "Name", "Creation", "Ranking", "Budget_in_Billions", "Num_Employees") VALUES (2, 'Dept B', '1995', 1, 20.0, 200.0);
INSERT INTO "department" ("Department_ID", "Name", "Creation", "Ranking", "Budget_in_Billions", "Num_Employees") VALUES (3, 'Dept C', '2000', 4, 30.0, 300.0);
INSERT INTO "head" ("head_ID", "name", "born_state", "age") VALUES (10, 'Alice', 'CA', 45.0);
INSERT INTO "head" ("head_ID", "name", "born_state", "age") VALUES (20, 'Bob', 'NY', 50.0);
INSERT INTO "management" ("department_ID", "head_ID", "temporary_acting") VALUES (1, 10, 'Yes');
INSERT INTO "management" ("department_ID", "head_ID", "temporary_acting") VALUES (3, 20, 'Yes');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "name", "num_employees" FROM (SELECT "LHS"."department_id" AS "department_id", "LHS"."head_id" AS "head_id", "LHS"."temporary_acting" AS "temporary_acting", "RHS"."department_id" AS "department_id_other", "RHS"."name" AS "name", "RHS"."creation" AS "creation", "RHS"."budget_in_billions" AS "budget_in_billions", "RHS"."num_employees" AS "num_employees" FROM (SELECT * FROM "management" WHERE ("temporary_acting" = 'Yes')) AS LHS INNER JOIN department AS RHS ON (LHS.department_id = RHS.ranking)) ORDER BY name, "name" NULLS LAST, "num_employees" NULLS LAST;

/*
Gold Result:
('Dept B', 200.0)
*/

-- Prediction Query
SELECT T1.name, T1.num_employees FROM department AS T1 JOIN management AS T2 ON T1.department_id = T2.department_id WHERE T2.temporary_acting = 'Yes';

/*
Prediction Result:
('Dept A', 100.0)
('Dept C', 300.0)
*/