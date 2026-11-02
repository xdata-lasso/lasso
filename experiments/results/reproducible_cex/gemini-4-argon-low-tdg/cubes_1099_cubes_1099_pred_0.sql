-- Schema DDL
CREATE TABLE "department" ("Department_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Creation" TEXT, "Ranking" INTEGER, "Budget_in_Billions" REAL, "Num_Employees" REAL);

CREATE TABLE "head" ("head_ID" INTEGER PRIMARY KEY, "name" TEXT, "born_state" TEXT, "age" REAL);

CREATE TABLE "management" ("department_ID" INTEGER, "head_ID" INTEGER, "temporary_acting" TEXT, PRIMARY KEY ("department_ID", "head_ID"), FOREIGN KEY ("head_ID") REFERENCES "head" ("head_ID"), FOREIGN KEY ("department_ID") REFERENCES "department" ("Department_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "department" ("Department_ID", "Name", "Creation", "Ranking", "Budget_in_Billions", "Num_Employees") VALUES (10, 'State', '1789', 1, 50.5, 10000.0);
INSERT INTO "department" ("Department_ID", "Name", "Creation", "Ranking", "Budget_in_Billions", "Num_Employees") VALUES (2, 'Treasury', '1789', 2, 15.2, 85000.0);
INSERT INTO "department" ("Department_ID", "Name", "Creation", "Ranking", "Budget_in_Billions", "Num_Employees") VALUES (5, 'Defense', '1947', 3, 700.0, 2000000.0);
INSERT INTO "department" ("Department_ID", "Name", "Creation", "Ranking", "Budget_in_Billions", "Num_Employees") VALUES (1, 'Energy', '1977', 4, 30.1, 14000.0);
INSERT INTO "head" ("head_ID", "name", "born_state", "age") VALUES (101, 'Alice Smith', 'NY', 55.0);
INSERT INTO "head" ("head_ID", "name", "born_state", "age") VALUES (102, 'Bob Jones', 'CA', 62.0);
INSERT INTO "management" ("department_ID", "head_ID", "temporary_acting") VALUES (10, 101, 'No');
INSERT INTO "management" ("department_ID", "head_ID", "temporary_acting") VALUES (10, 102, 'Yes');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT creation, name, budget_in_billions FROM department ORDER BY creation, department.department_id NULLS LAST;

/*
Gold Result:
('1789', 'Treasury', 15.2)
('1789', 'State', 50.5)
('1947', 'Defense', 700.0)
('1977', 'Energy', 30.1)
*/

-- Prediction Query
SELECT creation, name, budget_in_billions FROM department;

/*
Prediction Result:
('1977', 'Energy', 30.1)
('1789', 'Treasury', 15.2)
('1947', 'Defense', 700.0)
('1789', 'State', 50.5)
*/