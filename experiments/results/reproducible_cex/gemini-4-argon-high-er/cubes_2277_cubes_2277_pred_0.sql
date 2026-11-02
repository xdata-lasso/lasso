-- Schema DDL
CREATE TABLE "works_on" ("Essn" INTEGER, "Pno" INTEGER, "Hours" REAL, PRIMARY KEY ("Essn", "Pno"));

CREATE TABLE "employee" ("Ssn" INTEGER PRIMARY KEY, "Fname" TEXT, "Minit" TEXT, "Lname" TEXT, "Bdate" TEXT, "Address" TEXT, "Sex" TEXT, "Salary" INTEGER, "Super_ssn" INTEGER, "Dno" INTEGER);

CREATE TABLE "department" ("Dnumber" INTEGER PRIMARY KEY, "Dname" TEXT, "Mgr_ssn" INTEGER, "Mgr_start_date" TEXT);

CREATE TABLE "project" ("Pnumber" INTEGER PRIMARY KEY, "Pname" TEXT, "Plocation" TEXT, "Dnum" INTEGER);

CREATE TABLE "dependent" ("Essn" INTEGER, "Dependent_name" TEXT, "Sex" TEXT, "Bdate" TEXT, "Relationship" TEXT, PRIMARY KEY ("Essn", "Dependent_name"));

CREATE TABLE "dept_locations" ("Dnumber" INTEGER, "Dlocation" TEXT, PRIMARY KEY ("Dnumber", "Dlocation"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO employee (Ssn, Fname, Lname) VALUES (1, 'John', 'Doe');
INSERT INTO employee (Ssn, Fname, Lname) VALUES (2, 'Jane', 'Smith');
INSERT INTO dependent (Essn, Dependent_name, Sex, Bdate, Relationship) VALUES (1, 'Bob', 'M', '1980-01-01', 'Spouse');
INSERT INTO dependent (Essn, Dependent_name, Sex, Bdate, Relationship) VALUES (2, 'Alice', 'F', '1985-01-01', 'Spouse');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "dependent_name" FROM "dependent" WHERE ("relationship" = 'Spouse') ORDER BY dependent_name, dependent.essn NULLS LAST;

/*
Gold Result:
('Alice',)
('Bob',)
*/

-- Prediction Query
SELECT Dependent_name FROM dependent WHERE relationship = 'Spouse';

/*
Prediction Result:
('Bob',)
('Alice',)
*/