-- Schema DDL
CREATE TABLE "works_on" ("Essn" INTEGER, "Pno" INTEGER, "Hours" REAL, PRIMARY KEY ("Essn", "Pno"));

CREATE TABLE "employee" ("Ssn" INTEGER PRIMARY KEY, "Fname" TEXT, "Minit" TEXT, "Lname" TEXT, "Bdate" TEXT, "Address" TEXT, "Sex" TEXT, "Salary" INTEGER, "Super_ssn" INTEGER, "Dno" INTEGER);

CREATE TABLE "department" ("Dnumber" INTEGER PRIMARY KEY, "Dname" TEXT, "Mgr_ssn" INTEGER, "Mgr_start_date" TEXT);

CREATE TABLE "project" ("Pnumber" INTEGER PRIMARY KEY, "Pname" TEXT, "Plocation" TEXT, "Dnum" INTEGER);

CREATE TABLE "dependent" ("Essn" INTEGER, "Dependent_name" TEXT, "Sex" TEXT, "Bdate" TEXT, "Relationship" TEXT, PRIMARY KEY ("Essn", "Dependent_name"));

CREATE TABLE "dept_locations" ("Dnumber" INTEGER, "Dlocation" TEXT, PRIMARY KEY ("Dnumber", "Dlocation"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
-- Tests empty result set for the Gold Query vs 0 for a flat SELECT COUNT(*) WHERE sex = 'F' (no 'F' dependents exist).
-- Also tests employee vs dependent table confusion (employees are 'F', dependents are 'M' or 'f').
INSERT INTO "employee" ("Ssn", "Fname", "Minit", "Lname", "Bdate", "Address", "Sex", "Salary", "Super_ssn", "Dno") VALUES (201, 'Jennifer', 'S', 'Wallace', '1941-06-20', '291 Berry', 'F', 43000, NULL, 1);
INSERT INTO "employee" ("Ssn", "Fname", "Minit", "Lname", "Bdate", "Address", "Sex", "Salary", "Super_ssn", "Dno") VALUES (202, 'Joyce', 'A', 'English', '1972-07-31', '5631 Rice', 'F', 25000, 201, 1);
INSERT INTO "dependent" ("Essn", "Dependent_name", "Sex", "Bdate", "Relationship") VALUES (201, 'Abner', 'M', '1942-02-28', 'Spouse');
INSERT INTO "dependent" ("Essn", "Dependent_name", "Sex", "Bdate", "Relationship") VALUES (202, 'Theodore', 'M', '1973-10-25', 'Son');
INSERT INTO "dependent" ("Essn", "Dependent_name", "Sex", "Bdate", "Relationship") VALUES (202, 'LowerF', 'f', '1995-03-15', 'Daughter');
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