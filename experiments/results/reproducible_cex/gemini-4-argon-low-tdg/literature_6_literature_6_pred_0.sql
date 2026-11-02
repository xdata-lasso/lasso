-- Schema DDL
CREATE TABLE "payroll" ("ssno" INTEGER, "deptno" INTEGER);

CREATE TABLE "applicant" ("ssno" INTEGER, "jobtitile" INTEGER, "officeno" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO payroll (ssno, deptno) VALUES (201, 29);
INSERT INTO payroll (ssno, deptno) VALUES (201, 29);
INSERT INTO payroll (ssno, deptno) VALUES (202, 29);
INSERT INTO applicant (ssno, jobtitile, officeno) VALUES (201, 5, 50);
INSERT INTO applicant (ssno, jobtitile, officeno) VALUES (202, 6, 60);
INSERT INTO applicant (ssno, jobtitile, officeno) VALUES (202, 6, 60);
INSERT INTO applicant (ssno, jobtitile, officeno) VALUES (202, 7, 70);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT Y.* FROM PAYROLL AS X CROSS JOIN APPLICANT AS Y WHERE X.SSNO = Y.SSNO AND X.DEPTNO = 29;

/*
Gold Result:
(201, 5, 50)
(201, 5, 50)
(202, 6, 60)
(202, 6, 60)
(202, 7, 70)
*/

-- Prediction Query
SELECT C.* FROM PAYROLL AS A CROSS JOIN (SELECT Y.SSNO, Y.DEPTNO FROM PAYROLL AS Y) AS B CROSS JOIN APPLICANT AS C WHERE A.SSNO = B.SSNO AND C.SSNO = A.SSNO AND B.DEPTNO = 29;

/*
Prediction Result:
(201, 5, 50)
(201, 5, 50)
(201, 5, 50)
(201, 5, 50)
(202, 6, 60)
(202, 6, 60)
(202, 7, 70)
*/