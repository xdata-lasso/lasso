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
INSERT INTO department (Dnumber, Dname, Mgr_ssn, Mgr_start_date) VALUES (1, 'Research', 101, '2020-01-15');
INSERT INTO department (Dnumber, Dname, Mgr_ssn, Mgr_start_date) VALUES (2, 'Administration', 102, '2019-05-20');
INSERT INTO department (Dnumber, Dname, Mgr_ssn, Mgr_start_date) VALUES (3, 'Headquarters', 103, '2018-11-01');
INSERT INTO department (Dnumber, Dname, Mgr_ssn, Mgr_start_date) VALUES (4, 'Administration', 104, '2021-03-10');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT dname FROM department ORDER BY dname, department.dnumber NULLS LAST;

/*
Gold Result:
('Administration',)
('Administration',)
('Headquarters',)
('Research',)
*/

-- Prediction Query
SELECT dname FROM department ORDER BY mgr_start_date, department.dnumber NULLS LAST;

/*
Prediction Result:
('Headquarters',)
('Administration',)
('Research',)
('Administration',)
*/