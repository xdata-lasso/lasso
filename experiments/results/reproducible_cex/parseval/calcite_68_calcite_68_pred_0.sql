-- Schema DDL
CREATE TABLE "EMP" ("EMPNO" INTEGER NOT NULL PRIMARY KEY, "DEPTNO" INTEGER NOT NULL, "ENAME" TEXT(255) NOT NULL, "JOB" TEXT(255) NOT NULL, "MGR" INTEGER, "HIREDATE" DATE NOT NULL, "SAL" INTEGER NOT NULL, "COMM" INTEGER NOT NULL, "SLACKER" INTEGER NOT NULL, FOREIGN KEY ("DEPTNO") REFERENCES "DEPT" ("DEPTNO"));

CREATE TABLE "DEPT" ("DEPTNO" INTEGER NOT NULL PRIMARY KEY, "NAME" TEXT(255) NOT NULL);

CREATE TABLE "BONUS" ("ENAME" TEXT(255) NOT NULL, "JOB" TEXT(255) NOT NULL, "SAL" INTEGER NOT NULL, "COMM" INTEGER NOT NULL);

CREATE TABLE "EMPNULLABLES" ("EMPNO" INTEGER PRIMARY KEY, "DEPTNO" INTEGER, "ENAME" TEXT(255), "JOB" TEXT(255), "MGR" INTEGER, "HIREDATE" DATE, "SAL" INTEGER, "COMM" INTEGER, "SLACKER" INTEGER, FOREIGN KEY ("DEPTNO") REFERENCES "DEPT" ("DEPTNO"));

CREATE TABLE "EMPNULLABLES_20" ("EMPNO" INTEGER PRIMARY KEY, "DEPTNO" INTEGER, "ENAME" TEXT(255), "JOB" TEXT(255), "MGR" INTEGER, "HIREDATE" DATE, "SAL" INTEGER, "COMM" INTEGER, "SLACKER" INTEGER, FOREIGN KEY ("DEPTNO") REFERENCES "DEPT" ("DEPTNO"));

CREATE TABLE "EMP_B" ("EMPNO" INTEGER NOT NULL PRIMARY KEY, "DEPTNO" INTEGER NOT NULL, "ENAME" TEXT(255) NOT NULL, "JOB" TEXT(255) NOT NULL, "MGR" INTEGER, "HIREDATE" DATE NOT NULL, "SAL" INTEGER NOT NULL, "COMM" INTEGER NOT NULL, "SLACKER" INTEGER NOT NULL, "BIRTHDATE" DATE NOT NULL, FOREIGN KEY ("DEPTNO") REFERENCES "DEPT" ("DEPTNO"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: dept --
INSERT INTO "dept" ("deptno", "name") VALUES (1, 'dep_1dfceb');

INSERT INTO "dept" ("deptno", "name") VALUES (2, 'dep_1dfceb');

INSERT INTO "dept" ("deptno", "name") VALUES (3, 'dep_1dfceb');

INSERT INTO "dept" ("deptno", "name") VALUES (4, 'dep_1dfceb');

INSERT INTO "dept" ("deptno", "name") VALUES (5, 'dep_1dfceb');

INSERT INTO "dept" ("deptno", "name") VALUES (6, 'dep_1dfceb');

INSERT INTO "dept" ("deptno", "name") VALUES (7, 'dep_1dfceb');

INSERT INTO "dept" ("deptno", "name") VALUES (8, 'dep_1dfceb');

INSERT INTO "dept" ("deptno", "name") VALUES (9, 'dep_1dfceb');

INSERT INTO "dept" ("deptno", "name") VALUES (10, 'dep_1dfceb');

-- Inserting into table: emp --
INSERT INTO "emp" ("empno", "deptno", "ename", "job", "mgr", "hiredate", "sal", "comm", "slacker") VALUES (1, 1, 'emp_2f8e66', 'emp_88f72d', 1, '2024-06-15', 2, 1, 1);

INSERT INTO "emp" ("empno", "deptno", "ename", "job", "mgr", "hiredate", "sal", "comm", "slacker") VALUES (2, 2, 'emp_244aa2', 'emp_3ec8a4', -1437333179, '2023-03-15', 4, -664303813, -1022641847);

INSERT INTO "emp" ("empno", "deptno", "ename", "job", "mgr", "hiredate", "sal", "comm", "slacker") VALUES (3, 1, 'emp_244aa2', 'emp_3ec8a4', -890215420, '2022-04-27', -1980249628, -734455130, 1744686505);

INSERT INTO "emp" ("empno", "deptno", "ename", "job", "mgr", "hiredate", "sal", "comm", "slacker") VALUES (4, 4, 'emp_244aa2', 'emp_3ec8a4', 1160656988, '2023-01-06', -252690330, 1115440883, 1644814318);

INSERT INTO "emp" ("empno", "deptno", "ename", "job", "mgr", "hiredate", "sal", "comm", "slacker") VALUES (5, 1, 'emp_244aa2', 'emp_3ec8a4', -1349201381, '2021-04-10', -1910425938, -845863578, -1610064545);

INSERT INTO "emp" ("empno", "deptno", "ename", "job", "mgr", "hiredate", "sal", "comm", "slacker") VALUES (6, 1, 'emp_244aa2', 'emp_3ec8a4', -1257178728, '2023-01-01', 2087640001, 907682809, 2026480202);

INSERT INTO "emp" ("empno", "deptno", "ename", "job", "mgr", "hiredate", "sal", "comm", "slacker") VALUES (7, 2, 'emp_244aa2', 'emp_3ec8a4', -1602639011, '2025-06-27', -1209887326, -1399556171, 1038707349);

INSERT INTO "emp" ("empno", "deptno", "ename", "job", "mgr", "hiredate", "sal", "comm", "slacker") VALUES (8, 7, 'emp_244aa2', 'emp_3ec8a4', 546571701, '2024-09-18', 1990080517, 1408123494, -1964997180);

INSERT INTO "emp" ("empno", "deptno", "ename", "job", "mgr", "hiredate", "sal", "comm", "slacker") VALUES (9, 2, 'emp_244aa2', 'emp_3ec8a4', -1833165707, '2025-10-19', -1585009206, -53231346, -443340271);

INSERT INTO "emp" ("empno", "deptno", "ename", "job", "mgr", "hiredate", "sal", "comm", "slacker") VALUES (10, 6, 'emp_244aa2', 'emp_3ec8a4', -1179823637, '2022-04-13', 781505063, 418417917, -1031969798);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT * FROM EMP WHERE SAL = 4 OR NOT EMPNO IN (SELECT DEPTNO FROM DEPT);

/*
Gold Result:
(2, 2, 'emp_244aa2', 'emp_3ec8a4', -1437333179, '2023-03-15', 4, -664303813, -1022641847)
*/

-- Prediction Query
SELECT EMP0.EMPNO, EMP0.ENAME, EMP0.JOB, EMP0.MGR, EMP0.HIREDATE, EMP0.SAL, EMP0.COMM, EMP0.DEPTNO, EMP0.SLACKER FROM EMP AS EMP0 LEFT JOIN (SELECT DEPTNO, TRUE AS i FROM DEPT) AS t2 ON EMP0.EMPNO = t2.DEPTNO WHERE EMP0.SAL = 4 OR t2.i IS NULL;

/*
Prediction Result:
(2, 'emp_244aa2', 'emp_3ec8a4', -1437333179, '2023-03-15', 4, -664303813, 2, -1022641847)
*/