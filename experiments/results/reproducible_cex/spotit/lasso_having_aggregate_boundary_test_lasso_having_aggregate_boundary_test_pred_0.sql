-- Schema DDL
CREATE TABLE "EMPLOYEES" (
    "EMP_ID" INT,
    "DEPT_ID" INT,
    "SALARY" INT,
    PRIMARY KEY ("EMP_ID")
);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO EMPLOYEES VALUES (0, 0, 31);
INSERT INTO EMPLOYEES VALUES (1, 0, 69);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT dept_id, SUM(salary) FROM employees GROUP BY dept_id HAVING SUM(salary) > 100 AND MAX(salary) < 70;

/*
Gold Result:
*/

-- Prediction Query
SELECT dept_id, SUM(salary) FROM employees GROUP BY dept_id HAVING SUM(salary) >= 100 AND MAX(salary) < 70;

/*
Prediction Result:
(0, 100)
*/