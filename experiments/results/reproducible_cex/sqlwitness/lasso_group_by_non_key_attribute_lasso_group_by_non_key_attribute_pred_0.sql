-- Schema DDL
CREATE TABLE jobs (job_id TEXT(10) PRIMARY KEY, job_title TEXT(35));

CREATE TABLE employees (employee_id REAL(6, 0) PRIMARY KEY, job_id TEXT(10), salary REAL(8, 2), FOREIGN KEY (job_id) REFERENCES jobs (job_id));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO jobs (job_id, job_title) VALUES ('default2', 'default1'), ('default1', NULL), ('unique_2', 'default1'), ('unique_3', 'default2'), ('unique_4', NULL), ('unique_5', 'default1');
INSERT INTO employees (employee_id, job_id, salary) VALUES (1.0, 'unique_2', 0.0), (0.0, 'default2', NULL), (16666.666667, 'default1', NULL), (33333.333333, NULL, 1.0), (50000.0, 'default2', 1.0), (66666.666667, 'unique_4', NULL), (83333.333333, 'default2', 1.0), (100000.0, 'unique_3', 0.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.job_title, LHS.avg_sal FROM (SELECT job_id, AVG(salary) AS avg_sal FROM employees GROUP BY job_id) AS LHS JOIN jobs AS T2 ON LHS.job_id = T2.job_id ORDER BY T2.job_title, T2.job_id NULLS LAST;

/*
Gold Result:
(None, None)
(None, None)
('default1', 1.0)
('default1', 0.0)
('default2', 0.0)
*/

-- Prediction Query
SELECT T2.job_title, AVG(T1.salary) FROM employees AS T1 JOIN jobs AS T2 ON T1.job_id = T2.job_id GROUP BY T2.job_title ORDER BY T2.job_title, AVG(T1.salary) NULLS LAST;

/*
Prediction Result:
(None, None)
('default1', 0.6666666666666666)
('default2', 0.0)
*/