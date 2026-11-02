-- Schema DDL
CREATE TABLE "EMP" ("EMPNO" INTEGER NOT NULL PRIMARY KEY, "DEPTNO" INTEGER NOT NULL, "ENAME" TEXT(255) NOT NULL, "JOB" TEXT(255) NOT NULL, "MGR" INTEGER, "HIREDATE" DATE NOT NULL, "SAL" INTEGER NOT NULL, "COMM" INTEGER NOT NULL, "SLACKER" INTEGER NOT NULL, FOREIGN KEY ("DEPTNO") REFERENCES "DEPT" ("DEPTNO"));

CREATE TABLE "DEPT" ("DEPTNO" INTEGER NOT NULL PRIMARY KEY, "NAME" TEXT(255) NOT NULL);

CREATE TABLE "BONUS" ("ENAME" TEXT(255) NOT NULL, "JOB" TEXT(255) NOT NULL, "SAL" INTEGER NOT NULL, "COMM" INTEGER NOT NULL);

CREATE TABLE "EMPNULLABLES" ("EMPNO" INTEGER PRIMARY KEY, "DEPTNO" INTEGER, "ENAME" TEXT(255), "JOB" TEXT(255), "MGR" INTEGER, "HIREDATE" DATE, "SAL" INTEGER, "COMM" INTEGER, "SLACKER" INTEGER, FOREIGN KEY ("DEPTNO") REFERENCES "DEPT" ("DEPTNO"));

CREATE TABLE "EMPNULLABLES_20" ("EMPNO" INTEGER PRIMARY KEY, "DEPTNO" INTEGER, "ENAME" TEXT(255), "JOB" TEXT(255), "MGR" INTEGER, "HIREDATE" DATE, "SAL" INTEGER, "COMM" INTEGER, "SLACKER" INTEGER, FOREIGN KEY ("DEPTNO") REFERENCES "DEPT" ("DEPTNO"));

CREATE TABLE "EMP_B" ("EMPNO" INTEGER NOT NULL PRIMARY KEY, "DEPTNO" INTEGER NOT NULL, "ENAME" TEXT(255) NOT NULL, "JOB" TEXT(255) NOT NULL, "MGR" INTEGER, "HIREDATE" DATE NOT NULL, "SAL" INTEGER NOT NULL, "COMM" INTEGER NOT NULL, "SLACKER" INTEGER NOT NULL, "BIRTHDATE" DATE NOT NULL, FOREIGN KEY ("DEPTNO") REFERENCES "DEPT" ("DEPTNO"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "EMP" ("empno", "deptno", "ename", "job", "mgr", "hiredate", "sal", "comm", "slacker") VALUES (11, 13, '13', '13', 13, '1000-01-14', 13, 21, 13);
INSERT INTO "EMP" ("empno", "deptno", "ename", "job", "mgr", "hiredate", "sal", "comm", "slacker") VALUES (10, 12, '13', '13', 13, '1000-01-14', 13, 21, 13);
INSERT INTO "DEPT" ("deptno", "name") VALUES (12, '13');
INSERT INTO "DEPT" ("deptno", "name") VALUES (13, '13');
INSERT INTO "BONUS" ("ename", "job", "sal", "comm") VALUES ('13', '13', 13, 13);
INSERT INTO "BONUS" ("ename", "job", "sal", "comm") VALUES ('13', '13', 13, 13);
INSERT INTO "EMPNULLABLES" ("empno", "deptno", "ename", "job", "mgr", "hiredate", "sal", "comm", "slacker") VALUES (14, 13, '13', '13', 13, '1000-01-14', 13, 13, 13);
INSERT INTO "EMPNULLABLES_20" ("empno", "deptno", "ename", "job", "mgr", "hiredate", "sal", "comm", "slacker") VALUES (17, 12, '13', '13', 13, '1000-01-14', 13, 13, 13);
INSERT INTO "EMPNULLABLES_20" ("empno", "deptno", "ename", "job", "mgr", "hiredate", "sal", "comm", "slacker") VALUES (16, 13, '13', '13', 13, '1000-01-14', 13, 13, 13);
INSERT INTO "EMP_B" ("empno", "deptno", "ename", "job", "mgr", "hiredate", "sal", "comm", "slacker", "birthdate") VALUES (19, 13, '13', '13', 13, '1000-01-14', 13, 13, 13, '1000-01-14');
INSERT INTO "EMP_B" ("empno", "deptno", "ename", "job", "mgr", "hiredate", "sal", "comm", "slacker", "birthdate") VALUES (18, 13, '13', '13', 13, '1000-01-14', 13, 13, 13, '1000-01-14');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(*), COUNT(DISTINCT COMM) FROM EMP;

/*
Gold Result:
(2, 1)
*/

-- Prediction Query
SELECT CAST(COALESCE(SUM(EXPR$0), 0) AS INTEGER), COUNT(COMM) FROM (SELECT COMM, COUNT(*) AS EXPR$0 FROM EMP GROUP BY COMM) AS t2;

/*
Prediction Result:
(2, 1)
*/