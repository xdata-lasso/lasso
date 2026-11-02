-- Schema DDL
CREATE TABLE jobs (job_id TEXT(10) PRIMARY KEY, job_title TEXT(35));

CREATE TABLE employees (employee_id REAL(6, 0) PRIMARY KEY, job_id TEXT(10), salary REAL(8, 2), FOREIGN KEY (job_id) REFERENCES jobs (job_id));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: jobs --
INSERT INTO "jobs" ("job_id", "job_title") VALUES ('t1__27f6d6', 't2__adc116');

INSERT INTO "jobs" ("job_id", "job_title") VALUES ('job_id_2', 't2__adc116');

INSERT INTO "jobs" ("job_id", "job_title") VALUES ('t1__d78952', 'job_0565c1');

INSERT INTO "jobs" ("job_id", "job_title") VALUES ('A', 't2__adc116');

INSERT INTO "jobs" ("job_id", "job_title") VALUES ('@', 'job_0565c1');

INSERT INTO "jobs" ("job_id", "job_title") VALUES ('G', 'job_0565c1');

INSERT INTO "jobs" ("job_id", "job_title") VALUES ('?', 't2__adc116');

INSERT INTO "jobs" ("job_id", "job_title") VALUES ('_', 'job_0565c1');

INSERT INTO "jobs" ("job_id", "job_title") VALUES ('O', 'job_0565c1');

INSERT INTO "jobs" ("job_id", "job_title") VALUES ('t2__08f95c', 'job_0565c1');

-- Inserting into table: employees --
INSERT INTO "employees" ("employee_id", "job_id", "salary") VALUES (1.0, 't1__27f6d6', 0.01);

INSERT INTO "employees" ("employee_id", "job_id", "salary") VALUES (2.0, 't1__27f6d6', 0.02);

INSERT INTO "employees" ("employee_id", "job_id", "salary") VALUES (3.0, 't1__d78952', 0.03);

INSERT INTO "employees" ("employee_id", "job_id", "salary") VALUES (4.0, '@', -1.0);

INSERT INTO "employees" ("employee_id", "job_id", "salary") VALUES (5.0, 'G', 0.0);

INSERT INTO "employees" ("employee_id", "job_id", "salary") VALUES (6.0, '@', 0.0);

INSERT INTO "employees" ("employee_id", "job_id", "salary") VALUES (7.0, 'G', 0.5);

INSERT INTO "employees" ("employee_id", "job_id", "salary") VALUES (8.0, '@', -1.0);

INSERT INTO "employees" ("employee_id", "job_id", "salary") VALUES (9.0, '_', 0.0);

INSERT INTO "employees" ("employee_id", "job_id", "salary") VALUES (10.0, '@', -1.0);

INSERT INTO "employees" ("employee_id", "job_id", "salary") VALUES (11.0, 'O', 0.0);

INSERT INTO "employees" ("employee_id", "job_id", "salary") VALUES (12.0, 't1__27f6d6', NULL);

INSERT INTO "employees" ("employee_id", "job_id", "salary") VALUES (13.0, 't1__d78952', NULL);

INSERT INTO "employees" ("employee_id", "job_id", "salary") VALUES (14.0, 't1__27f6d6', NULL);

INSERT INTO "employees" ("employee_id", "job_id", "salary") VALUES (15.0, 't1__d78952', NULL);

INSERT INTO "employees" ("employee_id", "job_id", "salary") VALUES (16.0, 't1__27f6d6', NULL);

INSERT INTO "employees" ("employee_id", "job_id", "salary") VALUES (17.0, 't1__d78952', NULL);

INSERT INTO "employees" ("employee_id", "job_id", "salary") VALUES (18.0, 't1__27f6d6', NULL);

INSERT INTO "employees" ("employee_id", "job_id", "salary") VALUES (19.0, 't1__d78952', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.job_title, LHS.avg_sal FROM (SELECT job_id, AVG(salary) AS avg_sal FROM employees GROUP BY job_id) AS LHS JOIN jobs AS T2 ON LHS.job_id = T2.job_id ORDER BY T2.job_title, T2.job_id NULLS LAST;

/*
Gold Result:
('job_0565c1', -0.75)
('job_0565c1', 0.25)
('job_0565c1', 0.0)
('job_0565c1', 0.0)
('job_0565c1', 0.03)
('t2__adc116', 0.015)
*/

-- Prediction Query
SELECT T2.job_title, AVG(T1.salary) FROM employees AS T1 JOIN jobs AS T2 ON T1.job_id = T2.job_id GROUP BY T2.job_title ORDER BY T2.job_title, AVG(T1.salary) NULLS LAST;

/*
Prediction Result:
('job_0565c1', -0.27444444444444444)
('t2__adc116', 0.015)
*/