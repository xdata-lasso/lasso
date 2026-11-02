-- Schema DDL
CREATE TABLE "department" ("Department_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Creation" TEXT, "Ranking" INTEGER, "Budget_in_Billions" REAL, "Num_Employees" REAL);

CREATE TABLE "head" ("head_ID" INTEGER PRIMARY KEY, "name" TEXT, "born_state" TEXT, "age" REAL);

CREATE TABLE "management" ("department_ID" INTEGER, "head_ID" INTEGER, "temporary_acting" TEXT, PRIMARY KEY ("department_ID", "head_ID"), FOREIGN KEY ("head_ID") REFERENCES "head" ("head_ID"), FOREIGN KEY ("department_ID") REFERENCES "department" ("Department_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "department" ("Department_ID", "Name", "Creation", "Ranking", "Budget_in_Billions", "Num_Employees") VALUES (1, 'Homeland Security', '2002', 1, 50.5, 240000.0);
INSERT INTO "department" ("Department_ID", "Name", "Creation", "Ranking", "Budget_in_Billions", "Num_Employees") VALUES (2, 'Treasury', '1789', 2, 15.0, 86000.0);
INSERT INTO "department" ("Department_ID", "Name", "Creation", "Ranking", "Budget_in_Billions", "Num_Employees") VALUES (3, 'Defense', '1947', 3, 700.0, 2800000.0);
INSERT INTO "head" ("head_ID", "name", "born_state", "age") VALUES (10, 'John Kelly', 'Massachusetts', 67.0);
INSERT INTO "head" ("head_ID", "name", "born_state", "age") VALUES (20, 'Kirstjen Nielsen', 'Colorado', 45.0);
INSERT INTO "head" ("head_ID", "name", "born_state", "age") VALUES (30, 'Janet Yellen', 'New York', 75.0);
INSERT INTO "head" ("head_ID", "name", "born_state", "age") VALUES (40, 'Lloyd Austin', 'Alabama', 68.0);
INSERT INTO "head" ("head_ID", "name", "born_state", "age") VALUES (50, 'Unassigned Head', 'Texas', 50.0);
INSERT INTO "management" ("department_ID", "head_ID", "temporary_acting") VALUES (1, 10, 'No');
INSERT INTO "management" ("department_ID", "head_ID", "temporary_acting") VALUES (1, 20, 'Yes');
INSERT INTO "management" ("department_ID", "head_ID", "temporary_acting") VALUES (2, 30, 'No');
INSERT INTO "management" ("department_ID", "head_ID", "temporary_acting") VALUES (3, 40, 'No');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "born_state" FROM (SELECT "LHS"."department_id" AS "department_id", "LHS"."name" AS "name", "LHS"."creation" AS "creation", "LHS"."ranking" AS "ranking", "LHS"."budget_in_billions" AS "budget_in_billions", "LHS"."num_employees" AS "num_employees", "LHS"."head_id" AS "head_id", "LHS"."temporary_acting" AS "temporary_acting", "RHS"."name_other" AS "name_other", "RHS"."born_state" AS "born_state", "RHS"."age" AS "age" FROM (SELECT "LHS"."department_id" AS "department_id", "LHS"."name" AS "name", "LHS"."creation" AS "creation", "LHS"."ranking" AS "ranking", "LHS"."budget_in_billions" AS "budget_in_billions", "LHS"."num_employees" AS "num_employees", "RHS"."head_id" AS "head_id", "RHS"."temporary_acting" AS "temporary_acting" FROM "department" AS "LHS" INNER JOIN "management" AS "RHS" ON ("LHS"."department_id" = "RHS"."department_id")) AS "LHS" INNER JOIN (SELECT * FROM (SELECT "LHS"."department_id" AS "department_id", "LHS"."name" AS "name", "LHS"."creation" AS "creation", "LHS"."ranking" AS "ranking", "LHS"."budget_in_billions" AS "budget_in_billions", "LHS"."num_employees" AS "num_employees", "RHS"."head_id" AS "head_id", "RHS"."name" AS "name_other", "RHS"."born_state" AS "born_state", "RHS"."age" AS "age" FROM (SELECT * FROM "department" WHERE ("name" <> 'Treasury' AND "name" = 'Homeland Security')) AS LHS CROSS JOIN head AS RHS) WHERE (name <> name_other)) AS RHS ON (LHS.department_id = RHS.department_id AND LHS.name = RHS.name AND LHS.creation = RHS.creation AND LHS.ranking = RHS.ranking AND LHS.budget_in_billions = RHS.budget_in_billions AND LHS.num_employees = RHS.num_employees AND LHS.head_id = RHS.head_id)) ORDER BY born_state, "born_state" NULLS LAST;

/*
Gold Result:
('Colorado',)
('Massachusetts',)
*/

-- Prediction Query
SELECT T3.born_state FROM department AS T1 JOIN management AS T2 ON T1.department_id = T2.department_id JOIN head AS T3 ON T2.head_id = T3.head_id WHERE T1.name = 'Treasury' INTERSECT SELECT T3.born_state FROM department AS T1 JOIN management AS T2 ON T1.department_id = T2.department_id JOIN head AS T3 ON T2.head_id = T3.head_id WHERE T1.name = 'Homeland Security';

/*
Prediction Result:
*/