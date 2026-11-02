-- Schema DDL
CREATE TABLE "department" ("Department_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Creation" TEXT, "Ranking" INTEGER, "Budget_in_Billions" REAL, "Num_Employees" REAL);

CREATE TABLE "head" ("head_ID" INTEGER PRIMARY KEY, "name" TEXT, "born_state" TEXT, "age" REAL);

CREATE TABLE "management" ("department_ID" INTEGER, "head_ID" INTEGER, "temporary_acting" TEXT, PRIMARY KEY ("department_ID", "head_ID"), FOREIGN KEY ("head_ID") REFERENCES "head" ("head_ID"), FOREIGN KEY ("department_ID") REFERENCES "department" ("Department_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO department (Department_ID, Name, Creation, Ranking, Budget_in_Billions, Num_Employees) VALUES (1, 'State', '1789', 1, 10.5, 30.0);
INSERT INTO department (Department_ID, Name, Creation, Ranking, Budget_in_Billions, Num_Employees) VALUES (2, 'Treasury', '1789', 2, 20.0, 45.0);
INSERT INTO head (head_ID, name, born_state, age) VALUES (1, 'Alice', 'California', 42.0);
INSERT INTO head (head_ID, name, born_state, age) VALUES (2, 'Bob', 'California', 42.0);
INSERT INTO head (head_ID, name, born_state, age) VALUES (3, 'Charlie', 'California', 50.0);
INSERT INTO head (head_ID, name, born_state, age) VALUES (4, 'David', 'California', 50.0);
INSERT INTO head (head_ID, name, born_state, age) VALUES (5, 'Eve', 'California', 56.0);
INSERT INTO head (head_ID, name, born_state, age) VALUES (6, 'Eve', 'California', 56.0);
INSERT INTO head (head_ID, name, born_state, age) VALUES (7, 'Frank', 'New York', 56.1);
INSERT INTO head (head_ID, name, born_state, age) VALUES (8, 'Grace', 'Texas', 60.0);
INSERT INTO head (head_ID, name, born_state, age) VALUES (9, 'Heidi', 'Florida', 65.0);
INSERT INTO head (head_ID, name, born_state, age) VALUES (10, 'Ivan', 'Ohio', 70.0);
INSERT INTO head (head_ID, name, born_state, age) VALUES (11, 'Judy', 'Nevada', NULL);
INSERT INTO management (department_ID, head_ID, temporary_acting) VALUES (1, 1, 'Yes');
INSERT INTO management (department_ID, head_ID, temporary_acting) VALUES (2, 1, 'No');
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
(4,)
*/