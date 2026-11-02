-- Schema DDL
CREATE TABLE "department" ("Department_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Creation" TEXT, "Ranking" INTEGER, "Budget_in_Billions" REAL, "Num_Employees" REAL);

CREATE TABLE "head" ("head_ID" INTEGER PRIMARY KEY, "name" TEXT, "born_state" TEXT, "age" REAL);

CREATE TABLE "management" ("department_ID" INTEGER, "head_ID" INTEGER, "temporary_acting" TEXT, PRIMARY KEY ("department_ID", "head_ID"), FOREIGN KEY ("head_ID") REFERENCES "head" ("head_ID"), FOREIGN KEY ("department_ID") REFERENCES "department" ("Department_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO department (Department_ID, Name, Creation, Ranking, Budget_in_Billions, Num_Employees) VALUES (1, 'Treasury', '1989', 2, 85.5, 12000.0);
INSERT INTO department (Department_ID, Name, Creation, Ranking, Budget_in_Billions, Num_Employees) VALUES (2, 'State', '1789', 1, 45.2, 30000.0);
INSERT INTO department (Department_ID, Name, Creation, Ranking, Budget_in_Billions, Num_Employees) VALUES (3, 'Defense', '1989', 4, 12.3, 8500.0);
INSERT INTO department (Department_ID, Name, Creation, Ranking, Budget_in_Billions, Num_Employees) VALUES (4, 'Agriculture', '1947', 3, 60.0, 15000.0);
INSERT INTO head (head_ID, name, born_state, age) VALUES (101, 'Alice Smith', 'California', 54.0);
INSERT INTO head (head_ID, name, born_state, age) VALUES (102, 'Bob Jones', 'Texas', 61.0);
INSERT INTO management (department_ID, head_ID, temporary_acting) VALUES (1, 101, 'Yes');
INSERT INTO management (department_ID, head_ID, temporary_acting) VALUES (1, 102, 'No');
INSERT INTO management (department_ID, head_ID, temporary_acting) VALUES (2, 101, 'No');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT creation, name, budget_in_billions FROM department ORDER BY creation, department.department_id NULLS LAST;

/*
Gold Result:
('1789', 'State', 45.2)
('1947', 'Agriculture', 60.0)
('1989', 'Treasury', 85.5)
('1989', 'Defense', 12.3)
*/

-- Prediction Query
SELECT creation, name, budget_in_billions FROM department;

/*
Prediction Result:
('1989', 'Treasury', 85.5)
('1789', 'State', 45.2)
('1989', 'Defense', 12.3)
('1947', 'Agriculture', 60.0)
*/