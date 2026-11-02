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
INSERT INTO department (Dnumber, Dname, Mgr_ssn, Mgr_start_date) VALUES (1, 'Headquarters', 300, '1981-06-19');
INSERT INTO department (Dnumber, Dname, Mgr_ssn, Mgr_start_date) VALUES (5, 'Research', 100, '1988-05-22');
INSERT INTO employee (Ssn, Fname, Minit, Lname, Bdate, Address, Sex, Salary, Super_ssn, Dno) VALUES (100, 'Charlie', 'C', 'Clark', '1965-01-09', '731 Fondren, Houston, TX', 'M', 30000, 300, 5);
INSERT INTO employee (Ssn, Fname, Minit, Lname, Bdate, Address, Sex, Salary, Super_ssn, Dno) VALUES (200, 'Alice', 'Z', 'Zimmer', '1970-12-08', '999 Oak St, Bellaire, TX', 'F', 50000, 300, 5);
INSERT INTO employee (Ssn, Fname, Minit, Lname, Bdate, Address, Sex, Salary, Super_ssn, Dno) VALUES (300, 'Alice', 'A', 'Adams', '1955-05-01', '100 Main St, Houston, TX', 'F', 25000, NULL, 1);
INSERT INTO employee (Ssn, Fname, Minit, Lname, Bdate, Address, Sex, Salary, Super_ssn, Dno) VALUES (400, 'Bob', 'Y', 'Young', '1980-07-15', '800 Pine St, Sugarland, TX', 'M', 45000, 100, 5);
INSERT INTO employee (Ssn, Fname, Minit, Lname, Bdate, Address, Sex, Salary, Super_ssn, Dno) VALUES (500, 'Bob', 'B', 'Baker', '1960-03-20', '200 Elm St, Houston, TX', 'M', 20000, 200, 1);
INSERT INTO dept_locations (Dnumber, Dlocation) VALUES (1, 'Houston');
INSERT INTO dept_locations (Dnumber, Dlocation) VALUES (5, 'Bellaire');
INSERT INTO dept_locations (Dnumber, Dlocation) VALUES (5, 'Sugarland');
INSERT INTO project (Pnumber, Pname, Plocation, Dnum) VALUES (10, 'ProductX', 'Bellaire', 5);
INSERT INTO project (Pnumber, Pname, Plocation, Dnum) VALUES (20, 'ProductY', 'Sugarland', 5);
INSERT INTO works_on (Essn, Pno, Hours) VALUES (100, 10, 32.5);
INSERT INTO works_on (Essn, Pno, Hours) VALUES (100, 20, 7.5);
INSERT INTO works_on (Essn, Pno, Hours) VALUES (200, 10, 40.0);
INSERT INTO dependent (Essn, Dependent_name, Sex, Bdate, Relationship) VALUES (100, 'Michael', 'M', '1988-01-04', 'Son');
INSERT INTO dependent (Essn, Dependent_name, Sex, Bdate, Relationship) VALUES (100, 'Alice', 'F', '1988-12-30', 'Daughter');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT fname, lname, address FROM employee ORDER BY fname, employee.ssn NULLS LAST;

/*
Gold Result:
('Alice', 'Zimmer', '999 Oak St, Bellaire, TX')
('Alice', 'Adams', '100 Main St, Houston, TX')
('Bob', 'Young', '800 Pine St, Sugarland, TX')
('Bob', 'Baker', '200 Elm St, Houston, TX')
('Charlie', 'Clark', '731 Fondren, Houston, TX')
*/

-- Prediction Query
SELECT fname, lname, address FROM employee ORDER BY Bdate, employee.ssn NULLS LAST;

/*
Prediction Result:
('Alice', 'Adams', '100 Main St, Houston, TX')
('Bob', 'Baker', '200 Elm St, Houston, TX')
('Charlie', 'Clark', '731 Fondren, Houston, TX')
('Alice', 'Zimmer', '999 Oak St, Bellaire, TX')
('Bob', 'Young', '800 Pine St, Sugarland, TX')
*/