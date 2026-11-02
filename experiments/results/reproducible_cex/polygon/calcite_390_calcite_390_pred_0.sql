-- Schema DDL
CREATE TABLE "EMP" ("EMPNO" INTEGER NOT NULL PRIMARY KEY, "DEPTNO" INTEGER NOT NULL, "ENAME" TEXT(255) NOT NULL, "JOB" TEXT(255) NOT NULL, "MGR" INTEGER, "HIREDATE" DATE NOT NULL, "SAL" INTEGER NOT NULL, "COMM" INTEGER NOT NULL, "SLACKER" INTEGER NOT NULL, FOREIGN KEY ("DEPTNO") REFERENCES "DEPT" ("DEPTNO"));

CREATE TABLE "DEPT" ("DEPTNO" INTEGER NOT NULL PRIMARY KEY, "NAME" TEXT(255) NOT NULL);

CREATE TABLE "BONUS" ("ENAME" TEXT(255) NOT NULL, "JOB" TEXT(255) NOT NULL, "SAL" INTEGER NOT NULL, "COMM" INTEGER NOT NULL);

CREATE TABLE "EMPNULLABLES" ("EMPNO" INTEGER PRIMARY KEY, "DEPTNO" INTEGER, "ENAME" TEXT(255), "JOB" TEXT(255), "MGR" INTEGER, "HIREDATE" DATE, "SAL" INTEGER, "COMM" INTEGER, "SLACKER" INTEGER, FOREIGN KEY ("DEPTNO") REFERENCES "DEPT" ("DEPTNO"));

CREATE TABLE "EMPNULLABLES_20" ("EMPNO" INTEGER PRIMARY KEY, "DEPTNO" INTEGER, "ENAME" TEXT(255), "JOB" TEXT(255), "MGR" INTEGER, "HIREDATE" DATE, "SAL" INTEGER, "COMM" INTEGER, "SLACKER" INTEGER, FOREIGN KEY ("DEPTNO") REFERENCES "DEPT" ("DEPTNO"));

CREATE TABLE "EMP_B" ("EMPNO" INTEGER NOT NULL PRIMARY KEY, "DEPTNO" INTEGER NOT NULL, "ENAME" TEXT(255) NOT NULL, "JOB" TEXT(255) NOT NULL, "MGR" INTEGER, "HIREDATE" DATE NOT NULL, "SAL" INTEGER NOT NULL, "COMM" INTEGER NOT NULL, "SLACKER" INTEGER NOT NULL, "BIRTHDATE" DATE NOT NULL, FOREIGN KEY ("DEPTNO") REFERENCES "DEPT" ("DEPTNO"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "EMP" ("empno", "deptno", "ename", "job", "mgr", "hiredate", "sal", "comm", "slacker") VALUES (14, 16, '25', '16', 16, '1000-01-17', 16, 16, 16);
INSERT INTO "EMP" ("empno", "deptno", "ename", "job", "mgr", "hiredate", "sal", "comm", "slacker") VALUES (13, 16, '26', '16', 16, '1000-01-17', 16, 16, 16);
INSERT INTO "DEPT" ("deptno", "name") VALUES (15, '23');
INSERT INTO "DEPT" ("deptno", "name") VALUES (16, '24');
INSERT INTO "BONUS" ("ename", "job", "sal", "comm") VALUES ('16', '16', 16, 16);
INSERT INTO "BONUS" ("ename", "job", "sal", "comm") VALUES ('16', '16', 16, 16);
INSERT INTO "EMPNULLABLES" ("empno", "deptno", "ename", "job", "mgr", "hiredate", "sal", "comm", "slacker") VALUES (18, 16, '16', '16', 16, '1000-01-17', 16, 16, 16);
INSERT INTO "EMPNULLABLES" ("empno", "deptno", "ename", "job", "mgr", "hiredate", "sal", "comm", "slacker") VALUES (17, 16, '16', '16', 16, '1000-01-17', 16, 16, 16);
INSERT INTO "EMPNULLABLES_20" ("empno", "deptno", "ename", "job", "mgr", "hiredate", "sal", "comm", "slacker") VALUES (20, 16, '16', '16', 16, '1000-01-17', 16, 16, 16);
INSERT INTO "EMPNULLABLES_20" ("empno", "deptno", "ename", "job", "mgr", "hiredate", "sal", "comm", "slacker") VALUES (19, 16, '16', '16', 16, '1000-01-17', 16, 16, 16);
INSERT INTO "EMP_B" ("empno", "deptno", "ename", "job", "mgr", "hiredate", "sal", "comm", "slacker", "birthdate") VALUES (22, 16, '16', '16', 16, '1000-01-17', 16, 16, 16, '1000-01-17');
INSERT INTO "EMP_B" ("empno", "deptno", "ename", "job", "mgr", "hiredate", "sal", "comm", "slacker", "birthdate") VALUES (21, 16, '16', '16', 16, '1000-01-17', 16, 16, 16, '1000-01-17');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT * FROM EMP WHERE ENAME IN (SELECT NAME FROM DEPT);

/*
Gold Result:
*/

-- Prediction Query
SELECT EMP0.EMPNO, EMP0.DEPTNO, EMP0.ENAME, EMP0.JOB, EMP0.MGR, EMP0.HIREDATE, EMP0.SAL, EMP0.COMM, EMP0.SLACKER FROM EMP AS EMP0 INNER JOIN (SELECT NAME FROM DEPT GROUP BY NAME) AS t3 ON EMP0.ENAME = t3.NAME;

/*
Prediction Result:
*/