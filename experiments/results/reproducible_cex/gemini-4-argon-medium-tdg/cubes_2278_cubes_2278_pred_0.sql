-- Schema DDL
CREATE TABLE "works_on" ("Essn" INTEGER, "Pno" INTEGER, "Hours" REAL, PRIMARY KEY ("Essn", "Pno"));

CREATE TABLE "employee" ("Ssn" INTEGER PRIMARY KEY, "Fname" TEXT, "Minit" TEXT, "Lname" TEXT, "Bdate" TEXT, "Address" TEXT, "Sex" TEXT, "Salary" INTEGER, "Super_ssn" INTEGER, "Dno" INTEGER);

CREATE TABLE "department" ("Dnumber" INTEGER PRIMARY KEY, "Dname" TEXT, "Mgr_ssn" INTEGER, "Mgr_start_date" TEXT);

CREATE TABLE "project" ("Pnumber" INTEGER PRIMARY KEY, "Pname" TEXT, "Plocation" TEXT, "Dnum" INTEGER);

CREATE TABLE "dependent" ("Essn" INTEGER, "Dependent_name" TEXT, "Sex" TEXT, "Bdate" TEXT, "Relationship" TEXT, PRIMARY KEY ("Essn", "Dependent_name"));

CREATE TABLE "dept_locations" ("Dnumber" INTEGER, "Dlocation" TEXT, PRIMARY KEY ("Dnumber", "Dlocation"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic ordering (out-of-order insertion vs alphabetical order), duplicate dname values (kills DISTINCT mutants), and anti-correlated dnumber vs dname (kills ORDER BY dnumber, dname mutants).
INSERT INTO "department" ("Dnumber", "Dname", "Mgr_ssn", "Mgr_start_date") VALUES (10, 'Sales', 101, '2020-01-01');
INSERT INTO "department" ("Dnumber", "Dname", "Mgr_ssn", "Mgr_start_date") VALUES (20, 'Accounting', 102, '2019-05-15');
INSERT INTO "department" ("Dnumber", "Dname", "Mgr_ssn", "Mgr_start_date") VALUES (5, 'Research', 103, '2021-03-10');
INSERT INTO "department" ("Dnumber", "Dname", "Mgr_ssn", "Mgr_start_date") VALUES (1, 'Sales', 104, '2018-11-20');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT dname FROM department ORDER BY dname, department.dnumber NULLS LAST;

/*
Gold Result:
('Accounting',)
('Research',)
('Sales',)
('Sales',)
*/

-- Prediction Query
SELECT dname FROM department ORDER BY mgr_start_date, department.dnumber NULLS LAST;

/*
Prediction Result:
('Sales',)
('Accounting',)
('Sales',)
('Research',)
*/