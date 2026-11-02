-- Schema DDL
CREATE TABLE "Salaries" ("company_id" INTEGER, "employee_id" INTEGER, "employee_name" TEXT(255), "salary" INTEGER, PRIMARY KEY ("company_id", "employee_id"), CHECK ("salary" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests exact boundary conditions for MAX_SALARY (999, 1000, 10000, 10001) to catch off-by-one and inequality operator mutations (< vs <=, > vs >=).
INSERT INTO Salaries (company_id, employee_id, employee_name, salary) VALUES (1, 1, 'Alice', 999);
INSERT INTO Salaries (company_id, employee_id, employee_name, salary) VALUES (2, 1, 'Bob', 1000);
INSERT INTO Salaries (company_id, employee_id, employee_name, salary) VALUES (3, 1, 'Charlie', 10000);
INSERT INTO Salaries (company_id, employee_id, employee_name, salary) VALUES (4, 1, 'David', 10001);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT S.COMPANY_ID, S.EMPLOYEE_ID, S.EMPLOYEE_NAME, CASE WHEN MAX_SALARY < 1000 THEN SALARY WHEN MAX_SALARY >= 1000 AND MAX_SALARY <= 10000 THEN ROUND(SALARY - SALARY * 0.24, 0) WHEN MAX_SALARY > 10000 THEN ROUND(SALARY - SALARY * 0.49, 0) END AS SALARY FROM SALARIES AS S JOIN (SELECT COMPANY_ID, MAX(SALARY) AS MAX_SALARY FROM SALARIES GROUP BY COMPANY_ID) AS T ON S.COMPANY_ID = T.COMPANY_ID;

/*
Gold Result:
(1, 1, 'Alice', 999)
(2, 1, 'Bob', 760.0)
(3, 1, 'Charlie', 7600.0)
(4, 1, 'David', 5101.0)
*/

-- Prediction Query
WITH T1 AS (SELECT *, MAX(SALARY) OVER (PARTITION BY COMPANY_ID ORDER BY COMPANY_ID) AS MX FROM SALARIES) SELECT COMPANY_ID, EMPLOYEE_ID, EMPLOYEE_NAME, ROUND(CASE WHEN MX < 1000 THEN SALARY WHEN MX BETWEEN 1000 AND 9999 THEN SALARY - (SALARY * 0.24) WHEN MX > 10000 THEN SALARY - (SALARY * 0.49) END) AS SALARY FROM T1 ORDER BY 1, 2, COMPANY_ID NULLS LAST, EMPLOYEE_ID NULLS LAST, EMPLOYEE_NAME NULLS LAST, SALARY NULLS LAST;

/*
Prediction Result:
(1, 1, 'Alice', 999.0)
(2, 1, 'Bob', 760.0)
(3, 1, 'Charlie', None)
(4, 1, 'David', 5101.0)
*/