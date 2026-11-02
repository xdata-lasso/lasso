-- Schema DDL
CREATE TABLE "Salaries" ("company_id" INTEGER, "employee_id" INTEGER, "employee_name" TEXT(255), "salary" INTEGER, PRIMARY KEY ("company_id", "employee_id"), CHECK ("salary" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 4
-- Tests SUM vs MAX mutation in the subquery.
-- Individual salaries are all < 1000 (MAX = 600), so tax should be 0%. If a mutant uses SUM(salary) = 1800, it will falsely apply the 24% tax bracket.
-- In Company 2, MAX is 6000 (24% tax), whereas SUM is 16000 (which would falsely trigger the 49% tax bracket).
INSERT INTO Salaries (company_id, employee_id, employee_name, salary) VALUES (1, 1, 'A', 600);
INSERT INTO Salaries (company_id, employee_id, employee_name, salary) VALUES (1, 2, 'B', 600);
INSERT INTO Salaries (company_id, employee_id, employee_name, salary) VALUES (1, 3, 'C', 600);
INSERT INTO Salaries (company_id, employee_id, employee_name, salary) VALUES (2, 1, 'D', 6000);
INSERT INTO Salaries (company_id, employee_id, employee_name, salary) VALUES (2, 2, 'E', 5000);
INSERT INTO Salaries (company_id, employee_id, employee_name, salary) VALUES (2, 3, 'F', 5000);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT S.COMPANY_ID, S.EMPLOYEE_ID, S.EMPLOYEE_NAME, CASE WHEN MAX_SALARY < 1000 THEN SALARY WHEN MAX_SALARY >= 1000 AND MAX_SALARY <= 10000 THEN ROUND(SALARY - SALARY * 0.24, 0) WHEN MAX_SALARY > 10000 THEN ROUND(SALARY - SALARY * 0.49, 0) END AS SALARY FROM SALARIES AS S JOIN (SELECT COMPANY_ID, MAX(SALARY) AS MAX_SALARY FROM SALARIES GROUP BY COMPANY_ID) AS T ON S.COMPANY_ID = T.COMPANY_ID;

/*
Gold Result:
(1, 1, 'A', 600)
(1, 2, 'B', 600)
(1, 3, 'C', 600)
(2, 1, 'D', 4560.0)
(2, 2, 'E', 3800.0)
(2, 3, 'F', 3800.0)
*/

-- Prediction Query
WITH CTE AS (SELECT *, CASE WHEN SALARY < 1000 THEN 0 WHEN SALARY BETWEEN 1000 AND 10000 THEN 0.24 ELSE 0.49 END AS TAX_PERCENT FROM (SELECT *, RANK() OVER (PARTITION BY COMPANY_ID ORDER BY SALARY DESC) AS R FROM SALARIES) AS A WHERE R = 1) SELECT S.COMPANY_ID, S.EMPLOYEE_ID, S.EMPLOYEE_NAME, ROUND(S.SALARY - (S.SALARY * TAX_PERCENT), 0) AS SALARY FROM SALARIES AS S JOIN CTE AS C ON S.COMPANY_ID = C.COMPANY_ID;

/*
Prediction Result:
(1, 1, 'A', 600.0)
(1, 2, 'B', 600.0)
(1, 3, 'C', 600.0)
(1, 1, 'A', 600.0)
(1, 2, 'B', 600.0)
(1, 3, 'C', 600.0)
(1, 1, 'A', 600.0)
(1, 2, 'B', 600.0)
(1, 3, 'C', 600.0)
(2, 1, 'D', 4560.0)
(2, 2, 'E', 3800.0)
(2, 3, 'F', 3800.0)
*/