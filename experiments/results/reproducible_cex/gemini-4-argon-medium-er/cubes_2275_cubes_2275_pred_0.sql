-- Schema DDL
CREATE TABLE "works_on" ("Essn" INTEGER, "Pno" INTEGER, "Hours" REAL, PRIMARY KEY ("Essn", "Pno"));

CREATE TABLE "employee" ("Ssn" INTEGER PRIMARY KEY, "Fname" TEXT, "Minit" TEXT, "Lname" TEXT, "Bdate" TEXT, "Address" TEXT, "Sex" TEXT, "Salary" INTEGER, "Super_ssn" INTEGER, "Dno" INTEGER);

CREATE TABLE "department" ("Dnumber" INTEGER PRIMARY KEY, "Dname" TEXT, "Mgr_ssn" INTEGER, "Mgr_start_date" TEXT);

CREATE TABLE "project" ("Pnumber" INTEGER PRIMARY KEY, "Pname" TEXT, "Plocation" TEXT, "Dnum" INTEGER);

CREATE TABLE "dependent" ("Essn" INTEGER, "Dependent_name" TEXT, "Sex" TEXT, "Bdate" TEXT, "Relationship" TEXT, PRIMARY KEY ("Essn", "Dependent_name"));

CREATE TABLE "dept_locations" ("Dnumber" INTEGER, "Dlocation" TEXT, PRIMARY KEY ("Dnumber", "Dlocation"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO department (Dnumber, Dname, Mgr_ssn, Mgr_start_date) VALUES (1, 'B', 111, '2020-01-01');
INSERT INTO department (Dnumber, Dname, Mgr_ssn, Mgr_start_date) VALUES (2, 'A', 222, '2020-01-01');
INSERT INTO dept_locations (Dnumber, Dlocation) VALUES (1, 'Houston');
INSERT INTO dept_locations (Dnumber, Dlocation) VALUES (2, 'Houston');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "dname" FROM (SELECT "LHS"."dname" AS "dname", "LHS"."dnumber" AS "dnumber", "LHS"."mgr_ssn" AS "mgr_ssn", "LHS"."mgr_start_date" AS "mgr_start_date", "RHS"."dlocation" AS "dlocation" FROM "department" AS "LHS" INNER JOIN (SELECT * FROM "dept_locations" WHERE ("dlocation" = 'Houston')) AS RHS ON (LHS.dnumber = RHS.dnumber)) ORDER BY dname, "dname" NULLS LAST;

/*
Gold Result:
('A',)
('B',)
*/

-- Prediction Query
SELECT t1.dname FROM department AS t1 JOIN dept_locations AS t2 ON t1.dnumber = t2.dnumber WHERE t2.dlocation = 'Houston';

/*
Prediction Result:
('B',)
('A',)
*/