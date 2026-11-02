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
INSERT INTO employee (Ssn, Fname, Minit, Lname, Bdate, Address, Sex, Salary, Super_ssn, Dno) VALUES (101, 'Zack', 'A', 'Taylor', '1980-01-01', '100 Main St', 'M', 30001, NULL, 1);
INSERT INTO employee (Ssn, Fname, Minit, Lname, Bdate, Address, Sex, Salary, Super_ssn, Dno) VALUES (102, 'Alice', 'B', 'Brown', '1985-05-12', '200 Oak Ave', 'F', 30000, 101, 1);
INSERT INTO employee (Ssn, Fname, Minit, Lname, Bdate, Address, Sex, Salary, Super_ssn, Dno) VALUES (103, 'Bob', 'C', 'Jones', '1990-07-23', '300 Pine Rd', 'M', 29999, 101, 1);
INSERT INTO employee (Ssn, Fname, Minit, Lname, Bdate, Address, Sex, Salary, Super_ssn, Dno) VALUES (104, 'Charlie', 'D', 'Davis', '1975-11-30', '400 Elm St', 'M', 50000, NULL, 2);
INSERT INTO employee (Ssn, Fname, Minit, Lname, Bdate, Address, Sex, Salary, Super_ssn, Dno) VALUES (105, 'Diana', 'E', 'Evans', '1988-03-15', '500 Maple Dr', 'F', NULL, 104, 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT fname, lname FROM employee WHERE (salary > 30000) ORDER BY fname, employee.ssn NULLS LAST;

/*
Gold Result:
('Charlie', 'Davis')
('Zack', 'Taylor')
*/

-- Prediction Query
SELECT fname, lname FROM employee WHERE salary > 30000;

/*
Prediction Result:
('Zack', 'Taylor')
('Charlie', 'Davis')
*/