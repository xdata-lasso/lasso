-- Schema DDL
CREATE TABLE "department" ("Department_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Creation" TEXT, "Ranking" INTEGER, "Budget_in_Billions" REAL, "Num_Employees" REAL);

CREATE TABLE "head" ("head_ID" INTEGER PRIMARY KEY, "name" TEXT, "born_state" TEXT, "age" REAL);

CREATE TABLE "management" ("department_ID" INTEGER, "head_ID" INTEGER, "temporary_acting" TEXT, PRIMARY KEY ("department_ID", "head_ID"), FOREIGN KEY ("head_ID") REFERENCES "head" ("head_ID"), FOREIGN KEY ("department_ID") REFERENCES "department" ("Department_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "department" ("Department_ID", "Name", "Creation", "Ranking", "Budget_in_Billions", "Num_Employees") VALUES (10, 'Sales', '1995', 3, 12.5, 300.0);
INSERT INTO "department" ("Department_ID", "Name", "Creation", "Ranking", "Budget_in_Billions", "Num_Employees") VALUES (2, 'Engineering', '1995', 1, 50.0, 1200.0);
INSERT INTO "department" ("Department_ID", "Name", "Creation", "Ranking", "Budget_in_Billions", "Num_Employees") VALUES (5, 'HR', '2001', 2, 5.2, 50.0);
INSERT INTO "department" ("Department_ID", "Name", "Creation", "Ranking", "Budget_in_Billions", "Num_Employees") VALUES (1, 'Marketing', '1980', 4, 25.0, 400.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT creation, name, budget_in_billions FROM department ORDER BY creation, department.department_id NULLS LAST;

/*
Gold Result:
('1980', 'Marketing', 25.0)
('1995', 'Engineering', 50.0)
('1995', 'Sales', 12.5)
('2001', 'HR', 5.2)
*/

-- Prediction Query
SELECT creation, name, budget_in_billions FROM department;

/*
Prediction Result:
('1980', 'Marketing', 25.0)
('1995', 'Engineering', 50.0)
('2001', 'HR', 5.2)
('1995', 'Sales', 12.5)
*/