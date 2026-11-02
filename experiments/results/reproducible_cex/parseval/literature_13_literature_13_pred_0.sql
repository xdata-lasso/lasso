-- Schema DDL
CREATE TABLE "emp" ("name" INTEGER, "dept" INTEGER, "emp" INTEGER);

CREATE TABLE "dept" ("dept" INTEGER, "loc" INTEGER, "mgr" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: emp --
INSERT INTO "emp" ("name", "dept", "emp") VALUES (1, -55602865, -59984348);

INSERT INTO "emp" ("name", "dept", "emp") VALUES (1, -664303813, -1022641847);

INSERT INTO "emp" ("name", "dept", "emp") VALUES (1, -1726781632, 247012447);

INSERT INTO "emp" ("name", "dept", "emp") VALUES (1, -1980249628, -734455130);

INSERT INTO "emp" ("name", "dept", "emp") VALUES (1, 1744686505, -1633151678);

INSERT INTO "emp" ("name", "dept", "emp") VALUES (1, -252690330, 1115440883);

INSERT INTO "emp" ("name", "dept", "emp") VALUES (NULL, 1644814318, 1465859724);

INSERT INTO "emp" ("name", "dept", "emp") VALUES (NULL, -1349201381, 1019800248);

INSERT INTO "emp" ("name", "dept", "emp") VALUES (1, -1910425938, -845863578);

INSERT INTO "emp" ("name", "dept", "emp") VALUES (1, -1610064545, 429706943);

INSERT INTO "emp" ("name", "dept", "emp") VALUES (1, 462974032, -1137908826);

INSERT INTO "emp" ("name", "dept", "emp") VALUES (1, -918961358, -1602639011);

INSERT INTO "emp" ("name", "dept", "emp") VALUES (1, -45536098, 1861536320);

INSERT INTO "emp" ("name", "dept", "emp") VALUES (1, 44952191, 1151980946);

-- Inserting into table: dept --
INSERT INTO "dept" ("dept", "loc", "mgr") VALUES (1, 3, 1);

INSERT INTO "dept" ("dept", "loc", "mgr") VALUES (1, 3, 1);

INSERT INTO "dept" ("dept", "loc", "mgr") VALUES (1, 3, 1);

INSERT INTO "dept" ("dept", "loc", "mgr") VALUES (1, 3, 1);

INSERT INTO "dept" ("dept", "loc", "mgr") VALUES (NULL, 3, 1);

INSERT INTO "dept" ("dept", "loc", "mgr") VALUES (1, 3, NULL);

INSERT INTO "dept" ("dept", "loc", "mgr") VALUES (1, 3, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT X.NAME AS XN FROM EMP AS X WHERE (X.EMP, X.DEPT) IN (SELECT Y.MGR, Y.DEPT FROM DEPT AS Y WHERE Y.LOC = 3);

/*
Gold Result:
*/

-- Prediction Query
SELECT X.NAME AS XN FROM EMP AS X;

/*
Prediction Result:
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(None,)
(None,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
*/