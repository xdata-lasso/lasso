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
-- Tests NULL handling in fname, lname, and INTEGER PRIMARY KEY (Ssn) for NULLS LAST / NULLS FIRST
INSERT INTO "employee" ("Ssn", "Fname", "Minit", "Lname", "Bdate", "Address", "Sex", "Salary", "Super_ssn", "Dno") VALUES (10, NULL, 'A', 'NoFirstName1', '1985-01-01', '789 Birch', 'M', 35000, NULL, 1);
INSERT INTO "employee" ("Ssn", "Fname", "Minit", "Lname", "Bdate", "Address", "Sex", "Salary", "Super_ssn", "Dno") VALUES (5, NULL, 'B', 'NoFirstName2', '1986-02-02', '890 Cedar', 'F', 35000, NULL, 1);
INSERT INTO "employee" ("Ssn", "Fname", "Minit", "Lname", "Bdate", "Address", "Sex", "Salary", "Super_ssn", "Dno") VALUES (20, 'Aaron', 'C', NULL, '1987-03-03', '901 Walnut', 'M', 40000, NULL, 1);
INSERT INTO "employee" ("Ssn", "Fname", "Minit", "Lname", "Bdate", "Address", "Sex", "Salary", "Super_ssn", "Dno") VALUES (15, 'Beth', 'D', 'Brown', '1988-04-04', '102 Chestnut', 'F', 45000, NULL, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT fname, lname FROM employee WHERE (salary > 30000) ORDER BY fname, employee.ssn NULLS LAST;

/*
Gold Result:
(None, 'NoFirstName2')
(None, 'NoFirstName1')
('Aaron', None)
('Beth', 'Brown')
*/

-- Prediction Query
SELECT fname, lname FROM employee WHERE salary > 30000;

/*
Prediction Result:
(None, 'NoFirstName2')
(None, 'NoFirstName1')
('Beth', 'Brown')
('Aaron', None)
*/