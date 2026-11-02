-- Schema DDL
CREATE TABLE "works_on" ("Essn" INTEGER, "Pno" INTEGER, "Hours" REAL, PRIMARY KEY ("Essn", "Pno"));

CREATE TABLE "employee" ("Ssn" INTEGER PRIMARY KEY, "Fname" TEXT, "Minit" TEXT, "Lname" TEXT, "Bdate" TEXT, "Address" TEXT, "Sex" TEXT, "Salary" INTEGER, "Super_ssn" INTEGER, "Dno" INTEGER);

CREATE TABLE "department" ("Dnumber" INTEGER PRIMARY KEY, "Dname" TEXT, "Mgr_ssn" INTEGER, "Mgr_start_date" TEXT);

CREATE TABLE "project" ("Pnumber" INTEGER PRIMARY KEY, "Pname" TEXT, "Plocation" TEXT, "Dnum" INTEGER);

CREATE TABLE "dependent" ("Essn" INTEGER, "Dependent_name" TEXT, "Sex" TEXT, "Bdate" TEXT, "Relationship" TEXT, PRIMARY KEY ("Essn", "Dependent_name"));

CREATE TABLE "dept_locations" ("Dnumber" INTEGER, "Dlocation" TEXT, PRIMARY KEY ("Dnumber", "Dlocation"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "employee" ("ssn", "fname", "minit", "lname", "bdate", "address", "sex", "salary", "super_ssn", "dno") VALUES (1010, 'Stephen', 'capital', 'Dudley', 'human', '327 Nelson Route
Lake Mark, WI 07832', 'drop', 1011, 1012, 1013);
INSERT INTO "employee" ("ssn", "fname", "minit", "lname", "bdate", "address", "sex", "salary", "super_ssn", "dno") VALUES (1014, 'Lydia', 'example', 'Miles', 'result', '959 Janet Cape Apt. 413
South Joshuastad, GA 49021', 'hear', 1012, 1013, 1014);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT fname, lname, address FROM employee ORDER BY fname, employee.ssn NULLS LAST;

/*
Gold Result:
('Lydia', 'Miles', '959 Janet Cape Apt. 413\nSouth Joshuastad, GA 49021')
('Stephen', 'Dudley', '327 Nelson Route\nLake Mark, WI 07832')
*/

-- Prediction Query
SELECT fname, lname, address FROM employee ORDER BY Bdate, employee.ssn NULLS LAST;

/*
Prediction Result:
('Stephen', 'Dudley', '327 Nelson Route\nLake Mark, WI 07832')
('Lydia', 'Miles', '959 Janet Cape Apt. 413\nSouth Joshuastad, GA 49021')
*/