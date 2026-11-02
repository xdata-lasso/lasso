-- Schema DDL
CREATE TABLE "emp" ("name" INTEGER, "dept" INTEGER, "emp" INTEGER);

CREATE TABLE "dept" ("dept" INTEGER, "loc" INTEGER, "mgr" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "emp" ("name", "dept", "emp") VALUES (NULL, 20, NULL);
INSERT INTO "emp" ("name", "dept", "emp") VALUES (NULL, 20, 19);
INSERT INTO "emp" ("name", "dept", "emp") VALUES (22, 20, NULL);
INSERT INTO "dept" ("dept", "loc", "mgr") VALUES (20, 16, 20);
INSERT INTO "dept" ("dept", "loc", "mgr") VALUES (20, 3, 19);
INSERT INTO "dept" ("dept", "loc", "mgr") VALUES (20, 17, 20);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT X.NAME AS XN FROM EMP AS X WHERE (X.EMP, X.DEPT) IN (SELECT Y.MGR, Y.DEPT FROM DEPT AS Y WHERE Y.LOC = 3);

/*
Gold Result:
(None,)
*/

-- Prediction Query
SELECT X.NAME AS XN FROM EMP AS X;

/*
Prediction Result:
(None,)
(None,)
(22,)
*/