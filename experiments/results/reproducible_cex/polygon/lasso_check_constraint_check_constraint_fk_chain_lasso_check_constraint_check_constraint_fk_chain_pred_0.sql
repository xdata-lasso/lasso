-- Schema DDL
CREATE TABLE Departments (dept_id INTEGER PRIMARY KEY, dept_name TEXT(20) NOT NULL, budget REAL(12, 2) CHECK (budget > 0));

CREATE TABLE Projects (proj_id INTEGER PRIMARY KEY, proj_name TEXT(30) NOT NULL, dept_id INTEGER, budget_allocated REAL(10, 2), FOREIGN KEY (dept_id) REFERENCES Departments (dept_id));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Departments" ("dept_id", "dept_name", "budget") VALUES (6, '11', 1);
INSERT INTO "Departments" ("dept_id", "dept_name", "budget") VALUES (9, '11', 1);
INSERT INTO "Projects" ("proj_id", "dept_id", "proj_name", "budget_allocated") VALUES (8, 9, '12', -635);
INSERT INTO "Projects" ("proj_id", "dept_id", "proj_name", "budget_allocated") VALUES (7, NULL, '11', 10001);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT proj_name FROM Projects WHERE budget_allocated > 10000;

/*
Gold Result:
('11',)
*/

-- Prediction Query
SELECT proj_name FROM Projects WHERE budget_allocated < 10000;

/*
Prediction Result:
('12',)
*/