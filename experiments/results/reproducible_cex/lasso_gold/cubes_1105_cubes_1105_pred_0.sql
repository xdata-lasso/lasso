-- Schema DDL
CREATE TABLE "department" ("Department_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Creation" TEXT, "Ranking" INTEGER, "Budget_in_Billions" REAL, "Num_Employees" REAL);

CREATE TABLE "head" ("head_ID" INTEGER PRIMARY KEY, "name" TEXT, "born_state" TEXT, "age" REAL);

CREATE TABLE "management" ("department_ID" INTEGER, "head_ID" INTEGER, "temporary_acting" TEXT, PRIMARY KEY ("department_ID", "head_ID"), FOREIGN KEY ("head_ID") REFERENCES "head" ("head_ID"), FOREIGN KEY ("department_ID") REFERENCES "department" ("Department_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "department" ("department_id", "name", "creation", "ranking", "budget_in_billions", "num_employees") VALUES (1026, 'Lisa Hensley', 'participant', 1026, 1027.5, 1028.5);
INSERT INTO "department" ("department_id", "name", "creation", "ranking", "budget_in_billions", "num_employees") VALUES (1031, 'Lisa Hensley', 'participant', 1032, 1027.5, 1028.5);
INSERT INTO "department" ("department_id", "name", "creation", "ranking", "budget_in_billions", "num_employees") VALUES (1032, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "head" ("head_id", "name", "born_state", "age") VALUES (1029, 'Benjamin Stanley', 'Wyoming', 1030.5);
INSERT INTO "head" ("head_id", "name", "born_state", "age") VALUES (1033, NULL, NULL, NULL);
INSERT INTO "management" ("department_id", "head_id", "temporary_acting") VALUES (1026, 1029, 'Yes');
INSERT INTO "management" ("department_id", "head_id", "temporary_acting") VALUES (1032, 1033, 'Yes');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "name", "num_employees" FROM (SELECT "LHS"."department_id" AS "department_id", "LHS"."head_id" AS "head_id", "LHS"."temporary_acting" AS "temporary_acting", "RHS"."department_id" AS "department_id_other", "RHS"."name" AS "name", "RHS"."creation" AS "creation", "RHS"."budget_in_billions" AS "budget_in_billions", "RHS"."num_employees" AS "num_employees" FROM (SELECT * FROM "management" WHERE ("temporary_acting" = 'Yes')) AS LHS INNER JOIN department AS RHS ON (LHS.department_id = RHS.ranking)) ORDER BY name, "name" NULLS LAST, "num_employees" NULLS LAST;

/*
Gold Result:
('Lisa Hensley', 1028.5)
('Lisa Hensley', 1028.5)
*/

-- Prediction Query
SELECT T1.name, T1.num_employees FROM department AS T1 JOIN management AS T2 ON T1.department_id = T2.department_id WHERE T2.temporary_acting = 'Yes';

/*
Prediction Result:
('Lisa Hensley', 1028.5)
(None, None)
*/