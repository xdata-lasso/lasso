-- Schema DDL
CREATE TABLE "emp" ("name" INTEGER, "dept" INTEGER, "emp" INTEGER);

CREATE TABLE "dept" ("dept" INTEGER, "loc" INTEGER, "mgr" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: emp --
INSERT INTO "emp" ("name", "dept", "emp") VALUES (1, -55602865, -59984348);

INSERT INTO "emp" ("name", "dept", "emp") VALUES (1, 1, 1);

INSERT INTO "emp" ("name", "dept", "emp") VALUES (1, -664303813, -1022641847);

INSERT INTO "emp" ("name", "dept", "emp") VALUES (1, -1726781632, 247012447);

INSERT INTO "emp" ("name", "dept", "emp") VALUES (1, 1, 1);

INSERT INTO "emp" ("name", "dept", "emp") VALUES (1, 1, 1);

INSERT INTO "emp" ("name", "dept", "emp") VALUES (1, -1980249628, -734455130);

INSERT INTO "emp" ("name", "dept", "emp") VALUES (1, 2, 1);

INSERT INTO "emp" ("name", "dept", "emp") VALUES (1, 1744686505, -1633151678);

INSERT INTO "emp" ("name", "dept", "emp") VALUES (1, 1, 1);

INSERT INTO "emp" ("name", "dept", "emp") VALUES (1, -252690330, 1115440883);

INSERT INTO "emp" ("name", "dept", "emp") VALUES (1, 1, 2);

INSERT INTO "emp" ("name", "dept", "emp") VALUES (NULL, 1644814318, 1465859724);

INSERT INTO "emp" ("name", "dept", "emp") VALUES (NULL, 1, 1);

-- Inserting into table: dept --
INSERT INTO "dept" ("dept", "loc", "mgr") VALUES (1, 3, 1);

INSERT INTO "dept" ("dept", "loc", "mgr") VALUES (1, 3, 1);

INSERT INTO "dept" ("dept", "loc", "mgr") VALUES (1, 3, 1);

INSERT INTO "dept" ("dept", "loc", "mgr") VALUES (3, 3, 1);

INSERT INTO "dept" ("dept", "loc", "mgr") VALUES (1, 1, 1);

INSERT INTO "dept" ("dept", "loc", "mgr") VALUES (1, 3, 3);

INSERT INTO "dept" ("dept", "loc", "mgr") VALUES (1, 3, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT X.NAME AS XN FROM EMP AS X WHERE (X.EMP, X.DEPT) IN (SELECT Y.MGR, Y.DEPT FROM DEPT AS Y WHERE Y.LOC = 3);

/*
Gold Result:
(1,)
(1,)
(1,)
(1,)
(None,)
*/

-- Prediction Query
SELECT X.NAME AS XN FROM EMP AS X CROSS JOIN DEPT AS Y WHERE X.DEPT = Y.DEPT AND Y.LOC = 3 AND X.EMP = Y.MGR;

/*
Prediction Result:
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(None,)
(None,)
(None,)
(None,)
*/