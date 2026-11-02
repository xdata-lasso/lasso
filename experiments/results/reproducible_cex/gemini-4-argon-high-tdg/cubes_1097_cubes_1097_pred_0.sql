-- Schema DDL
CREATE TABLE "department" ("Department_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Creation" TEXT, "Ranking" INTEGER, "Budget_in_Billions" REAL, "Num_Employees" REAL);

CREATE TABLE "head" ("head_ID" INTEGER PRIMARY KEY, "name" TEXT, "born_state" TEXT, "age" REAL);

CREATE TABLE "management" ("department_ID" INTEGER, "head_ID" INTEGER, "temporary_acting" TEXT, PRIMARY KEY ("department_ID", "head_ID"), FOREIGN KEY ("head_ID") REFERENCES "head" ("head_ID"), FOREIGN KEY ("department_ID") REFERENCES "department" ("Department_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO department (Department_ID, Name, Creation, Ranking, Budget_in_Billions, Num_Employees) VALUES (10, 'Treasury', '1789', 1, 15.5, 1200.0);
INSERT INTO department (Department_ID, Name, Creation, Ranking, Budget_in_Billions, Num_Employees) VALUES (20, 'Defense', '1947', 2, 700.0, 25000.0);
INSERT INTO department (Department_ID, Name, Creation, Ranking, Budget_in_Billions, Num_Employees) VALUES (30, 'Education', '1979', 3, 68.2, 4400.0);
INSERT INTO head (head_ID, name, born_state, age) VALUES (1, 'Alice Smith', 'California', 65.0);
INSERT INTO head (head_ID, name, born_state, age) VALUES (2, 'Bob Jones', 'Texas', 42.5);
INSERT INTO head (head_ID, name, born_state, age) VALUES (3, 'Carol White', 'New York', 53.0);
INSERT INTO head (head_ID, name, born_state, age) VALUES (4, 'David Black', 'Ohio', 38.0);
INSERT INTO head (head_ID, name, born_state, age) VALUES (5, 'Eve Green', 'Florida', 49.0);
INSERT INTO management (department_ID, head_ID, temporary_acting) VALUES (10, 1, 'Yes');
INSERT INTO management (department_ID, head_ID, temporary_acting) VALUES (20, 2, 'Yes');
INSERT INTO management (department_ID, head_ID, temporary_acting) VALUES (30, 3, 'Yes');
INSERT INTO management (department_ID, head_ID, temporary_acting) VALUES (10, 4, 'No');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "age" FROM (SELECT "LHS"."head_id" AS "head_id", "LHS"."name" AS "name", "LHS"."born_state" AS "born_state", "LHS"."age" AS "age", "RHS"."department_id" AS "department_id", "RHS"."temporary_acting" AS "temporary_acting" FROM "head" AS "LHS" INNER JOIN "management" AS "RHS" ON ("LHS"."head_id" = "RHS"."head_id")) WHERE ("temporary_acting" = 'Yes') ORDER BY age, "age" NULLS LAST;

/*
Gold Result:
(42.5,)
(53.0,)
(65.0,)
*/

-- Prediction Query
SELECT DISTINCT T1.age FROM management AS T2 JOIN head AS T1 ON T1.head_id = T2.head_id WHERE T2.temporary_acting = 'Yes';

/*
Prediction Result:
(65.0,)
(42.5,)
(53.0,)
*/