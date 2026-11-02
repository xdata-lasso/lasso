-- Schema DDL
CREATE TABLE "department" ("Department_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Creation" TEXT, "Ranking" INTEGER, "Budget_in_Billions" REAL, "Num_Employees" REAL);

CREATE TABLE "head" ("head_ID" INTEGER PRIMARY KEY, "name" TEXT, "born_state" TEXT, "age" REAL);

CREATE TABLE "management" ("department_ID" INTEGER, "head_ID" INTEGER, "temporary_acting" TEXT, PRIMARY KEY ("department_ID", "head_ID"), FOREIGN KEY ("head_ID") REFERENCES "head" ("head_ID"), FOREIGN KEY ("department_ID") REFERENCES "department" ("Department_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO department (department_id, name, creation, ranking, budget_in_billions, num_employees) VALUES (0, 'default2', 'default2', 1, NULL, 1.0), (1, 'default2', NULL, 0, NULL, 1.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT creation, name, budget_in_billions FROM department ORDER BY creation, department.department_id NULLS LAST;

/*
Gold Result:
(None, 'default2', None)
('default2', 'default2', None)
*/

-- Prediction Query
SELECT creation, name, budget_in_billions FROM department;

/*
Prediction Result:
('default2', 'default2', None)
(None, 'default2', None)
*/