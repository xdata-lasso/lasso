-- Schema DDL
CREATE TABLE Departments (dept_id INTEGER PRIMARY KEY, dept_name TEXT(20) NOT NULL, budget REAL(12, 2) CHECK (budget > 0));

CREATE TABLE Projects (proj_id INTEGER PRIMARY KEY, proj_name TEXT(30) NOT NULL, dept_id INTEGER, budget_allocated REAL(10, 2), FOREIGN KEY (dept_id) REFERENCES Departments (dept_id));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "departments" ("dept_id", "dept_name", "budget") VALUES (1001, 'Allison Hill', 1002.5);
INSERT INTO "projects" ("proj_id", "proj_name", "dept_id", "budget_allocated") VALUES (1003, 'Noah Rhodes', 1001, 10001.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT proj_name FROM Projects WHERE budget_allocated > 10000;

/*
Gold Result:
('Noah Rhodes',)
*/

-- Prediction Query
SELECT proj_name FROM Projects WHERE budget_allocated < 10000;

/*
Prediction Result:
*/