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
INSERT INTO employee (Ssn, Fname, Minit, Lname, Bdate, Address, Sex, Salary, Super_ssn, Dno) VALUES (101, 'John', 'B', 'Smith', '1980-01-09', '731 Fondren, Houston, TX', 'M', 30000, NULL, 1);
INSERT INTO employee (Ssn, Fname, Minit, Lname, Bdate, Address, Sex, Salary, Super_ssn, Dno) VALUES (102, 'Franklin', 'T', 'Wong', '1975-12-08', '638 Voss, Houston, TX', 'M', 40000, 101, 1);
INSERT INTO employee (Ssn, Fname, Minit, Lname, Bdate, Address, Sex, Salary, Super_ssn, Dno) VALUES (103, 'Alicia', 'J', 'Zelaya', '1982-07-19', '3321 Castle, Spring, TX', 'F', 25000, 101, 1);
INSERT INTO employee (Ssn, Fname, Minit, Lname, Bdate, Address, Sex, Salary, Super_ssn, Dno) VALUES (104, ' Ramesh', 'K', 'Narayan', '1985-09-15', '975 Fire Oak, Humble, TX', 'M', 38000, 102, 1);
INSERT INTO dependent (Essn, Dependent_name, Sex, Bdate, Relationship) VALUES (101, 'Zara', 'F', '1982-04-12', 'Spouse');
INSERT INTO dependent (Essn, Dependent_name, Sex, Bdate, Relationship) VALUES (102, 'Alice', 'F', '1978-01-01', 'Spouse');
INSERT INTO dependent (Essn, Dependent_name, Sex, Bdate, Relationship) VALUES (103, 'David', 'M', '1980-07-23', 'Spouse');
INSERT INTO dependent (Essn, Dependent_name, Sex, Bdate, Relationship) VALUES (104, 'Alice', 'F', '1988-11-30', 'Spouse');
INSERT INTO dependent (Essn, Dependent_name, Sex, Bdate, Relationship) VALUES (101, 'Bob', 'M', '2010-05-15', 'Son');
INSERT INTO dependent (Essn, Dependent_name, Sex, Bdate, Relationship) VALUES (102, 'Clara', 'F', '2012-08-20', 'Daughter');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "dependent_name" FROM "dependent" WHERE ("relationship" = 'Spouse') ORDER BY dependent_name, dependent.essn NULLS LAST;

/*
Gold Result:
('Alice',)
('Alice',)
('David',)
('Zara',)
*/

-- Prediction Query
SELECT Dependent_name FROM dependent WHERE relationship = 'Spouse';

/*
Prediction Result:
('Zara',)
('Alice',)
('David',)
('Alice',)
*/