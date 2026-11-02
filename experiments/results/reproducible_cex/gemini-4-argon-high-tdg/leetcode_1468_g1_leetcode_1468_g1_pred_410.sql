-- Schema DDL
CREATE TABLE "Salaries" ("company_id" INTEGER, "employee_id" INTEGER, "employee_name" TEXT(255), "salary" INTEGER, PRIMARY KEY ("company_id", "employee_id"), CHECK ("salary" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 3
INSERT INTO Salaries (company_id, employee_id, employee_name, salary) VALUES (10, 1, 'Alice', 800);
INSERT INTO Salaries (company_id, employee_id, employee_name, salary) VALUES (10, 2, 'Alice', 800);
INSERT INTO Salaries (company_id, employee_id, employee_name, salary) VALUES (20, 1, 'Bob', 5000);
INSERT INTO Salaries (company_id, employee_id, employee_name, salary) VALUES (20, 2, 'Charlie', 5000);
INSERT INTO Salaries (company_id, employee_id, employee_name, salary) VALUES (20, 3, 'Alice', 1234);
INSERT INTO Salaries (company_id, employee_id, employee_name, salary) VALUES (30, 1, 'Bob', 20000);
INSERT INTO Salaries (company_id, employee_id, employee_name, salary) VALUES (30, 2, 'David', 20000);
INSERT INTO Salaries (company_id, employee_id, employee_name, salary) VALUES (30, 3, 'Eve', 3333);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT S.COMPANY_ID, S.EMPLOYEE_ID, S.EMPLOYEE_NAME, CASE WHEN MAX_SALARY < 1000 THEN SALARY WHEN MAX_SALARY >= 1000 AND MAX_SALARY <= 10000 THEN ROUND(SALARY - SALARY * 0.24, 0) WHEN MAX_SALARY > 10000 THEN ROUND(SALARY - SALARY * 0.49, 0) END AS SALARY FROM SALARIES AS S JOIN (SELECT COMPANY_ID, MAX(SALARY) AS MAX_SALARY FROM SALARIES GROUP BY COMPANY_ID) AS T ON S.COMPANY_ID = T.COMPANY_ID;

/*
Gold Result:
(10, 1, 'Alice', 800)
(10, 2, 'Alice', 800)
(20, 1, 'Bob', 3800.0)
(20, 2, 'Charlie', 3800.0)
(20, 3, 'Alice', 938.0)
(30, 1, 'Bob', 10200.0)
(30, 2, 'David', 10200.0)
(30, 3, 'Eve', 1700.0)
*/

-- Prediction Query
WITH CTE AS (SELECT *, CASE WHEN SALARY < 1000 THEN 0 WHEN SALARY BETWEEN 1000 AND 10000 THEN 0.24 ELSE 0.49 END AS TAX_PERCENT FROM (SELECT *, RANK() OVER (PARTITION BY COMPANY_ID ORDER BY SALARY DESC) AS R FROM SALARIES) AS A WHERE R = 1) SELECT S.COMPANY_ID, S.EMPLOYEE_ID, S.EMPLOYEE_NAME, ROUND(S.SALARY - (S.SALARY * TAX_PERCENT), 0) AS SALARY FROM SALARIES AS S JOIN CTE AS C ON S.COMPANY_ID = C.COMPANY_ID;

/*
Prediction Result:
(10, 1, 'Alice', 800.0)
(10, 2, 'Alice', 800.0)
(10, 1, 'Alice', 800.0)
(10, 2, 'Alice', 800.0)
(20, 1, 'Bob', 3800.0)
(20, 2, 'Charlie', 3800.0)
(20, 3, 'Alice', 938.0)
(20, 1, 'Bob', 3800.0)
(20, 2, 'Charlie', 3800.0)
(20, 3, 'Alice', 938.0)
(30, 1, 'Bob', 10200.0)
(30, 2, 'David', 10200.0)
(30, 3, 'Eve', 1700.0)
(30, 1, 'Bob', 10200.0)
(30, 2, 'David', 10200.0)
(30, 3, 'Eve', 1700.0)
*/