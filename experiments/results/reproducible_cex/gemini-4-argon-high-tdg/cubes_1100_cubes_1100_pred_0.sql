-- Schema DDL
CREATE TABLE "department" ("Department_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Creation" TEXT, "Ranking" INTEGER, "Budget_in_Billions" REAL, "Num_Employees" REAL);

CREATE TABLE "head" ("head_ID" INTEGER PRIMARY KEY, "name" TEXT, "born_state" TEXT, "age" REAL);

CREATE TABLE "management" ("department_ID" INTEGER, "head_ID" INTEGER, "temporary_acting" TEXT, PRIMARY KEY ("department_ID", "head_ID"), FOREIGN KEY ("head_ID") REFERENCES "head" ("head_ID"), FOREIGN KEY ("department_ID") REFERENCES "department" ("Department_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO department (Department_ID, Name, Creation, Ranking, Budget_in_Billions, Num_Employees) VALUES (1, 'Treasury', '1789', 1, 15.5, 1200.0);
INSERT INTO department (Department_ID, Name, Creation, Ranking, Budget_in_Billions, Num_Employees) VALUES (2, 'Defense', '1947', 2, 700.0, 30000.0);
INSERT INTO head (head_ID, name, born_state, age) VALUES (1, 'Zachary', 'California', 40.0);
INSERT INTO head (head_ID, name, born_state, age) VALUES (2, 'Alice', 'Texas', 65.5);
INSERT INTO head (head_ID, name, born_state, age) VALUES (3, 'Bob', 'Alabama', 52.0);
INSERT INTO management (department_ID, head_ID, temporary_acting) VALUES (1, 1, 'No');
INSERT INTO management (department_ID, head_ID, temporary_acting) VALUES (2, 1, 'Yes');
INSERT INTO management (department_ID, head_ID, temporary_acting) VALUES (1, 3, 'Yes');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, born_state, age FROM head ORDER BY name, head.head_id NULLS LAST;

/*
Gold Result:
('Alice', 'Texas', 65.5)
('Bob', 'Alabama', 52.0)
('Zachary', 'California', 40.0)
*/

-- Prediction Query
SELECT name, born_state, age FROM head ORDER BY age, head.head_id NULLS LAST;

/*
Prediction Result:
('Zachary', 'California', 40.0)
('Bob', 'Alabama', 52.0)
('Alice', 'Texas', 65.5)
*/