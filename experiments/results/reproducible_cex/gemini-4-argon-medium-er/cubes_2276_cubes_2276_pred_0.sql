-- Schema DDL
CREATE TABLE "works_on" ("Essn" INTEGER, "Pno" INTEGER, "Hours" REAL, PRIMARY KEY ("Essn", "Pno"));

CREATE TABLE "employee" ("Ssn" INTEGER PRIMARY KEY, "Fname" TEXT, "Minit" TEXT, "Lname" TEXT, "Bdate" TEXT, "Address" TEXT, "Sex" TEXT, "Salary" INTEGER, "Super_ssn" INTEGER, "Dno" INTEGER);

CREATE TABLE "department" ("Dnumber" INTEGER PRIMARY KEY, "Dname" TEXT, "Mgr_ssn" INTEGER, "Mgr_start_date" TEXT);

CREATE TABLE "project" ("Pnumber" INTEGER PRIMARY KEY, "Pname" TEXT, "Plocation" TEXT, "Dnum" INTEGER);

CREATE TABLE "dependent" ("Essn" INTEGER, "Dependent_name" TEXT, "Sex" TEXT, "Bdate" TEXT, "Relationship" TEXT, PRIMARY KEY ("Essn", "Dependent_name"));

CREATE TABLE "dept_locations" ("Dnumber" INTEGER, "Dlocation" TEXT, PRIMARY KEY ("Dnumber", "Dlocation"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO dependent (Essn, Dependent_name, Sex, Bdate, Relationship) VALUES (1, 'John', 'M', '2000-01-01', 'Son');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "n" AS "count___" FROM (SELECT "sex", COUNT(*) AS "n" FROM "dependent" GROUP BY "sex") WHERE ("sex" = 'F') ORDER BY count___;

/*
Gold Result:
*/

-- Prediction Query
SELECT COUNT(*) FROM dependent WHERE sex = 'F';

/*
Prediction Result:
(0,)
*/