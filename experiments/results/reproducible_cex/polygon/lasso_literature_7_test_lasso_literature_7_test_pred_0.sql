-- Schema DDL
CREATE TABLE emp (name INTEGER, dept INTEGER, emp INTEGER);

CREATE TABLE dept (dept INTEGER, loc INTEGER, mgr INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "emp" ("name", "dept", "emp") VALUES (17, 19, 20);
INSERT INTO "emp" ("name", "dept", "emp") VALUES (NULL, 19, 20);
INSERT INTO "dept" ("dept", "loc", "mgr") VALUES (19, 3, 20);
INSERT INTO "dept" ("dept", "loc", "mgr") VALUES (19, 3, 20);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT X.NAME AS XN FROM EMP AS X WHERE (X.EMP, X.DEPT) IN (SELECT Y.MGR, Y.DEPT FROM DEPT AS Y WHERE Y.LOC = 3);

/*
Gold Result:
(17,)
(None,)
*/

-- Prediction Query
SELECT X.NAME AS XN FROM EMP AS X CROSS JOIN DEPT AS Y WHERE X.DEPT = Y.DEPT AND Y.LOC = 3 AND X.EMP = Y.MGR;

/*
Prediction Result:
(17,)
(17,)
(None,)
(None,)
*/