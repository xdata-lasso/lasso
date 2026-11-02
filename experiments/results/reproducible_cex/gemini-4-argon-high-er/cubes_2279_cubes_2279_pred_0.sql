-- Schema DDL
CREATE TABLE "works_on" ("Essn" INTEGER, "Pno" INTEGER, "Hours" REAL, PRIMARY KEY ("Essn", "Pno"));

CREATE TABLE "employee" ("Ssn" INTEGER PRIMARY KEY, "Fname" TEXT, "Minit" TEXT, "Lname" TEXT, "Bdate" TEXT, "Address" TEXT, "Sex" TEXT, "Salary" INTEGER, "Super_ssn" INTEGER, "Dno" INTEGER);

CREATE TABLE "department" ("Dnumber" INTEGER PRIMARY KEY, "Dname" TEXT, "Mgr_ssn" INTEGER, "Mgr_start_date" TEXT);

CREATE TABLE "project" ("Pnumber" INTEGER PRIMARY KEY, "Pname" TEXT, "Plocation" TEXT, "Dnum" INTEGER);

CREATE TABLE "dependent" ("Essn" INTEGER, "Dependent_name" TEXT, "Sex" TEXT, "Bdate" TEXT, "Relationship" TEXT, PRIMARY KEY ("Essn", "Dependent_name"));

CREATE TABLE "dept_locations" ("Dnumber" INTEGER, "Dlocation" TEXT, PRIMARY KEY ("Dnumber", "Dlocation"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO employee (Ssn, Fname, Lname, Bdate, Address) VALUES (1, 'Alice', 'Smith', '1990-01-01', 'Addr1');
INSERT INTO employee (Ssn, Fname, Lname, Bdate, Address) VALUES (2, 'Bob', 'Jones', '1980-01-01', 'Addr2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT fname, lname, address FROM employee ORDER BY fname, employee.ssn NULLS LAST;

/*
Gold Result:
('Alice', 'Smith', 'Addr1')
('Bob', 'Jones', 'Addr2')
*/

-- Prediction Query
SELECT fname, lname, address FROM employee ORDER BY Bdate, employee.ssn NULLS LAST;

/*
Prediction Result:
('Bob', 'Jones', 'Addr2')
('Alice', 'Smith', 'Addr1')
*/