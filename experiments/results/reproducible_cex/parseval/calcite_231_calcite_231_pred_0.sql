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
INSERT INTO "dept" ("deptno", "name") VALUES (-2147483648, 'dep_1dfceb');

-- Inserting into table: emp --
INSERT INTO "emp" ("empno", "deptno", "ename", "job", "mgr", "hiredate", "sal", "comm", "slacker") VALUES (2, -2147483648, 'emp_244aa2', 'emp_3ec8a4', -55602865, '2025-06-13', 1, -921145356, 1258409369);

INSERT INTO "emp" ("empno", "deptno", "ename", "job", "mgr", "hiredate", "sal", "comm", "slacker") VALUES (3, -2147483648, 'emp_244aa2', 'emp_3ec8a4', -1726781632, '2021-12-04', 1, 1610062532, -106629402);

INSERT INTO "emp" ("empno", "deptno", "ename", "job", "mgr", "hiredate", "sal", "comm", "slacker") VALUES (4, -2147483648, 'emp_244aa2', 'emp_3ec8a4', 809183447, '2025-11-03', -734455130, 1744686505, -1633151678);

INSERT INTO "emp" ("empno", "deptno", "ename", "job", "mgr", "hiredate", "sal", "comm", "slacker") VALUES (5, -2147483648, 'emp_244aa2', 'emp_3ec8a4', 1914020640, '2024-12-12', 1219478689, -1670923962, 700293388);

INSERT INTO "emp" ("empno", "deptno", "ename", "job", "mgr", "hiredate", "sal", "comm", "slacker") VALUES (6, -2147483648, 'emp_244aa2', 'emp_3ec8a4', 1908028688, '2020-03-30', 1072996612, 13244799, -1659388584);

INSERT INTO "emp" ("empno", "deptno", "ename", "job", "mgr", "hiredate", "sal", "comm", "slacker") VALUES (7, -2147483648, 'emp_244aa2', 'emp_3ec8a4', -1377057208, '2023-05-30', -1610064545, 429706943, 462974032);

INSERT INTO "emp" ("empno", "deptno", "ename", "job", "mgr", "hiredate", "sal", "comm", "slacker") VALUES (8, -2147483648, 'emp_244aa2', 'emp_3ec8a4', 2026480202, '2021-06-28', -1602639011, -45536098, 1861536320);

INSERT INTO "emp" ("empno", "deptno", "ename", "job", "mgr", "hiredate", "sal", "comm", "slacker") VALUES (9, -2147483648, 'emp_244aa2', 'emp_3ec8a4', -1399556171, '2020-01-23', 1419861592, 700088193, 374105386);

INSERT INTO "emp" ("empno", "deptno", "ename", "job", "mgr", "hiredate", "sal", "comm", "slacker") VALUES (10, -2147483648, 'emp_244aa2', 'emp_3ec8a4', -1683203397, '2020-10-26', -1585009206, -53231346, -443340271);

INSERT INTO "emp" ("empno", "deptno", "ename", "job", "mgr", "hiredate", "sal", "comm", "slacker") VALUES (11, -2147483648, 'emp_244aa2', 'emp_3ec8a4', -1179823637, '2022-04-13', 781505063, 418417917, -1031969798);

INSERT INTO "emp" ("empno", "deptno", "ename", "job", "mgr", "hiredate", "sal", "comm", "slacker") VALUES (12, -2147483648, 'emp_244aa2', 'emp_3ec8a4', -921187550, '2020-03-14', 2107872094, 882961052, 743312762);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT AVG(SAL), AVG(SAL) FROM EMP;

/*
Gold Result:
(97231469.0909091, 97231469.0909091)
*/

-- Prediction Query
SELECT AVG(SAL), CAST(CAST(CASE WHEN COUNT(*) = 0 THEN NULL ELSE COALESCE(SUM(SAL), 0) END AS REAL) / COUNT(*) AS INTEGER) FROM EMP;

/*
Prediction Result:
(97231469.0909091, 97231469)
*/