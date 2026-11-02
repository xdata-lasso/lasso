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
-- Tests basic ordering by Fname, secondary tie-breaking by Ssn (inverting Lname order vs Ssn order), and ensures no spurious filtering occurs on Sex, Salary, Super_ssn, or Dno.
INSERT INTO employee (Ssn, Fname, Minit, Lname, Bdate, Address, Sex, Salary, Super_ssn, Dno) VALUES (300, 'Alice', 'A', 'Adams', '1980-01-01', '100 Main St', 'F', 60000, NULL, 1);
INSERT INTO employee (Ssn, Fname, Minit, Lname, Bdate, Address, Sex, Salary, Super_ssn, Dno) VALUES (100, 'Alice', 'B', 'Zimmerman', '1985-05-05', '200 Oak Ave', 'M', 25000, 300, NULL);
INSERT INTO employee (Ssn, Fname, Minit, Lname, Bdate, Address, Sex, Salary, Super_ssn, Dno) VALUES (200, 'Bob', 'C', 'Baker', '1990-10-10', '300 Pine Rd', 'M', 0, 100, 99);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT fname, lname, address FROM employee ORDER BY fname, employee.ssn NULLS LAST;

/*
Gold Result:
('Alice', 'Zimmerman', '200 Oak Ave')
('Alice', 'Adams', '100 Main St')
('Bob', 'Baker', '300 Pine Rd')
*/

-- Prediction Query
SELECT fname, lname, address FROM employee ORDER BY Bdate, employee.ssn NULLS LAST;

/*
Prediction Result:
('Alice', 'Adams', '100 Main St')
('Alice', 'Zimmerman', '200 Oak Ave')
('Bob', 'Baker', '300 Pine Rd')
*/