-- Schema DDL
CREATE TABLE "works_on" ("Essn" INTEGER, "Pno" INTEGER, "Hours" REAL, PRIMARY KEY ("Essn", "Pno"));

CREATE TABLE "employee" ("Ssn" INTEGER PRIMARY KEY, "Fname" TEXT, "Minit" TEXT, "Lname" TEXT, "Bdate" TEXT, "Address" TEXT, "Sex" TEXT, "Salary" INTEGER, "Super_ssn" INTEGER, "Dno" INTEGER);

CREATE TABLE "department" ("Dnumber" INTEGER PRIMARY KEY, "Dname" TEXT, "Mgr_ssn" INTEGER, "Mgr_start_date" TEXT);

CREATE TABLE "project" ("Pnumber" INTEGER PRIMARY KEY, "Pname" TEXT, "Plocation" TEXT, "Dnum" INTEGER);

CREATE TABLE "dependent" ("Essn" INTEGER, "Dependent_name" TEXT, "Sex" TEXT, "Bdate" TEXT, "Relationship" TEXT, PRIMARY KEY ("Essn", "Dependent_name"));

CREATE TABLE "dept_locations" ("Dnumber" INTEGER, "Dlocation" TEXT, PRIMARY KEY ("Dnumber", "Dlocation"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "employee" ("ssn", "fname", "minit", "lname", "bdate", "address", "sex", "salary", "super_ssn", "dno") VALUES (1040, 'Michael', 'occur', 'Brown', 'former', '46247 Hickman Cliffs Apt. 799
North Amandahaven, KS 17862', 'kind', 30001, 1041, 1042);
INSERT INTO "employee" ("ssn", "fname", "minit", "lname", "bdate", "address", "sex", "salary", "super_ssn", "dno") VALUES (1043, 'Beth', 'other', 'Mills', 'worry', '820 Melissa Cliff Apt. 361
New Brooke, RI 11246', 'worker', 30001, 1042, 1043);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT fname, lname FROM employee WHERE (salary > 30000) ORDER BY fname, employee.ssn NULLS LAST;

/*
Gold Result:
('Beth', 'Mills')
('Michael', 'Brown')
*/

-- Prediction Query
SELECT fname, lname FROM employee WHERE salary > 30000;

/*
Prediction Result:
('Michael', 'Brown')
('Beth', 'Mills')
*/