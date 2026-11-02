-- Schema DDL
CREATE TABLE "payroll" ("ssno" INTEGER, "deptno" INTEGER);

CREATE TABLE "applicant" ("ssno" INTEGER, "jobtitile" INTEGER, "officeno" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "applicant" ("ssno", "jobtitile", "officeno") VALUES (0, 1012, 1013);
INSERT INTO "applicant" ("ssno", "jobtitile", "officeno") VALUES (0, 1014, 1015);
INSERT INTO "payroll" ("ssno", "deptno") VALUES (0, 29);
INSERT INTO "payroll" ("ssno", "deptno") VALUES (0, -29);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT Y.* FROM PAYROLL AS X CROSS JOIN APPLICANT AS Y WHERE X.SSNO = Y.SSNO AND X.DEPTNO = 29;

/*
Gold Result:
(0, 1012, 1013)
(0, 1014, 1015)
*/

-- Prediction Query
SELECT C.* FROM PAYROLL AS A CROSS JOIN (SELECT Y.SSNO, Y.DEPTNO FROM PAYROLL AS Y) AS B CROSS JOIN APPLICANT AS C WHERE A.SSNO = B.SSNO AND C.SSNO = A.SSNO AND B.DEPTNO = 29;

/*
Prediction Result:
(0, 1012, 1013)
(0, 1014, 1015)
(0, 1012, 1013)
(0, 1014, 1015)
*/