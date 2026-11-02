-- Schema DDL
CREATE TABLE "Salaries" ("company_id" INTEGER, "employee_id" INTEGER, "employee_name" TEXT(255), "salary" INTEGER, PRIMARY KEY ("company_id", "employee_id"), CHECK ("salary" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
-- Tests intra-company salary variance and aggregation mistakes (e.g., filtering by individual salary instead of company MAX, or using MIN/AVG/SUM instead of MAX).
-- Also includes overlapping employee_ids across different companies to catch faulty JOIN conditions.
INSERT INTO Salaries (company_id, employee_id, employee_name, salary) VALUES (10, 1, 'Ivan', 600);
INSERT INTO Salaries (company_id, employee_id, employee_name, salary) VALUES (10, 2, 'Judy', 600);
INSERT INTO Salaries (company_id, employee_id, employee_name, salary) VALUES (20, 1, 'Mallory', 500);
INSERT INTO Salaries (company_id, employee_id, employee_name, salary) VALUES (20, 2, 'Niaj', 5000);
INSERT INTO Salaries (company_id, employee_id, employee_name, salary) VALUES (30, 1, 'Olivia', 800);
INSERT INTO Salaries (company_id, employee_id, employee_name, salary) VALUES (30, 2, 'Peggy', 5000);
INSERT INTO Salaries (company_id, employee_id, employee_name, salary) VALUES (30, 3, 'Rupert', 15000);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT S.COMPANY_ID, S.EMPLOYEE_ID, S.EMPLOYEE_NAME, ROUND(CASE WHEN X.MAX_SAL BETWEEN 1000 AND 10000 THEN SALARY * 0.76 WHEN X.MAX_SAL > 10000 THEN SALARY * 0.51 ELSE SALARY END, 0) AS SALARY FROM SALARIES AS S INNER JOIN (SELECT COMPANY_ID, MAX(SALARY) AS MAX_SAL FROM SALARIES GROUP BY COMPANY_ID) AS X ON S.COMPANY_ID = X.COMPANY_ID;

/*
Gold Result:
(10, 1, 'Ivan', 600.0)
(10, 2, 'Judy', 600.0)
(20, 1, 'Mallory', 380.0)
(20, 2, 'Niaj', 3800.0)
(30, 1, 'Olivia', 408.0)
(30, 2, 'Peggy', 2550.0)
(30, 3, 'Rupert', 7650.0)
*/

-- Prediction Query
WITH CTE AS (SELECT *, CASE WHEN SALARY < 1000 THEN 0 WHEN SALARY BETWEEN 1000 AND 10000 THEN 0.24 ELSE 0.49 END AS TAX_PERCENT FROM (SELECT *, RANK() OVER (PARTITION BY COMPANY_ID ORDER BY SALARY DESC) AS R FROM SALARIES) AS A WHERE R = 1) SELECT S.COMPANY_ID, S.EMPLOYEE_ID, S.EMPLOYEE_NAME, ROUND(S.SALARY - (S.SALARY * TAX_PERCENT), 0) AS SALARY FROM SALARIES AS S JOIN CTE AS C ON S.COMPANY_ID = C.COMPANY_ID;

/*
Prediction Result:
(10, 1, 'Ivan', 600.0)
(10, 2, 'Judy', 600.0)
(10, 1, 'Ivan', 600.0)
(10, 2, 'Judy', 600.0)
(20, 1, 'Mallory', 380.0)
(20, 2, 'Niaj', 3800.0)
(30, 1, 'Olivia', 408.0)
(30, 2, 'Peggy', 2550.0)
(30, 3, 'Rupert', 7650.0)
*/