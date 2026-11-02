-- Schema DDL
CREATE TABLE "department" ("Department_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Creation" TEXT, "Ranking" INTEGER, "Budget_in_Billions" REAL, "Num_Employees" REAL);

CREATE TABLE "head" ("head_ID" INTEGER PRIMARY KEY, "name" TEXT, "born_state" TEXT, "age" REAL);

CREATE TABLE "management" ("department_ID" INTEGER, "head_ID" INTEGER, "temporary_acting" TEXT, PRIMARY KEY ("department_ID", "head_ID"), FOREIGN KEY ("head_ID") REFERENCES "head" ("head_ID"), FOREIGN KEY ("department_ID") REFERENCES "department" ("Department_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: department --
INSERT INTO "department" ("department_id", "name", "creation", "ranking", "budget_in_billions", "num_employees") VALUES (1, 'dep_ac8671', '5k5swwqcgs', 247012447, 868.436572, 1.0);

INSERT INTO "department" ("department_id", "name", "creation", "ranking", "budget_in_billions", "num_employees") VALUES (-2147483647, 'dep_ac8671', 'c4pgu7vfe', -1633151678, 134.487977, 1.0);

INSERT INTO "department" ("department_id", "name", "creation", "ranking", "budget_in_billions", "num_employees") VALUES (2, '2', 'puzhsrw', 1908028688, 994.117864, 749.826493);

INSERT INTO "department" ("department_id", "name", "creation", "ranking", "budget_in_billions", "num_employees") VALUES (3, 'luhvdltti', 'bnp', 1236688122, 986.066566, 666.330692);

INSERT INTO "department" ("department_id", "name", "creation", "ranking", "budget_in_billions", "num_employees") VALUES (4, 'p', 'siie', -45536098, 933.422701, 345.718563);

INSERT INTO "department" ("department_id", "name", "creation", "ranking", "budget_in_billions", "num_employees") VALUES (5, 'klfa9000t', 'c4ecigce', -1585009206, 191.847248, 807.142508);

INSERT INTO "department" ("department_id", "name", "creation", "ranking", "budget_in_billions", "num_employees") VALUES (6, '2zbuo4nr', 'qrofqyp5s5b', 2107872094, 705.580387, 673.065986);

INSERT INTO "department" ("department_id", "name", "creation", "ranking", "budget_in_billions", "num_employees") VALUES (7, 'eutliqa11r', 'ytoo3o9', -1666765085, 731.301441, 691.846832);

INSERT INTO "department" ("department_id", "name", "creation", "ranking", "budget_in_billions", "num_employees") VALUES (8, '2klex14ji', '7zwau2dwyr', -1021749117, 591.461096, 998.887019);

INSERT INTO "department" ("department_id", "name", "creation", "ranking", "budget_in_billions", "num_employees") VALUES (9, 'u78d99r', 'jsl', -346339240, 470.165282, 384.969231);

INSERT INTO "department" ("department_id", "name", "creation", "ranking", "budget_in_billions", "num_employees") VALUES (10, '5qi2', 'kf9vq', 537874887, 698.16972, 690.435103);

INSERT INTO "department" ("department_id", "name", "creation", "ranking", "budget_in_billions", "num_employees") VALUES (11, '0f8jegd', '1vy9uxj4', -1612443122, 22.63964, 328.40866);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT creation FROM (SELECT department_id, name, creation, ranking, budget_in_billions, num_employees, name_other, department_id AS n FROM (SELECT LHS.department_id AS department_id, LHS.name AS name, LHS.creation AS creation, LHS.ranking AS ranking, LHS.budget_in_billions AS budget_in_billions, LHS.num_employees AS num_employees, RHS.name AS name_other FROM department AS LHS INNER JOIN (SELECT name, num_employees, COUNT(*) AS n FROM department GROUP BY name, num_employees) AS RHS ON (LHS.department_id = RHS.n AND LHS.num_employees = RHS.num_employees))) ORDER BY creation;

/*
Gold Result:
*/

-- Prediction Query
SELECT creation FROM department GROUP BY creation ORDER BY COUNT(*) DESC, creation NULLS LAST LIMIT 1;

/*
Prediction Result:
('1vy9uxj4',)
*/