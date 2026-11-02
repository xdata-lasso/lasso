-- Schema DDL
CREATE TABLE jobs (job_id TEXT(10) PRIMARY KEY, job_title TEXT(35));

CREATE TABLE employees (employee_id REAL(6, 0) PRIMARY KEY, job_id TEXT(10), salary REAL(8, 2), FOREIGN KEY (job_id) REFERENCES jobs (job_id));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
-- Tests GROUP BY job_id vs GROUP BY job_title when multiple job_ids share the exact same job_title.
-- Also tests secondary sorting on T2.job_id (ASC vs DESC) and duplicate output rows (SELECT vs SELECT DISTINCT).
INSERT INTO jobs (job_id, job_title) VALUES ('J_B', 'Engineer');
INSERT INTO jobs (job_id, job_title) VALUES ('J_A', 'Engineer');
INSERT INTO jobs (job_id, job_title) VALUES ('J_C', 'Engineer');
INSERT INTO employees (employee_id, job_id, salary) VALUES (1, 'J_B', 1000.00);
INSERT INTO employees (employee_id, job_id, salary) VALUES (2, 'J_B', 2000.00);
INSERT INTO employees (employee_id, job_id, salary) VALUES (3, 'J_A', 4000.00);
INSERT INTO employees (employee_id, job_id, salary) VALUES (4, 'J_C', 1500.00);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.job_title, LHS.avg_sal FROM (SELECT job_id, AVG(salary) AS avg_sal FROM employees GROUP BY job_id) AS LHS JOIN jobs AS T2 ON LHS.job_id = T2.job_id ORDER BY T2.job_title, T2.job_id NULLS LAST;

/*
Gold Result:
('Engineer', 4000.0)
('Engineer', 1500.0)
('Engineer', 1500.0)
*/

-- Prediction Query
SELECT T2.job_title, AVG(T1.salary) FROM employees AS T1 JOIN jobs AS T2 ON T1.job_id = T2.job_id GROUP BY T2.job_title ORDER BY T2.job_title, AVG(T1.salary) NULLS LAST;

/*
Prediction Result:
('Engineer', 2125.0)
*/