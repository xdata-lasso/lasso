-- Schema DDL
CREATE TABLE "department" ("Department_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Creation" TEXT, "Ranking" INTEGER, "Budget_in_Billions" REAL, "Num_Employees" REAL);

CREATE TABLE "head" ("head_ID" INTEGER PRIMARY KEY, "name" TEXT, "born_state" TEXT, "age" REAL);

CREATE TABLE "management" ("department_ID" INTEGER, "head_ID" INTEGER, "temporary_acting" TEXT, PRIMARY KEY ("department_ID", "head_ID"), FOREIGN KEY ("head_ID") REFERENCES "head" ("head_ID"), FOREIGN KEY ("department_ID") REFERENCES "department" ("Department_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO department (Department_ID, Name, Creation, Ranking, Budget_in_Billions, Num_Employees) VALUES (1, 'Treasury', '1789', 1, 10.5, 100.0);
INSERT INTO department (Department_ID, Name, Creation, Ranking, Budget_in_Billions, Num_Employees) VALUES (2, 'State', '1789', 2, 20.0, 100.0);
INSERT INTO department (Department_ID, Name, Creation, Ranking, Budget_in_Billions, Num_Employees) VALUES (3, 'Defense', '1947', 3, 500.0, 200.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT creation FROM (SELECT department_id, name, creation, ranking, budget_in_billions, num_employees, name_other, department_id AS n FROM (SELECT LHS.department_id AS department_id, LHS.name AS name, LHS.creation AS creation, LHS.ranking AS ranking, LHS.budget_in_billions AS budget_in_billions, LHS.num_employees AS num_employees, RHS.name AS name_other FROM department AS LHS INNER JOIN (SELECT name, num_employees, COUNT(*) AS n FROM department GROUP BY name, num_employees) AS RHS ON (LHS.department_id = RHS.n AND LHS.num_employees = RHS.num_employees))) ORDER BY creation;

/*
Gold Result:
('1789',)
('1789',)
*/

-- Prediction Query
SELECT creation FROM department GROUP BY creation ORDER BY COUNT(*) DESC, creation NULLS LAST LIMIT 1;

/*
Prediction Result:
('1789',)
*/