-- Schema DDL
CREATE TABLE "works_on" ("Essn" INTEGER, "Pno" INTEGER, "Hours" REAL, PRIMARY KEY ("Essn", "Pno"));

CREATE TABLE "employee" ("Ssn" INTEGER PRIMARY KEY, "Fname" TEXT, "Minit" TEXT, "Lname" TEXT, "Bdate" TEXT, "Address" TEXT, "Sex" TEXT, "Salary" INTEGER, "Super_ssn" INTEGER, "Dno" INTEGER);

CREATE TABLE "department" ("Dnumber" INTEGER PRIMARY KEY, "Dname" TEXT, "Mgr_ssn" INTEGER, "Mgr_start_date" TEXT);

CREATE TABLE "project" ("Pnumber" INTEGER PRIMARY KEY, "Pname" TEXT, "Plocation" TEXT, "Dnum" INTEGER);

CREATE TABLE "dependent" ("Essn" INTEGER, "Dependent_name" TEXT, "Sex" TEXT, "Bdate" TEXT, "Relationship" TEXT, PRIMARY KEY ("Essn", "Dependent_name"));

CREATE TABLE "dept_locations" ("Dnumber" INTEGER, "Dlocation" TEXT, PRIMARY KEY ("Dnumber", "Dlocation"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
-- Tests NULLs in Dname (NULLS LAST ordering), duplicate Dnames in Houston (DISTINCT vs ALL), and case/substring sensitivity on 'Houston'
INSERT INTO "department" ("Dnumber", "Dname", "Mgr_ssn", "Mgr_start_date") VALUES (10, 'Zeta', 100, '2020-01-01');
INSERT INTO "department" ("Dnumber", "Dname", "Mgr_ssn", "Mgr_start_date") VALUES (20, 'Alpha', 200, '2020-01-01');
INSERT INTO "department" ("Dnumber", "Dname", "Mgr_ssn", "Mgr_start_date") VALUES (30, 'Alpha', 300, '2020-01-01');
INSERT INTO "department" ("Dnumber", "Dname", "Mgr_ssn", "Mgr_start_date") VALUES (40, NULL, 400, '2020-01-01');
INSERT INTO "department" ("Dnumber", "Dname", "Mgr_ssn", "Mgr_start_date") VALUES (50, 'Beta', 500, '2020-01-01');
INSERT INTO "department" ("Dnumber", "Dname", "Mgr_ssn", "Mgr_start_date") VALUES (60, 'Gamma', 600, '2020-01-01');
INSERT INTO "dept_locations" ("Dnumber", "Dlocation") VALUES (10, 'Houston');
INSERT INTO "dept_locations" ("Dnumber", "Dlocation") VALUES (20, 'Houston');
INSERT INTO "dept_locations" ("Dnumber", "Dlocation") VALUES (30, 'Houston');
INSERT INTO "dept_locations" ("Dnumber", "Dlocation") VALUES (40, 'Houston');
INSERT INTO "dept_locations" ("Dnumber", "Dlocation") VALUES (50, 'houston');
INSERT INTO "dept_locations" ("Dnumber", "Dlocation") VALUES (60, 'Houston ');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "dname" FROM (SELECT "LHS"."dname" AS "dname", "LHS"."dnumber" AS "dnumber", "LHS"."mgr_ssn" AS "mgr_ssn", "LHS"."mgr_start_date" AS "mgr_start_date", "RHS"."dlocation" AS "dlocation" FROM "department" AS "LHS" INNER JOIN (SELECT * FROM "dept_locations" WHERE ("dlocation" = 'Houston')) AS RHS ON (LHS.dnumber = RHS.dnumber)) ORDER BY dname, "dname" NULLS LAST;

/*
Gold Result:
(None,)
('Alpha',)
('Alpha',)
('Zeta',)
*/

-- Prediction Query
SELECT t1.dname FROM department AS t1 JOIN dept_locations AS t2 ON t1.dnumber = t2.dnumber WHERE t2.dlocation = 'Houston';

/*
Prediction Result:
('Zeta',)
('Alpha',)
('Alpha',)
(None,)
*/