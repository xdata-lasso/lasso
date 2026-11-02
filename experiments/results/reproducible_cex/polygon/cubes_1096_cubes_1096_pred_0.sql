-- Schema DDL
CREATE TABLE "department" ("Department_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Creation" TEXT, "Ranking" INTEGER, "Budget_in_Billions" REAL, "Num_Employees" REAL);

CREATE TABLE "head" ("head_ID" INTEGER PRIMARY KEY, "name" TEXT, "born_state" TEXT, "age" REAL);

CREATE TABLE "management" ("department_ID" INTEGER, "head_ID" INTEGER, "temporary_acting" TEXT, PRIMARY KEY ("department_ID", "head_ID"), FOREIGN KEY ("head_ID") REFERENCES "head" ("head_ID"), FOREIGN KEY ("department_ID") REFERENCES "department" ("Department_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "department" ("department_id", "name", "creation", "ranking", "budget_in_billions", "num_employees") VALUES (7, '7', '10', 7, 7, 7);
INSERT INTO "head" ("head_id", "name", "born_state", "age") VALUES (8, '7', '7', 7);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT creation FROM (SELECT creation, COUNT(*) AS n FROM department GROUP BY creation) WHERE (n <> 1) ORDER BY creation;

/*
Gold Result:
*/

-- Prediction Query
SELECT creation FROM department GROUP BY creation ORDER BY COUNT(*) DESC, creation NULLS LAST LIMIT 1;

/*
Prediction Result:
('10',)
*/