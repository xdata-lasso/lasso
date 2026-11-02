-- Schema DDL
CREATE TABLE "department" ("Department_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Creation" TEXT, "Ranking" INTEGER, "Budget_in_Billions" REAL, "Num_Employees" REAL);

CREATE TABLE "head" ("head_ID" INTEGER PRIMARY KEY, "name" TEXT, "born_state" TEXT, "age" REAL);

CREATE TABLE "management" ("department_ID" INTEGER, "head_ID" INTEGER, "temporary_acting" TEXT, PRIMARY KEY ("department_ID", "head_ID"), FOREIGN KEY ("head_ID") REFERENCES "head" ("head_ID"), FOREIGN KEY ("department_ID") REFERENCES "department" ("Department_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic join, born_state filtering (exact match vs case/substring/NULL), and ORDER BY with NULLS LAST
INSERT INTO "department" ("Department_ID", "Name", "Creation", "Ranking", "Budget_in_Billions", "Num_Employees") VALUES (1, 'Treasury', '1789', 1, 10.5, 100.0);
INSERT INTO "department" ("Department_ID", "Name", "Creation", "Ranking", "Budget_in_Billions", "Num_Employees") VALUES (2, 'Defense', '1947', 2, 700.0, 2000.0);
INSERT INTO "department" ("Department_ID", "Name", "Creation", "Ranking", "Budget_in_Billions", "Num_Employees") VALUES (3, 'Education', NULL, 3, 68.0, 400.0);
INSERT INTO "department" ("Department_ID", "Name", "Creation", "Ranking", "Budget_in_Billions", "Num_Employees") VALUES (4, 'Energy', '1977', 4, 30.0, 150.0);
INSERT INTO "head" ("head_ID", "name", "born_state", "age") VALUES (10, 'Alice', 'Alabama', 50.0);
INSERT INTO "head" ("head_ID", "name", "born_state", "age") VALUES (20, 'Bob', 'Alaska', 55.0);
INSERT INTO "head" ("head_ID", "name", "born_state", "age") VALUES (30, 'Charlie', 'alabama', 60.0);
INSERT INTO "head" ("head_ID", "name", "born_state", "age") VALUES (40, 'David', NULL, 45.0);
INSERT INTO "head" ("head_ID", "name", "born_state", "age") VALUES (50, 'Eve', 'Alabama', 40.0);
INSERT INTO "management" ("department_ID", "head_ID", "temporary_acting") VALUES (2, 10, 'No');
INSERT INTO "management" ("department_ID", "head_ID", "temporary_acting") VALUES (1, 50, 'Yes');
INSERT INTO "management" ("department_ID", "head_ID", "temporary_acting") VALUES (3, 10, 'Yes');
INSERT INTO "management" ("department_ID", "head_ID", "temporary_acting") VALUES (4, 20, 'No');
INSERT INTO "management" ("department_ID", "head_ID", "temporary_acting") VALUES (4, 30, 'Yes');
INSERT INTO "management" ("department_ID", "head_ID", "temporary_acting") VALUES (4, 40, 'No');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "creation" FROM (SELECT "LHS"."department_id" AS "department_id", "LHS"."head_id" AS "head_id", "LHS"."temporary_acting" AS "temporary_acting", "RHS"."name" AS "name", "RHS"."creation" AS "creation", "RHS"."ranking" AS "ranking", "RHS"."budget_in_billions" AS "budget_in_billions", "RHS"."num_employees" AS "num_employees" FROM (SELECT * FROM "management" AS "LHS" WHERE EXISTS(SELECT 1 FROM (SELECT * FROM "head" WHERE ("born_state" = 'Alabama')) AS RHS WHERE (LHS.head_id = RHS.head_id))) AS LHS LEFT JOIN department AS RHS ON (LHS.department_id = RHS.department_id)) ORDER BY creation, "creation" NULLS LAST;

/*
Gold Result:
(None,)
('1789',)
('1947',)
*/

-- Prediction Query
SELECT DISTINCT T1.creation FROM department AS T1 JOIN management AS T2 ON T1.department_id = T2.department_id JOIN head AS T3 ON T2.head_id = T3.head_id WHERE T3.born_state = 'Alabama';

/*
Prediction Result:
('1789',)
('1947',)
(None,)
*/