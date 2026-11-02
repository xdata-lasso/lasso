-- Schema DDL
CREATE TABLE "works_on" ("Essn" INTEGER, "Pno" INTEGER, "Hours" REAL, PRIMARY KEY ("Essn", "Pno"));

CREATE TABLE "employee" ("Ssn" INTEGER PRIMARY KEY, "Fname" TEXT, "Minit" TEXT, "Lname" TEXT, "Bdate" TEXT, "Address" TEXT, "Sex" TEXT, "Salary" INTEGER, "Super_ssn" INTEGER, "Dno" INTEGER);

CREATE TABLE "department" ("Dnumber" INTEGER PRIMARY KEY, "Dname" TEXT, "Mgr_ssn" INTEGER, "Mgr_start_date" TEXT);

CREATE TABLE "project" ("Pnumber" INTEGER PRIMARY KEY, "Pname" TEXT, "Plocation" TEXT, "Dnum" INTEGER);

CREATE TABLE "dependent" ("Essn" INTEGER, "Dependent_name" TEXT, "Sex" TEXT, "Bdate" TEXT, "Relationship" TEXT, PRIMARY KEY ("Essn", "Dependent_name"));

CREATE TABLE "dept_locations" ("Dnumber" INTEGER, "Dlocation" TEXT, PRIMARY KEY ("Dnumber", "Dlocation"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "works_on" ("essn", "pno", "hours") VALUES (-9154553031500726524, 12, -9154553031500726524);
INSERT INTO "works_on" ("essn", "pno", "hours") VALUES (-9154553031500726524, 11, -9154553031500726524);
INSERT INTO "employee" ("ssn", "fname", "minit", "lname", "bdate", "address", "sex", "salary", "super_ssn", "dno") VALUES (14, 'F', 'F', 'F', 'F', 'F', 'F', -9154553031500726524, -9154553031500726524, -9154553031500726524);
INSERT INTO "employee" ("ssn", "fname", "minit", "lname", "bdate", "address", "sex", "salary", "super_ssn", "dno") VALUES (13, 'F', 'F', 'F', 'F', 'F', 'F', -9154553031500726524, -9154553031500726524, -9154553031500726524);
INSERT INTO "department" ("dnumber", "dname", "mgr_ssn", "mgr_start_date") VALUES (16, 'F', -9154553031500726524, 'F');
INSERT INTO "department" ("dnumber", "dname", "mgr_ssn", "mgr_start_date") VALUES (15, 'F', -9154553031500726524, 'F');
INSERT INTO "project" ("pnumber", "pname", "plocation", "dnum") VALUES (18, 'F', 'F', -9154553031500726524);
INSERT INTO "project" ("pnumber", "pname", "plocation", "dnum") VALUES (17, 'F', 'F', -9154553031500726524);
INSERT INTO "dependent" ("essn", "dependent_name", "sex", "bdate", "relationship") VALUES (19, 'F20', 'F', 'F24', 'F25');
INSERT INTO "dept_locations" ("dnumber", "dlocation") VALUES (-9154553031500726524, 'F22');
INSERT INTO "dept_locations" ("dnumber", "dlocation") VALUES (-9154553031500726524, 'F21');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "n" AS "count___" FROM (SELECT "sex", COUNT(*) AS "n" FROM "dependent" GROUP BY "sex") WHERE ("sex" = 'F') ORDER BY count___;

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT COUNT(*) FROM dependent WHERE sex = 'F';

/*
Prediction Result:
(1,)
*/