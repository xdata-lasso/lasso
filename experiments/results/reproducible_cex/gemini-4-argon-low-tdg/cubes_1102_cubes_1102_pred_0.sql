-- Schema DDL
CREATE TABLE "department" ("Department_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Creation" TEXT, "Ranking" INTEGER, "Budget_in_Billions" REAL, "Num_Employees" REAL);

CREATE TABLE "head" ("head_ID" INTEGER PRIMARY KEY, "name" TEXT, "born_state" TEXT, "age" REAL);

CREATE TABLE "management" ("department_ID" INTEGER, "head_ID" INTEGER, "temporary_acting" TEXT, PRIMARY KEY ("department_ID", "head_ID"), FOREIGN KEY ("head_ID") REFERENCES "head" ("head_ID"), FOREIGN KEY ("department_ID") REFERENCES "department" ("Department_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests:
-- 1. Boundary conditions for age <= 56.0 (exact match 56.0, just below 55.9, just above 56.1).
-- 2. COUNT(DISTINCT age) vs COUNT(*) vs COUNT(age) by having duplicate ages (40.0) and duplicate names ('Alice', 'Bob') with different ages.
-- 3. NULL handling in age column.
-- 4. Unnecessary JOIN with 'management' and 'department' tables (some heads have no management records, some have multiple).
INSERT INTO department (Department_ID, Name, Creation, Ranking, Budget_in_Billions, Num_Employees) VALUES (1, 'HR', '1990', 1, 1.5, 100.0);
INSERT INTO department (Department_ID, Name, Creation, Ranking, Budget_in_Billions, Num_Employees) VALUES (2, 'IT', '2000', 2, 2.5, 200.0);
INSERT INTO head (head_ID, name, born_state, age) VALUES (1, 'Alice', 'CA', 40.0);
INSERT INTO head (head_ID, name, born_state, age) VALUES (2, 'Bob', 'NY', 40.0);
INSERT INTO head (head_ID, name, born_state, age) VALUES (3, 'Alice', 'CA', 56.0);
INSERT INTO head (head_ID, name, born_state, age) VALUES (4, 'Bob', 'NY', 55.9);
INSERT INTO head (head_ID, name, born_state, age) VALUES (5, 'Charlie', 'TX', 56.1);
INSERT INTO head (head_ID, name, born_state, age) VALUES (6, 'David', 'FL', 60.0);
INSERT INTO head (head_ID, name, born_state, age) VALUES (7, 'Eve', 'WA', NULL);
INSERT INTO management (department_ID, head_ID, temporary_acting) VALUES (1, 1, 'Yes');
INSERT INTO management (department_ID, head_ID, temporary_acting) VALUES (2, 1, 'No');
INSERT INTO management (department_ID, head_ID, temporary_acting) VALUES (1, 5, 'Yes');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT n_distinct AS count___ FROM (SELECT COUNT(DISTINCT age) AS n_distinct FROM (SELECT * FROM head WHERE (age <= 56.0))) ORDER BY count___;

/*
Gold Result:
(3,)
*/

-- Prediction Query
SELECT COUNT(*) FROM head WHERE age > 56;

/*
Prediction Result:
(2,)
*/