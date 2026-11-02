-- Schema DDL
CREATE TABLE "department" ("Department_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Creation" TEXT, "Ranking" INTEGER, "Budget_in_Billions" REAL, "Num_Employees" REAL);

CREATE TABLE "head" ("head_ID" INTEGER PRIMARY KEY, "name" TEXT, "born_state" TEXT, "age" REAL);

CREATE TABLE "management" ("department_ID" INTEGER, "head_ID" INTEGER, "temporary_acting" TEXT, PRIMARY KEY ("department_ID", "head_ID"), FOREIGN KEY ("head_ID") REFERENCES "head" ("head_ID"), FOREIGN KEY ("department_ID") REFERENCES "department" ("Department_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic ordering by name, secondary ordering by head_ID, duplicate rows (to catch SELECT DISTINCT mutants), and joins vs standalone table (to catch INNER JOIN management/department mutants).
INSERT INTO "department" ("Department_ID", "Name", "Creation", "Ranking", "Budget_in_Billions", "Num_Employees") VALUES (1, 'Treasury', '1789', 1, 10.5, 100.0);
INSERT INTO "department" ("Department_ID", "Name", "Creation", "Ranking", "Budget_in_Billions", "Num_Employees") VALUES (2, 'State', '1789', 2, 20.0, 200.0);
INSERT INTO "head" ("head_ID", "name", "born_state", "age") VALUES (10, 'Bob', 'Texas', 55.0);
INSERT INTO "head" ("head_ID", "name", "born_state", "age") VALUES (20, 'Alice', 'California', 40.0);
INSERT INTO "head" ("head_ID", "name", "born_state", "age") VALUES (5, 'Alice', 'New York', 60.0);
INSERT INTO "head" ("head_ID", "name", "born_state", "age") VALUES (15, 'Alice', 'New York', 60.0);
INSERT INTO "management" ("department_ID", "head_ID", "temporary_acting") VALUES (1, 10, 'Yes');
INSERT INTO "management" ("department_ID", "head_ID", "temporary_acting") VALUES (2, 10, 'No');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, born_state, age FROM head ORDER BY name, head.head_id NULLS LAST;

/*
Gold Result:
('Alice', 'New York', 60.0)
('Alice', 'New York', 60.0)
('Alice', 'California', 40.0)
('Bob', 'Texas', 55.0)
*/

-- Prediction Query
SELECT name, born_state, age FROM head ORDER BY age, head.head_id NULLS LAST;

/*
Prediction Result:
('Alice', 'California', 40.0)
('Bob', 'Texas', 55.0)
('Alice', 'New York', 60.0)
('Alice', 'New York', 60.0)
*/