-- Schema DDL
CREATE TABLE jobs (job_id TEXT(10) PRIMARY KEY, job_title TEXT(35));

CREATE TABLE employees (employee_id REAL(6, 0) PRIMARY KEY, job_id TEXT(10), salary REAL(8, 2), FOREIGN KEY (job_id) REFERENCES jobs (job_id));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO jobs (job_id, job_title) VALUES ('J_A', 'Analyst');
INSERT INTO jobs (job_id, job_title) VALUES ('J_Z', 'Analyst');
INSERT INTO jobs (job_id, job_title) VALUES ('J_M', 'Developer');
INSERT INTO jobs (job_id, job_title) VALUES ('J_EMPTY', 'Intern');
INSERT INTO employees (employee_id, job_id, salary) VALUES (1, 'J_Z', 4000.00);
INSERT INTO employees (employee_id, job_id, salary) VALUES (2, 'J_Z', 6000.00);
INSERT INTO employees (employee_id, job_id, salary) VALUES (3, 'J_A', 4000.00);
INSERT INTO employees (employee_id, job_id, salary) VALUES (4, 'J_A', 6000.00);
INSERT INTO employees (employee_id, job_id, salary) VALUES (5, 'J_A', 8000.00);
INSERT INTO employees (employee_id, job_id, salary) VALUES (6, 'J_M', 7000.00);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.job_title, LHS.avg_sal FROM (SELECT job_id, AVG(salary) AS avg_sal FROM employees GROUP BY job_id) AS LHS JOIN jobs AS T2 ON LHS.job_id = T2.job_id ORDER BY T2.job_title, T2.job_id NULLS LAST;

/*
Gold Result:
('Analyst', 6000.0)
('Analyst', 5000.0)
('Developer', 7000.0)
*/

-- Prediction Query
SELECT T2.job_title, AVG(T1.salary) FROM employees AS T1 JOIN jobs AS T2 ON T1.job_id = T2.job_id GROUP BY T2.job_title ORDER BY T2.job_title, AVG(T1.salary) NULLS LAST;

/*
Prediction Result:
('Analyst', 5600.0)
('Developer', 7000.0)
*/