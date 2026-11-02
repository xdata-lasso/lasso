-- Schema DDL
CREATE TABLE "emp" ("name" INTEGER, "dept" INTEGER, "emp" INTEGER);

CREATE TABLE "dept" ("dept" INTEGER, "loc" INTEGER, "mgr" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "emp" ("name", "dept", "emp") VALUES (22, 20, 21);
INSERT INTO "emp" ("name", "dept", "emp") VALUES (25, 24, NULL);
INSERT INTO "dept" ("dept", "loc", "mgr") VALUES (20, 3, 21);
INSERT INTO "dept" ("dept", "loc", "mgr") VALUES (20, 3, 21);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT X.NAME AS XN FROM EMP AS X WHERE (X.EMP, X.DEPT) IN (SELECT Y.MGR, Y.DEPT FROM DEPT AS Y WHERE Y.LOC = 3);

/*
Gold Result:
(22,)
*/

-- Prediction Query
SELECT X.NAME AS XN FROM EMP AS X CROSS JOIN DEPT AS Y WHERE X.DEPT = Y.DEPT AND Y.LOC = 3 AND X.EMP = Y.MGR;

/*
Prediction Result:
(22,)
(22,)
*/