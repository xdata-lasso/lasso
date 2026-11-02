-- Schema DDL
CREATE TABLE Departments (dept_id INTEGER PRIMARY KEY, dept_name TEXT(20) NOT NULL, budget REAL(12, 2) CHECK (budget > 0));

CREATE TABLE Projects (proj_id INTEGER PRIMARY KEY, proj_name TEXT(30) NOT NULL, dept_id INTEGER, budget_allocated REAL(10, 2), FOREIGN KEY (dept_id) REFERENCES Departments (dept_id));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: departments --
INSERT INTO "departments" ("dept_id", "dept_name", "budget") VALUES (-2147483648, 'dep_ac74da', 0.01);

-- Inserting into table: projects --
INSERT INTO "projects" ("proj_id", "proj_name", "dept_id", "budget_allocated") VALUES (-2147483648, 'pro_067be9', -2147483648, 10000.01);

INSERT INTO "projects" ("proj_id", "proj_name", "dept_id", "budget_allocated") VALUES (2, 'pro_067be9', -2147483648, 10000.01);

INSERT INTO "projects" ("proj_id", "proj_name", "dept_id", "budget_allocated") VALUES (3, 'pro_067be9', -2147483648, 10000.01);

INSERT INTO "projects" ("proj_id", "proj_name", "dept_id", "budget_allocated") VALUES (-2147483645, 'pro_067be9', -2147483648, 10000.0);

INSERT INTO "projects" ("proj_id", "proj_name", "dept_id", "budget_allocated") VALUES (-2147483644, 'pro_067be9', -2147483648, 10000.01);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT proj_name FROM Projects WHERE budget_allocated > 10000;

/*
Gold Result:
('pro_067be9',)
('pro_067be9',)
('pro_067be9',)
('pro_067be9',)
*/

-- Prediction Query
SELECT proj_name FROM Projects WHERE budget_allocated < 10000;

/*
Prediction Result:
*/