-- Schema DDL
CREATE TABLE "department" ("Department_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Creation" TEXT, "Ranking" INTEGER, "Budget_in_Billions" REAL, "Num_Employees" REAL);

CREATE TABLE "head" ("head_ID" INTEGER PRIMARY KEY, "name" TEXT, "born_state" TEXT, "age" REAL);

CREATE TABLE "management" ("department_ID" INTEGER, "head_ID" INTEGER, "temporary_acting" TEXT, PRIMARY KEY ("department_ID", "head_ID"), FOREIGN KEY ("head_ID") REFERENCES "head" ("head_ID"), FOREIGN KEY ("department_ID") REFERENCES "department" ("Department_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO head (head_ID, name, born_state, age) VALUES (1, 'Alice', 'CA', 45.0);
INSERT INTO head (head_ID, name, born_state, age) VALUES (2, 'Bob', 'NY', 45.0);
INSERT INTO head (head_ID, name, born_state, age) VALUES (3, 'Charlie', 'TX', 56.0);
INSERT INTO head (head_ID, name, born_state, age) VALUES (4, 'David', 'FL', 56.5);
INSERT INTO head (head_ID, name, born_state, age) VALUES (5, 'Eve', 'WA', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT n_distinct AS count___ FROM (SELECT COUNT(DISTINCT age) AS n_distinct FROM (SELECT * FROM head WHERE (age <= 56.0))) ORDER BY count___;

/*
Gold Result:
(2,)
*/

-- Prediction Query
SELECT COUNT(*) FROM head WHERE age > 56;

/*
Prediction Result:
(1,)
*/