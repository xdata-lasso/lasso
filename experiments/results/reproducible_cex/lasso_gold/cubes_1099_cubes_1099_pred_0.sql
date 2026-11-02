-- Schema DDL
CREATE TABLE "department" ("Department_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Creation" TEXT, "Ranking" INTEGER, "Budget_in_Billions" REAL, "Num_Employees" REAL);

CREATE TABLE "head" ("head_ID" INTEGER PRIMARY KEY, "name" TEXT, "born_state" TEXT, "age" REAL);

CREATE TABLE "management" ("department_ID" INTEGER, "head_ID" INTEGER, "temporary_acting" TEXT, PRIMARY KEY ("department_ID", "head_ID"), FOREIGN KEY ("head_ID") REFERENCES "head" ("head_ID"), FOREIGN KEY ("department_ID") REFERENCES "department" ("Department_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "department" ("department_id", "name", "creation", "ranking", "budget_in_billions", "num_employees") VALUES (1010, 'Javier Johnson', 'rate', 1011, 1012.5, 1013.5);
INSERT INTO "department" ("department_id", "name", "creation", "ranking", "budget_in_billions", "num_employees") VALUES (1014, 'Lance Hoffman', 'discover', 1012, 1013.5, 1014.5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT creation, name, budget_in_billions FROM department ORDER BY creation, department.department_id NULLS LAST;

/*
Gold Result:
('discover', 'Lance Hoffman', 1013.5)
('rate', 'Javier Johnson', 1012.5)
*/

-- Prediction Query
SELECT creation, name, budget_in_billions FROM department;

/*
Prediction Result:
('rate', 'Javier Johnson', 1012.5)
('discover', 'Lance Hoffman', 1013.5)
*/