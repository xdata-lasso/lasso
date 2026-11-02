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
-- Tests basic ordering by Fname (out of insertion order), tie-breaking by Ssn (inserted in reverse Ssn order), and duplicate projection rows (to kill DISTINCT mutants).
INSERT INTO "employee" ("Ssn", "Fname", "Minit", "Lname", "Bdate", "Address", "Sex", "Salary", "Super_ssn", "Dno") VALUES (300, 'Charlie', 'C', 'Clark', '1970-01-01', '789 Pine', 'M', 70000, NULL, 1);
INSERT INTO "employee" ("Ssn", "Fname", "Minit", "Lname", "Bdate", "Address", "Sex", "Salary", "Super_ssn", "Dno") VALUES (200, 'Alice', 'A', 'Smith', '1980-01-01', '123 Maple', 'F', 60000, 300, 1);
INSERT INTO "employee" ("Ssn", "Fname", "Minit", "Lname", "Bdate", "Address", "Sex", "Salary", "Super_ssn", "Dno") VALUES (100, 'Alice', 'B', 'Adams', '1985-05-05', '456 Oak', 'F', 50000, 300, 2);
INSERT INTO "employee" ("Ssn", "Fname", "Minit", "Lname", "Bdate", "Address", "Sex", "Salary", "Super_ssn", "Dno") VALUES (400, 'Bob', 'D', 'Davis', '1990-10-10', '101 Elm', 'M', 55000, 200, 2);
INSERT INTO "employee" ("Ssn", "Fname", "Minit", "Lname", "Bdate", "Address", "Sex", "Salary", "Super_ssn", "Dno") VALUES (500, 'Bob', 'E', 'Davis', '1992-12-12', '101 Elm', 'M', 52000, 200, 3);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT fname, lname, address FROM employee ORDER BY fname, employee.ssn NULLS LAST;

/*
Gold Result:
('Alice', 'Adams', '456 Oak')
('Alice', 'Smith', '123 Maple')
('Bob', 'Davis', '101 Elm')
('Bob', 'Davis', '101 Elm')
('Charlie', 'Clark', '789 Pine')
*/

-- Prediction Query
SELECT fname, lname, address FROM employee ORDER BY Bdate, employee.ssn NULLS LAST;

/*
Prediction Result:
('Charlie', 'Clark', '789 Pine')
('Alice', 'Smith', '123 Maple')
('Alice', 'Adams', '456 Oak')
('Bob', 'Davis', '101 Elm')
('Bob', 'Davis', '101 Elm')
*/