-- Schema DDL
CREATE TABLE "Salaries" ("company_id" INTEGER, "employee_id" INTEGER, "employee_name" TEXT(255), "salary" INTEGER, PRIMARY KEY ("company_id", "employee_id"), CHECK ("salary" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests exact boundary values for MAX_SAL (999, 1000, 10000, 10001) to catch off-by-one errors (< vs <=, > vs >=).
INSERT INTO Salaries (company_id, employee_id, employee_name, salary) VALUES (1, 1, 'Alice', 999);
INSERT INTO Salaries (company_id, employee_id, employee_name, salary) VALUES (1, 2, 'Bob', 500);
INSERT INTO Salaries (company_id, employee_id, employee_name, salary) VALUES (2, 1, 'Charlie', 1000);
INSERT INTO Salaries (company_id, employee_id, employee_name, salary) VALUES (2, 2, 'David', 500);
INSERT INTO Salaries (company_id, employee_id, employee_name, salary) VALUES (3, 1, 'Eve', 10000);
INSERT INTO Salaries (company_id, employee_id, employee_name, salary) VALUES (3, 2, 'Frank', 500);
INSERT INTO Salaries (company_id, employee_id, employee_name, salary) VALUES (4, 1, 'Grace', 10001);
INSERT INTO Salaries (company_id, employee_id, employee_name, salary) VALUES (4, 2, 'Heidi', 500);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT S.COMPANY_ID, S.EMPLOYEE_ID, S.EMPLOYEE_NAME, ROUND(CASE WHEN X.MAX_SAL BETWEEN 1000 AND 10000 THEN SALARY * 0.76 WHEN X.MAX_SAL > 10000 THEN SALARY * 0.51 ELSE SALARY END, 0) AS SALARY FROM SALARIES AS S INNER JOIN (SELECT COMPANY_ID, MAX(SALARY) AS MAX_SAL FROM SALARIES GROUP BY COMPANY_ID) AS X ON S.COMPANY_ID = X.COMPANY_ID;

/*
Gold Result:
(1, 1, 'Alice', 999.0)
(1, 2, 'Bob', 500.0)
(2, 1, 'Charlie', 760.0)
(2, 2, 'David', 380.0)
(3, 1, 'Eve', 7600.0)
(3, 2, 'Frank', 380.0)
(4, 1, 'Grace', 5101.0)
(4, 2, 'Heidi', 255.0)
*/

-- Prediction Query
WITH T1 AS (SELECT *, MAX(SALARY) OVER (PARTITION BY COMPANY_ID) AS HIGHEST_SALARY FROM SALARIES) SELECT COMPANY_ID, EMPLOYEE_ID, EMPLOYEE_NAME, ROUND(SALARY * TAX_RATE, 0) AS SALARY FROM (SELECT *, CASE WHEN HIGHEST_SALARY < 1000 THEN 1 WHEN HIGHEST_SALARY >= 1000 AND HIGHEST_SALARY < 10000 THEN 0.76 WHEN HIGHEST_SALARY >= 10000 THEN 0.51 END AS TAX_RATE FROM T1) AS SUB;

/*
Prediction Result:
(1, 1, 'Alice', 999.0)
(1, 2, 'Bob', 500.0)
(2, 1, 'Charlie', 760.0)
(2, 2, 'David', 380.0)
(3, 1, 'Eve', 5100.0)
(3, 2, 'Frank', 255.0)
(4, 1, 'Grace', 5101.0)
(4, 2, 'Heidi', 255.0)
*/