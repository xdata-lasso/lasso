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
INSERT INTO "employee" ("Ssn", "Fname", "Minit", "Lname", "Bdate", "Address", "Sex", "Salary", "Super_ssn", "Dno") VALUES (201, 'Mary', 'C', 'Johnson', '1975-07-07', '789 Pine', 'F', 70000, NULL, NULL);
INSERT INTO "dependent" ("Essn", "Dependent_name", "Sex", "Bdate", "Relationship") VALUES (201, 'Charlie', 'M', '2005-08-08', 'Son');
INSERT INTO "dependent" ("Essn", "Dependent_name", "Sex", "Bdate", "Relationship") VALUES (201, 'David', 'M', '2007-09-09', 'Son');
INSERT INTO "dependent" ("Essn", "Dependent_name", "Sex", "Bdate", "Relationship") VALUES (201, 'Alex', NULL, '2009-10-10', 'Child');
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