-- Schema DDL
CREATE TABLE "EMP" ("EMPNO" INTEGER NOT NULL PRIMARY KEY, "DEPTNO" INTEGER NOT NULL, "ENAME" TEXT(255) NOT NULL, "JOB" TEXT(255) NOT NULL, "MGR" INTEGER, "HIREDATE" DATE NOT NULL, "SAL" INTEGER NOT NULL, "COMM" INTEGER NOT NULL, "SLACKER" INTEGER NOT NULL, FOREIGN KEY ("DEPTNO") REFERENCES "DEPT" ("DEPTNO"));

CREATE TABLE "DEPT" ("DEPTNO" INTEGER NOT NULL PRIMARY KEY, "NAME" TEXT(255) NOT NULL);

CREATE TABLE "BONUS" ("ENAME" TEXT(255) NOT NULL, "JOB" TEXT(255) NOT NULL, "SAL" INTEGER NOT NULL, "COMM" INTEGER NOT NULL);

CREATE TABLE "EMPNULLABLES" ("EMPNO" INTEGER PRIMARY KEY, "DEPTNO" INTEGER, "ENAME" TEXT(255), "JOB" TEXT(255), "MGR" INTEGER, "HIREDATE" DATE, "SAL" INTEGER, "COMM" INTEGER, "SLACKER" INTEGER, FOREIGN KEY ("DEPTNO") REFERENCES "DEPT" ("DEPTNO"));

CREATE TABLE "EMPNULLABLES_20" ("EMPNO" INTEGER PRIMARY KEY, "DEPTNO" INTEGER, "ENAME" TEXT(255), "JOB" TEXT(255), "MGR" INTEGER, "HIREDATE" DATE, "SAL" INTEGER, "COMM" INTEGER, "SLACKER" INTEGER, FOREIGN KEY ("DEPTNO") REFERENCES "DEPT" ("DEPTNO"));

CREATE TABLE "EMP_B" ("EMPNO" INTEGER NOT NULL PRIMARY KEY, "DEPTNO" INTEGER NOT NULL, "ENAME" TEXT(255) NOT NULL, "JOB" TEXT(255) NOT NULL, "MGR" INTEGER, "HIREDATE" DATE NOT NULL, "SAL" INTEGER NOT NULL, "COMM" INTEGER NOT NULL, "SLACKER" INTEGER NOT NULL, "BIRTHDATE" DATE NOT NULL, FOREIGN KEY ("DEPTNO") REFERENCES "DEPT" ("DEPTNO"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO dept (deptno, name) VALUES (1, 'default1'), (0, 'default2'), (2, 'default2'), (3, 'default1'), (4, 'default2'), (5, 'default1'), (6, 'default2');
INSERT INTO emp (empno, deptno, ename, job, mgr, hiredate, sal, comm, slacker) VALUES (0, 6, 'default2', 'default2', NULL, '2023-01-01', 1, 0, 0), (1, 4, 'default2', 'default1', 0, '2023-01-01', 0, 0, 1), (2, 6, 'default1', 'default1', 1, '2023-01-01', 0, 0, 0), (3, 5, 'default2', 'default2', NULL, '2023-01-02', 1, 0, 0), (4, 0, 'default1', 'default2', NULL, '2023-01-01', 0, 1, 0), (5, 4, 'default1', 'default1', 0, '2023-01-02', 0, 1, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT * FROM EMP INNER JOIN DEPT ON EMP.DEPTNO = DEPT.DEPTNO ORDER BY EMP.SAL, EMP.empno NULLS LAST, DEPT.deptno NULLS LAST;

/*
Gold Result:
(1, 4, 'default2', 'default1', 0, '2023-01-01', 0, 0, 1, 4, 'default2')
(2, 6, 'default1', 'default1', 1, '2023-01-01', 0, 0, 0, 6, 'default2')
(4, 0, 'default1', 'default2', None, '2023-01-01', 0, 1, 0, 0, 'default2')
(5, 4, 'default1', 'default1', 0, '2023-01-02', 0, 1, 1, 4, 'default2')
(0, 6, 'default2', 'default2', None, '2023-01-01', 1, 0, 0, 6, 'default2')
(3, 5, 'default2', 'default2', None, '2023-01-02', 1, 0, 0, 5, 'default1')
*/

-- Prediction Query
SELECT t1.EMPNO, t1.DEPTNO, t1.ENAME, t1.JOB, t1.MGR, t1.HIREDATE, t1.SAL, t1.COMM, t1.SLACKER, DEPT0.DEPTNO AS DEPTNO0, DEPT0.NAME FROM (SELECT EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO, SLACKER FROM EMP ORDER BY SAL, EMP.empno NULLS LAST) AS t1 INNER JOIN DEPT AS DEPT0 ON t1.DEPTNO = DEPT0.DEPTNO ORDER BY t1.SAL, DEPT0.deptno NULLS LAST;

/*
Prediction Result:
(4, 0, 'default1', 'default2', None, '2023-01-01', 0, 1, 0, 0, 'default2')
(1, 4, 'default2', 'default1', 0, '2023-01-01', 0, 0, 1, 4, 'default2')
(5, 4, 'default1', 'default1', 0, '2023-01-02', 0, 1, 1, 4, 'default2')
(2, 6, 'default1', 'default1', 1, '2023-01-01', 0, 0, 0, 6, 'default2')
(3, 5, 'default2', 'default2', None, '2023-01-02', 1, 0, 0, 5, 'default1')
(0, 6, 'default2', 'default2', None, '2023-01-01', 1, 0, 0, 6, 'default2')
*/