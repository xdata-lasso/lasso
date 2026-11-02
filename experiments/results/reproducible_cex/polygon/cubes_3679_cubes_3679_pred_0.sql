-- Schema DDL
CREATE TABLE "department" ("Department_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Creation" TEXT, "Ranking" INTEGER, "Budget_in_Billions" REAL, "Num_Employees" REAL);

CREATE TABLE "head" ("head_ID" INTEGER PRIMARY KEY, "name" TEXT, "born_state" TEXT, "age" REAL);

CREATE TABLE "management" ("department_ID" INTEGER, "head_ID" INTEGER, "temporary_acting" TEXT, PRIMARY KEY ("department_ID", "head_ID"), FOREIGN KEY ("head_ID") REFERENCES "head" ("head_ID"), FOREIGN KEY ("department_ID") REFERENCES "department" ("Department_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "department" ("department_id", "name", "creation", "ranking", "budget_in_billions", "num_employees") VALUES (10, NULL, '17', 1, 1, 23);
INSERT INTO "department" ("department_id", "name", "creation", "ranking", "budget_in_billions", "num_employees") VALUES (1, '20', '18', 21, 22, 23);
INSERT INTO "head" ("head_id", "name", "born_state", "age") VALUES (12, '1', '1', 1);
INSERT INTO "head" ("head_id", "name", "born_state", "age") VALUES (11, '1', '1', 1);
INSERT INTO "management" ("department_id", "head_id", "temporary_acting") VALUES (1, 12, '1');
INSERT INTO "management" ("department_id", "head_id", "temporary_acting") VALUES (10, 12, '1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT creation FROM (SELECT department_id, name, creation, ranking, budget_in_billions, num_employees, name_other, department_id AS n FROM (SELECT LHS.department_id AS department_id, LHS.name AS name, LHS.creation AS creation, LHS.ranking AS ranking, LHS.budget_in_billions AS budget_in_billions, LHS.num_employees AS num_employees, RHS.name AS name_other FROM department AS LHS INNER JOIN (SELECT name, num_employees, COUNT(*) AS n FROM department GROUP BY name, num_employees) AS RHS ON (LHS.department_id = RHS.n AND LHS.num_employees = RHS.num_employees))) ORDER BY creation;

/*
Gold Result:
('18',)
('18',)
*/

-- Prediction Query
SELECT creation FROM department GROUP BY creation ORDER BY COUNT(*) DESC, creation NULLS LAST LIMIT 1;

/*
Prediction Result:
('17',)
*/