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
INSERT INTO employee (Ssn, Fname, Minit, Lname, Bdate, Address, Sex, Salary, Super_ssn, Dno) VALUES (100, 'John', 'B', 'Smith', '1965-01-09', '731 Fondren, Houston, TX', 'M', 30000, NULL, 1);
INSERT INTO department (Dnumber, Dname, Mgr_ssn, Mgr_start_date) VALUES (3, 'Research', 100, '1988-05-22');
INSERT INTO department (Dnumber, Dname, Mgr_ssn, Mgr_start_date) VALUES (1, 'Administration', 100, '1995-01-01');
INSERT INTO department (Dnumber, Dname, Mgr_ssn, Mgr_start_date) VALUES (2, 'Administration', 100, '1996-01-01');
INSERT INTO department (Dnumber, Dname, Mgr_ssn, Mgr_start_date) VALUES (4, 'Headquarters', 100, '1981-06-19');
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
('Research',)
('Administration',)
('Administration',)
*/