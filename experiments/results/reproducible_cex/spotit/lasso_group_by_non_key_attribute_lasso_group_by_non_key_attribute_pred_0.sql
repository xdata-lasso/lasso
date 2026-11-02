-- Schema DDL
CREATE TABLE "JOBS" (
    "JOB_ID" TEXT,
    "JOB_TITLE" TEXT,
    PRIMARY KEY ("JOB_ID")
);
CREATE TABLE "EMPLOYEES" (
    "EMPLOYEE_ID" FLOAT,
    "JOB_ID" TEXT,
    "SALARY" FLOAT,
    PRIMARY KEY ("EMPLOYEE_ID"),
    FOREIGN KEY ("JOB_ID") REFERENCES "JOBS"("JOB_ID")
);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO JOBS VALUES (2, -1);
INSERT INTO JOBS VALUES (3, -1);
INSERT INTO EMPLOYEES VALUES (7, 3, -5);
INSERT INTO EMPLOYEES VALUES (15, 2, -1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.job_title, LHS.avg_sal FROM (SELECT job_id, AVG(salary) AS avg_sal FROM employees GROUP BY job_id) AS LHS JOIN jobs AS T2 ON LHS.job_id = T2.job_id ORDER BY T2.job_title, T2.job_id NULLS LAST;

/*
Gold Result:
('-1', -1.0)
('-1', -5.0)
*/

-- Prediction Query
SELECT T2.job_title, AVG(T1.salary) FROM employees AS T1 JOIN jobs AS T2 ON T1.job_id = T2.job_id GROUP BY T2.job_title ORDER BY T2.job_title, AVG(T1.salary) NULLS LAST;

/*
Prediction Result:
('-1', -3.0)
*/