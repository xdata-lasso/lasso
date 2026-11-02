-- Schema DDL
CREATE TABLE "works_on" ("Essn" INTEGER, "Pno" INTEGER, "Hours" REAL, PRIMARY KEY ("Essn", "Pno"));

CREATE TABLE "employee" ("Ssn" INTEGER PRIMARY KEY, "Fname" TEXT, "Minit" TEXT, "Lname" TEXT, "Bdate" TEXT, "Address" TEXT, "Sex" TEXT, "Salary" INTEGER, "Super_ssn" INTEGER, "Dno" INTEGER);

CREATE TABLE "department" ("Dnumber" INTEGER PRIMARY KEY, "Dname" TEXT, "Mgr_ssn" INTEGER, "Mgr_start_date" TEXT);

CREATE TABLE "project" ("Pnumber" INTEGER PRIMARY KEY, "Pname" TEXT, "Plocation" TEXT, "Dnum" INTEGER);

CREATE TABLE "dependent" ("Essn" INTEGER, "Dependent_name" TEXT, "Sex" TEXT, "Bdate" TEXT, "Relationship" TEXT, PRIMARY KEY ("Essn", "Dependent_name"));

CREATE TABLE "dept_locations" ("Dnumber" INTEGER, "Dlocation" TEXT, PRIMARY KEY ("Dnumber", "Dlocation"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "department" ("dnumber", "dname", "mgr_ssn", "mgr_start_date") VALUES (1006, 'Kimberly Robinson', 1007, 'discover');
INSERT INTO "department" ("dnumber", "dname", "mgr_ssn", "mgr_start_date") VALUES (1008, 'Javier Johnson', 1008, 'sense');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT dname FROM department ORDER BY dname, department.dnumber NULLS LAST;

/*
Gold Result:
('Javier Johnson',)
('Kimberly Robinson',)
*/

-- Prediction Query
SELECT dname FROM department ORDER BY mgr_start_date, department.dnumber NULLS LAST;

/*
Prediction Result:
('Kimberly Robinson',)
('Javier Johnson',)
*/