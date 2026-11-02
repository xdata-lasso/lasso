-- Schema DDL
CREATE TABLE "works_on" ("Essn" INTEGER, "Pno" INTEGER, "Hours" REAL, PRIMARY KEY ("Essn", "Pno"));

CREATE TABLE "employee" ("Ssn" INTEGER PRIMARY KEY, "Fname" TEXT, "Minit" TEXT, "Lname" TEXT, "Bdate" TEXT, "Address" TEXT, "Sex" TEXT, "Salary" INTEGER, "Super_ssn" INTEGER, "Dno" INTEGER);

CREATE TABLE "department" ("Dnumber" INTEGER PRIMARY KEY, "Dname" TEXT, "Mgr_ssn" INTEGER, "Mgr_start_date" TEXT);

CREATE TABLE "project" ("Pnumber" INTEGER PRIMARY KEY, "Pname" TEXT, "Plocation" TEXT, "Dnum" INTEGER);

CREATE TABLE "dependent" ("Essn" INTEGER, "Dependent_name" TEXT, "Sex" TEXT, "Bdate" TEXT, "Relationship" TEXT, PRIMARY KEY ("Essn", "Dependent_name"));

CREATE TABLE "dept_locations" ("Dnumber" INTEGER, "Dlocation" TEXT, PRIMARY KEY ("Dnumber", "Dlocation"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 3
-- Tests NULL handling in Fname, Lname, and Ssn (specifically testing ORDER BY ... NULLS LAST vs NULLS FIRST)
INSERT INTO "employee" ("Ssn", "Fname", "Minit", "Lname", "Bdate", "Address", "Sex", "Salary", "Super_ssn", "Dno") VALUES (10, NULL, 'A', 'NoFirstName', '1990-01-01', '100 Null Ave', 'M', 35000, NULL, 1);
INSERT INTO "employee" ("Ssn", "Fname", "Minit", "Lname", "Bdate", "Address", "Sex", "Salary", "Super_ssn", "Dno") VALUES (20, 'Aaron', 'B', NULL, '1991-02-02', '200 Null Ave', 'M', 35000, NULL, 1);
INSERT INTO "employee" ("Ssn", "Fname", "Minit", "Lname", "Bdate", "Address", "Sex", "Salary", "Super_ssn", "Dno") VALUES (5, 'Zack', 'C', 'WithSsn', '1992-03-03', '300 Null Ave', 'M', 35000, NULL, 1);
INSERT INTO "employee" ("Ssn", "Fname", "Minit", "Lname", "Bdate", "Address", "Sex", "Salary", "Super_ssn", "Dno") VALUES (NULL, 'Zack', 'D', 'NullSsn', '1993-04-04', '400 Null Ave', 'M', 35000, NULL, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT fname, lname FROM employee WHERE (salary > 30000) ORDER BY fname, employee.ssn NULLS LAST;

/*
Gold Result:
(None, 'NoFirstName')
('Aaron', None)
('Zack', 'WithSsn')
('Zack', 'NullSsn')
*/

-- Prediction Query
SELECT fname, lname FROM employee WHERE salary > 30000;

/*
Prediction Result:
('Zack', 'WithSsn')
(None, 'NoFirstName')
('Aaron', None)
('Zack', 'NullSsn')
*/