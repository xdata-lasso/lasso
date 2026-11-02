-- Schema DDL
CREATE TABLE "payroll" ("ssno" INTEGER, "deptno" INTEGER);

CREATE TABLE "applicant" ("ssno" INTEGER, "jobtitile" INTEGER, "officeno" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 3
INSERT INTO payroll (ssno, deptno) VALUES (10, 29);
INSERT INTO payroll (ssno, deptno) VALUES (10, 29);
INSERT INTO payroll (ssno, deptno) VALUES (20, 29);
INSERT INTO applicant (ssno, jobtitile, officeno) VALUES (10, 100, 200);
INSERT INTO applicant (ssno, jobtitile, officeno) VALUES (20, 300, 400);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT Y.* FROM PAYROLL AS X CROSS JOIN APPLICANT AS Y WHERE X.SSNO = Y.SSNO AND X.DEPTNO = 29;

/*
Gold Result:
(10, 100, 200)
(10, 100, 200)
(20, 300, 400)
*/

-- Prediction Query
SELECT C.* FROM PAYROLL AS A CROSS JOIN (SELECT Y.SSNO, Y.DEPTNO FROM PAYROLL AS Y) AS B CROSS JOIN APPLICANT AS C WHERE A.SSNO = B.SSNO AND C.SSNO = A.SSNO AND B.DEPTNO = 29;

/*
Prediction Result:
(10, 100, 200)
(10, 100, 200)
(10, 100, 200)
(10, 100, 200)
(20, 300, 400)
*/