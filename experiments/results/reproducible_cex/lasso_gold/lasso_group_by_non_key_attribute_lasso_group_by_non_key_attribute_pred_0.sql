-- Schema DDL
CREATE TABLE jobs (job_id TEXT(10) PRIMARY KEY, job_title TEXT(35));

CREATE TABLE employees (employee_id REAL(6, 0) PRIMARY KEY, job_id TEXT(10), salary REAL(8, 2), FOREIGN KEY (job_id) REFERENCES jobs (job_id));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "jobs" ("job_id", "job_title") VALUES ('Air traffic controller', 'Chief Financial Officer');
INSERT INTO "jobs" ("job_id", "job_title") VALUES ('Engineering geologist', 'Chief Financial Officer');
INSERT INTO "employees" ("employee_id", "job_id", "salary") VALUES (1021.5, 'Air traffic controller', 1022.5);
INSERT INTO "employees" ("employee_id", "job_id", "salary") VALUES (1023.5, 'Engineering geologist', 1022.5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.job_title, LHS.avg_sal FROM (SELECT job_id, AVG(salary) AS avg_sal FROM employees GROUP BY job_id) AS LHS JOIN jobs AS T2 ON LHS.job_id = T2.job_id ORDER BY T2.job_title, T2.job_id NULLS LAST;

/*
Gold Result:
('Chief Financial Officer', 1022.5)
('Chief Financial Officer', 1022.5)
*/

-- Prediction Query
SELECT T2.job_title, AVG(T1.salary) FROM employees AS T1 JOIN jobs AS T2 ON T1.job_id = T2.job_id GROUP BY T2.job_title ORDER BY T2.job_title, AVG(T1.salary) NULLS LAST;

/*
Prediction Result:
('Chief Financial Officer', 1022.5)
*/