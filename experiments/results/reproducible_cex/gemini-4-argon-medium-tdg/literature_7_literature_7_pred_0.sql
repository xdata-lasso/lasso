-- Schema DDL
CREATE TABLE "emp" ("name" INTEGER, "dept" INTEGER, "emp" INTEGER);

CREATE TABLE "dept" ("dept" INTEGER, "loc" INTEGER, "mgr" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
-- Tests duplicate elimination (IN vs. INNER JOIN) and preservation of duplicate employee names from distinct employee rows (SELECT vs. SELECT DISTINCT).
INSERT INTO dept (dept, loc, mgr) VALUES (10, 3, 100);
INSERT INTO dept (dept, loc, mgr) VALUES (10, 3, 100);
INSERT INTO dept (dept, loc, mgr) VALUES (20, 3, 200);
INSERT INTO emp (name, dept, emp) VALUES (1, 10, 100);
INSERT INTO emp (name, dept, emp) VALUES (2, 20, 200);
INSERT INTO emp (name, dept, emp) VALUES (2, 20, 200);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT X.NAME AS XN FROM EMP AS X WHERE (X.EMP, X.DEPT) IN (SELECT Y.MGR, Y.DEPT FROM DEPT AS Y WHERE Y.LOC = 3);

/*
Gold Result:
(1,)
(2,)
(2,)
*/

-- Prediction Query
SELECT X.NAME AS XN FROM EMP AS X CROSS JOIN DEPT AS Y WHERE X.DEPT = Y.DEPT AND Y.LOC = 3 AND X.EMP = Y.MGR;

/*
Prediction Result:
(1,)
(1,)
(2,)
(2,)
*/