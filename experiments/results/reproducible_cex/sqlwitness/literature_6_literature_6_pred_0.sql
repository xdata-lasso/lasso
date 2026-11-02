-- Schema DDL
CREATE TABLE "payroll" ("ssno" INTEGER, "deptno" INTEGER);

CREATE TABLE "applicant" ("ssno" INTEGER, "jobtitile" INTEGER, "officeno" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO applicant (ssno, jobtitile, officeno) VALUES (1, 29, 29), (30, 1, 29), (NULL, 1, 28), (28, 1, 0);
INSERT INTO payroll (ssno, deptno) VALUES (28, 1), (28, 29), (29, 0), (0, 0), (28, 29), (0, 29), (29, 29), (30, 29), (30, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT Y.* FROM PAYROLL AS X CROSS JOIN APPLICANT AS Y WHERE X.SSNO = Y.SSNO AND X.DEPTNO = 29;

/*
Gold Result:
(28, 1, 0)
(28, 1, 0)
(30, 1, 29)
*/

-- Prediction Query
SELECT C.* FROM PAYROLL AS A CROSS JOIN (SELECT Y.SSNO, Y.DEPTNO FROM PAYROLL AS Y) AS B CROSS JOIN APPLICANT AS C WHERE A.SSNO = B.SSNO AND C.SSNO = A.SSNO AND B.DEPTNO = 29;

/*
Prediction Result:
(28, 1, 0)
(28, 1, 0)
(28, 1, 0)
(28, 1, 0)
(28, 1, 0)
(28, 1, 0)
(30, 1, 29)
(30, 1, 29)
*/