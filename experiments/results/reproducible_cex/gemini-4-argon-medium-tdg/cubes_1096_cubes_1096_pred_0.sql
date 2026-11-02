-- Schema DDL
CREATE TABLE "department" ("Department_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Creation" TEXT, "Ranking" INTEGER, "Budget_in_Billions" REAL, "Num_Employees" REAL);

CREATE TABLE "head" ("head_ID" INTEGER PRIMARY KEY, "name" TEXT, "born_state" TEXT, "age" REAL);

CREATE TABLE "management" ("department_ID" INTEGER, "head_ID" INTEGER, "temporary_acting" TEXT, PRIMARY KEY ("department_ID", "head_ID"), FOREIGN KEY ("head_ID") REFERENCES "head" ("head_ID"), FOREIGN KEY ("department_ID") REFERENCES "department" ("Department_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO department (Department_ID, Name, Creation, Ranking, Budget_in_Billions, Num_Employees) VALUES (1, 'Dept A', '1995', 3, 12.5, 500.0);
INSERT INTO department (Department_ID, Name, Creation, Ranking, Budget_in_Billions, Num_Employees) VALUES (2, 'Dept B', '1980', 1, 8.0, 200.0);
INSERT INTO department (Department_ID, Name, Creation, Ranking, Budget_in_Billions, Num_Employees) VALUES (3, 'Dept C', '1995', 3, 12.5, 500.0);
INSERT INTO department (Department_ID, Name, Creation, Ranking, Budget_in_Billions, Num_Employees) VALUES (4, 'Dept D', '1980', 2, 15.0, 600.0);
INSERT INTO department (Department_ID, Name, Creation, Ranking, Budget_in_Billions, Num_Employees) VALUES (5, 'Dept E', '1980', 4, 20.0, 700.0);
INSERT INTO department (Department_ID, Name, Creation, Ranking, Budget_in_Billions, Num_Employees) VALUES (6, 'Dept F', '2005', 5, 5.0, 100.0);
INSERT INTO head (head_ID, name, born_state, age) VALUES (10, 'John Doe', 'CA', 55.0);
INSERT INTO head (head_ID, name, born_state, age) VALUES (11, 'Jane Smith', 'NY', 48.0);
INSERT INTO management (department_ID, head_ID, temporary_acting) VALUES (1, 10, 'Yes');
INSERT INTO management (department_ID, head_ID, temporary_acting) VALUES (1, 11, 'No');
INSERT INTO management (department_ID, head_ID, temporary_acting) VALUES (6, 10, 'No');
INSERT INTO management (department_ID, head_ID, temporary_acting) VALUES (6, 11, 'Yes');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT creation FROM (SELECT creation, COUNT(*) AS n FROM department GROUP BY creation) WHERE (n <> 1) ORDER BY creation;

/*
Gold Result:
('1980',)
('1995',)
*/

-- Prediction Query
SELECT creation FROM department GROUP BY creation ORDER BY COUNT(*) DESC, creation NULLS LAST LIMIT 1;

/*
Prediction Result:
('1980',)
*/