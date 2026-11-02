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
-- Tests basic filtering (Spouse vs Son/Daughter/NULL/case-sensitivity),
-- duplicate dependent_name values (kills DISTINCT/GROUP BY mutants),
-- and ORDER BY sorting on dependent_name.
INSERT INTO "department" ("Dnumber", "Dname", "Mgr_ssn", "Mgr_start_date") VALUES (1, 'Research', 101, '2020-01-01');
INSERT INTO "employee" ("Ssn", "Fname", "Minit", "Lname", "Bdate", "Address", "Sex", "Salary", "Super_ssn", "Dno") VALUES (101, 'John', 'B', 'Smith', '1980-01-01', '123 Main St', 'M', 50000, NULL, 1);
INSERT INTO "employee" ("Ssn", "Fname", "Minit", "Lname", "Bdate", "Address", "Sex", "Salary", "Super_ssn", "Dno") VALUES (102, 'Franklin', 'T', 'Wong', '1975-05-05', '456 Oak St', 'M', 60000, 101, 1);
INSERT INTO "employee" ("Ssn", "Fname", "Minit", "Lname", "Bdate", "Address", "Sex", "Salary", "Super_ssn", "Dno") VALUES (103, 'Alicia', 'J', 'Zelaya', '1985-09-09', '789 Pine St', 'F', 45000, 101, 1);
INSERT INTO "dependent" ("Essn", "Dependent_name", "Sex", "Bdate", "Relationship") VALUES (102, 'Zoe', 'F', '1976-02-02', 'Spouse');
INSERT INTO "dependent" ("Essn", "Dependent_name", "Sex", "Bdate", "Relationship") VALUES (101, 'Alice', 'F', '1982-03-03', 'Spouse');
INSERT INTO "dependent" ("Essn", "Dependent_name", "Sex", "Bdate", "Relationship") VALUES (103, 'Alice', 'F', '1984-04-04', 'Spouse');
INSERT INTO "dependent" ("Essn", "Dependent_name", "Sex", "Bdate", "Relationship") VALUES (101, 'Bob', 'M', '2005-06-06', 'Son');
INSERT INTO "dependent" ("Essn", "Dependent_name", "Sex", "Bdate", "Relationship") VALUES (102, 'Charlie', 'M', '1978-07-07', 'spouse');
INSERT INTO "dependent" ("Essn", "Dependent_name", "Sex", "Bdate", "Relationship") VALUES (103, 'Diana', 'F', '2010-08-08', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "dependent_name" FROM "dependent" WHERE ("relationship" = 'Spouse') ORDER BY dependent_name, dependent.essn NULLS LAST;

/*
Gold Result:
('Alice',)
('Alice',)
('Zoe',)
*/

-- Prediction Query
SELECT Dependent_name FROM dependent WHERE relationship = 'Spouse';

/*
Prediction Result:
('Zoe',)
('Alice',)
('Alice',)
*/