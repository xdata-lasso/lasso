-- Schema DDL
CREATE TABLE "emp" ("name" INTEGER, "dept" INTEGER, "emp" INTEGER);

CREATE TABLE "dept" ("dept" INTEGER, "loc" INTEGER, "mgr" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic positive match, partial matches on EMP or DEPT alone, and filtering on LOC = 3 (including boundary values 2, 4, and NULL).
INSERT INTO "dept" ("dept", "loc", "mgr") VALUES (10, 3, 100);
INSERT INTO "dept" ("dept", "loc", "mgr") VALUES (20, 2, 200);
INSERT INTO "dept" ("dept", "loc", "mgr") VALUES (30, 4, 300);
INSERT INTO "dept" ("dept", "loc", "mgr") VALUES (40, NULL, 400);
INSERT INTO "emp" ("name", "dept", "emp") VALUES (1, 10, 100);
INSERT INTO "emp" ("name", "dept", "emp") VALUES (2, 10, 999);
INSERT INTO "emp" ("name", "dept", "emp") VALUES (3, 99, 100);
INSERT INTO "emp" ("name", "dept", "emp") VALUES (4, 20, 200);
INSERT INTO "emp" ("name", "dept", "emp") VALUES (5, 30, 300);
INSERT INTO "emp" ("name", "dept", "emp") VALUES (6, 40, 400);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT X.NAME AS XN FROM EMP AS X WHERE (X.EMP, X.DEPT) IN (SELECT Y.MGR, Y.DEPT FROM DEPT AS Y WHERE Y.LOC = 3);

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT X.NAME AS XN FROM EMP AS X;

/*
Prediction Result:
(1,)
(2,)
(3,)
(4,)
(5,)
(6,)
*/