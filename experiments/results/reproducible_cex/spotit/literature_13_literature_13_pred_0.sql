-- Schema DDL
CREATE TABLE "EMP" (
    "NAME" INT,
    "DEPT" INT,
    "EMP" INT
);
CREATE TABLE "DEPT" (
    "DEPT" INT,
    "LOC" INT,
    "MGR" INT
);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO EMP VALUES (0, NULL, NULL);
INSERT INTO EMP VALUES (0, NULL, 0);
INSERT INTO DEPT VALUES (0, 3, 0);
INSERT INTO DEPT VALUES (NULL, 3, 0);
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
(0,)
(0,)
*/