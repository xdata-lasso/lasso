-- Schema DDL
CREATE TABLE "Salaries" ("company_id" INTEGER, "employee_id" INTEGER, "employee_name" TEXT(255), "salary" INTEGER, PRIMARY KEY ("company_id", "employee_id"), CHECK ("salary" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO Salaries (company_id, employee_id, employee_name, salary) VALUES (1, NULL, 'Alice', 100);
INSERT INTO Salaries (company_id, employee_id, employee_name, salary) VALUES (1, NULL, 'Bob', 200);
INSERT INTO Salaries (company_id, employee_id, employee_name, salary) VALUES (2, 1, 'Charlie', 500);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT S.COMPANY_ID, S.EMPLOYEE_ID, S.EMPLOYEE_NAME, CASE WHEN MAX_SALARY < 1000 THEN SALARY WHEN MAX_SALARY >= 1000 AND MAX_SALARY <= 10000 THEN ROUND(SALARY - SALARY * 0.24, 0) WHEN MAX_SALARY > 10000 THEN ROUND(SALARY - SALARY * 0.49, 0) END AS SALARY FROM SALARIES AS S JOIN (SELECT COMPANY_ID, MAX(SALARY) AS MAX_SALARY FROM SALARIES GROUP BY COMPANY_ID) AS T ON S.COMPANY_ID = T.COMPANY_ID;

/*
Gold Result:
(1, None, 'Alice', 100)
(1, None, 'Bob', 200)
(2, 1, 'Charlie', 500)
*/

-- Prediction Query
WITH MAX_SAL AS (SELECT COMPANY_ID, MAX(SALARY) AS SAL FROM SALARIES GROUP BY COMPANY_ID) SELECT S.COMPANY_ID, EMPLOYEE_ID, EMPLOYEE_NAME, ROUND((CASE WHEN M.SAL < 1000 THEN S.SALARY WHEN M.SAL BETWEEN 1000 AND 10000 THEN (0.76) * S.SALARY ELSE (0.51) * S.SALARY END), 0) AS SALARY FROM SALARIES AS S JOIN MAX_SAL AS M ON S.COMPANY_ID = M.COMPANY_ID GROUP BY S.COMPANY_ID, S.EMPLOYEE_ID;

/*
Prediction Result:
(1, None, 'Alice', 100.0)
(2, 1, 'Charlie', 500.0)
*/