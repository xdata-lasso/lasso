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
INSERT INTO "employee" ("Ssn", "Fname", "Minit", "Lname", "Bdate", "Address", "Sex", "Salary", "Super_ssn", "Dno") VALUES (101, 'John', 'B', 'Smith', '1965-01-09', '731 Fondren, Houston, TX', 'M', 30000, NULL, 1);
INSERT INTO "employee" ("Ssn", "Fname", "Minit", "Lname", "Bdate", "Address", "Sex", "Salary", "Super_ssn", "Dno") VALUES (102, 'Franklin', 'T', 'Wong', '1955-12-08', '638 Voss, Houston, TX', 'M', 40000, 101, 2);
INSERT INTO "employee" ("Ssn", "Fname", "Minit", "Lname", "Bdate", "Address", "Sex", "Salary", "Super_ssn", "Dno") VALUES (103, 'Alicia', 'J', 'Zelaya', '1968-01-19', '3321 Castle, Spring, TX', 'F', 25000, 101, 3);
INSERT INTO "employee" ("Ssn", "Fname", "Minit", "Lname", "Bdate", "Address", "Sex", "Salary", "Super_ssn", "Dno") VALUES (104, 'Jennifer', 'S', 'Wallace', '1941-06-20', '291 Berry, Bellaire, TX', 'F', 43000, NULL, 4);
INSERT INTO "department" ("Dnumber", "Dname", "Mgr_ssn", "Mgr_start_date") VALUES (1, 'Zeta', 101, '1988-05-22');
INSERT INTO "department" ("Dnumber", "Dname", "Mgr_ssn", "Mgr_start_date") VALUES (2, 'Alpha', 102, '1995-01-01');
INSERT INTO "department" ("Dnumber", "Dname", "Mgr_ssn", "Mgr_start_date") VALUES (3, 'Beta', 103, '1998-06-15');
INSERT INTO "department" ("Dnumber", "Dname", "Mgr_ssn", "Mgr_start_date") VALUES (4, 'Gamma', 104, '2001-03-10');
INSERT INTO "dept_locations" ("Dnumber", "Dlocation") VALUES (1, 'Houston');
INSERT INTO "dept_locations" ("Dnumber", "Dlocation") VALUES (1, 'Stafford');
INSERT INTO "dept_locations" ("Dnumber", "Dlocation") VALUES (1, 'Sugarland');
INSERT INTO "dept_locations" ("Dnumber", "Dlocation") VALUES (2, 'Bellaire');
INSERT INTO "dept_locations" ("Dnumber", "Dlocation") VALUES (3, 'Houston');
INSERT INTO "dept_locations" ("Dnumber", "Dlocation") VALUES (4, 'Houston');
INSERT INTO "project" ("Pnumber", "Pname", "Plocation", "Dnum") VALUES (10, 'ProductX', 'Bellaire', 1);
INSERT INTO "project" ("Pnumber", "Pname", "Plocation", "Dnum") VALUES (20, 'ProductY', 'Sugarland', 2);
INSERT INTO "works_on" ("Essn", "Pno", "Hours") VALUES (101, 10, 32.5);
INSERT INTO "works_on" ("Essn", "Pno", "Hours") VALUES (102, 20, 40.0);
INSERT INTO "dependent" ("Essn", "Dependent_name", "Sex", "Bdate", "Relationship") VALUES (101, 'Alice', 'F', '1988-12-30', 'Daughter');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "dname" FROM (SELECT "LHS"."dname" AS "dname", "LHS"."dnumber" AS "dnumber", "LHS"."mgr_ssn" AS "mgr_ssn", "LHS"."mgr_start_date" AS "mgr_start_date", "RHS"."dlocation" AS "dlocation" FROM "department" AS "LHS" INNER JOIN (SELECT * FROM "dept_locations" WHERE ("dlocation" = 'Houston')) AS RHS ON (LHS.dnumber = RHS.dnumber)) ORDER BY dname, "dname" NULLS LAST;

/*
Gold Result:
('Beta',)
('Gamma',)
('Zeta',)
*/

-- Prediction Query
SELECT t1.dname FROM department AS t1 JOIN dept_locations AS t2 ON t1.dnumber = t2.dnumber WHERE t2.dlocation = 'Houston';

/*
Prediction Result:
('Zeta',)
('Beta',)
('Gamma',)
*/