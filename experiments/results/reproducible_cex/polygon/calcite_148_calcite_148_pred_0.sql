-- Schema DDL
CREATE TABLE "EMP" ("EMPNO" INTEGER NOT NULL PRIMARY KEY, "DEPTNO" INTEGER NOT NULL, "ENAME" TEXT(255) NOT NULL, "JOB" TEXT(255) NOT NULL, "MGR" INTEGER, "HIREDATE" DATE NOT NULL, "SAL" INTEGER NOT NULL, "COMM" INTEGER NOT NULL, "SLACKER" INTEGER NOT NULL, FOREIGN KEY ("DEPTNO") REFERENCES "DEPT" ("DEPTNO"));

CREATE TABLE "DEPT" ("DEPTNO" INTEGER NOT NULL PRIMARY KEY, "NAME" TEXT(255) NOT NULL);

CREATE TABLE "BONUS" ("ENAME" TEXT(255) NOT NULL, "JOB" TEXT(255) NOT NULL, "SAL" INTEGER NOT NULL, "COMM" INTEGER NOT NULL);

CREATE TABLE "EMPNULLABLES" ("EMPNO" INTEGER PRIMARY KEY, "DEPTNO" INTEGER, "ENAME" TEXT(255), "JOB" TEXT(255), "MGR" INTEGER, "HIREDATE" DATE, "SAL" INTEGER, "COMM" INTEGER, "SLACKER" INTEGER, FOREIGN KEY ("DEPTNO") REFERENCES "DEPT" ("DEPTNO"));

CREATE TABLE "EMPNULLABLES_20" ("EMPNO" INTEGER PRIMARY KEY, "DEPTNO" INTEGER, "ENAME" TEXT(255), "JOB" TEXT(255), "MGR" INTEGER, "HIREDATE" DATE, "SAL" INTEGER, "COMM" INTEGER, "SLACKER" INTEGER, FOREIGN KEY ("DEPTNO") REFERENCES "DEPT" ("DEPTNO"));

CREATE TABLE "EMP_B" ("EMPNO" INTEGER NOT NULL PRIMARY KEY, "DEPTNO" INTEGER NOT NULL, "ENAME" TEXT(255) NOT NULL, "JOB" TEXT(255) NOT NULL, "MGR" INTEGER, "HIREDATE" DATE NOT NULL, "SAL" INTEGER NOT NULL, "COMM" INTEGER NOT NULL, "SLACKER" INTEGER NOT NULL, "BIRTHDATE" DATE NOT NULL, FOREIGN KEY ("DEPTNO") REFERENCES "DEPT" ("DEPTNO"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "EMP" ("empno", "deptno", "ename", "job", "mgr", "hiredate", "sal", "comm", "slacker") VALUES (13, 14, '22', '32', NULL, '1000-01-25', 25, 26, 27);
INSERT INTO "EMP" ("empno", "deptno", "ename", "job", "mgr", "hiredate", "sal", "comm", "slacker") VALUES (12, 14, '14', '29', 14, '1000-01-15', 14, 14, 14);
INSERT INTO "DEPT" ("deptno", "name") VALUES (15, '32');
INSERT INTO "DEPT" ("deptno", "name") VALUES (14, '28');
INSERT INTO "BONUS" ("ename", "job", "sal", "comm") VALUES ('14', '14', 14, 14);
INSERT INTO "BONUS" ("ename", "job", "sal", "comm") VALUES ('14', '14', 14, 14);
INSERT INTO "EMPNULLABLES" ("empno", "deptno", "ename", "job", "mgr", "hiredate", "sal", "comm", "slacker") VALUES (17, 14, '14', '14', 14, '1000-01-15', 14, 14, 14);
INSERT INTO "EMPNULLABLES" ("empno", "deptno", "ename", "job", "mgr", "hiredate", "sal", "comm", "slacker") VALUES (16, 14, '14', '14', 14, '1000-01-15', 14, 14, 14);
INSERT INTO "EMPNULLABLES_20" ("empno", "deptno", "ename", "job", "mgr", "hiredate", "sal", "comm", "slacker") VALUES (19, 14, '14', '14', 14, '1000-01-15', 14, 14, 14);
INSERT INTO "EMPNULLABLES_20" ("empno", "deptno", "ename", "job", "mgr", "hiredate", "sal", "comm", "slacker") VALUES (18, 14, '14', '14', 14, '1000-01-15', 14, 14, 14);
INSERT INTO "EMP_B" ("empno", "deptno", "ename", "job", "mgr", "hiredate", "sal", "comm", "slacker", "birthdate") VALUES (21, 14, '14', '14', 14, '1000-01-15', 14, 14, 14, '1000-01-15');
INSERT INTO "EMP_B" ("empno", "deptno", "ename", "job", "mgr", "hiredate", "sal", "comm", "slacker", "birthdate") VALUES (20, 14, '14', '14', 14, '1000-01-15', 14, 14, 14, '1000-01-15');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(*) FROM EMP INNER JOIN DEPT ON EMP.JOB = DEPT.NAME;

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT COALESCE(SUM(t1.EXPR$0 * t2.EXPR$0), 0) FROM (SELECT JOB, COUNT(*) AS EXPR$0 FROM EMP GROUP BY JOB) AS t1 INNER JOIN (SELECT NAME, COUNT(*) AS EXPR$0 FROM DEPT GROUP BY NAME) AS t2 ON t1.JOB = t2.NAME;

/*
Prediction Result:
(1,)
*/