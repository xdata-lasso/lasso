-- Schema DDL
CREATE TABLE "Salaries" ("company_id" INTEGER, "employee_id" INTEGER, "employee_name" TEXT(255), "salary" INTEGER, PRIMARY KEY ("company_id", "employee_id"), CHECK ("salary" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO Salaries (company_id, employee_id, employee_name, salary) VALUES (1, 1, 'Alice', 500);
INSERT INTO Salaries (company_id, employee_id, employee_name, salary) VALUES (2, 1, 'Bob', 500.6);
INSERT INTO Salaries (company_id, employee_id, employee_name, salary) VALUES (3, 1, 'Charlie', 4500000000000024);
INSERT INTO Salaries (company_id, employee_id, employee_name, salary) VALUES (NULL, 1, 'Dave', 500);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT S.COMPANY_ID, S.EMPLOYEE_ID, S.EMPLOYEE_NAME, ROUND(CASE WHEN X.MAX_SAL BETWEEN 1000 AND 10000 THEN SALARY * 0.76 WHEN X.MAX_SAL > 10000 THEN SALARY * 0.51 ELSE SALARY END, 0) AS SALARY FROM SALARIES AS S INNER JOIN (SELECT COMPANY_ID, MAX(SALARY) AS MAX_SAL FROM SALARIES GROUP BY COMPANY_ID) AS X ON S.COMPANY_ID = X.COMPANY_ID;

/*
Gold Result:
(1, 1, 'Alice', 500.0)
(2, 1, 'Bob', 501.0)
(3, 1, 'Charlie', 2295000000000013.0)
*/

-- Prediction Query
WITH CTE AS (SELECT COMPANY_ID, MAX(SALARY) AS MAX_SALARY FROM SALARIES GROUP BY COMPANY_ID) SELECT S.COMPANY_ID, S.EMPLOYEE_ID, S.EMPLOYEE_NAME, CASE WHEN C.MAX_SALARY < 1000 THEN S.SALARY WHEN C.MAX_SALARY >= 100 AND C.MAX_SALARY <= 10000 THEN ROUND(S.SALARY - (0.24 * S.SALARY), 0) WHEN C.MAX_SALARY > 10000 THEN ROUND(S.SALARY - (0.49 * S.SALARY), 0) END AS SALARY FROM SALARIES AS S LEFT JOIN CTE AS C ON C.COMPANY_ID = S.COMPANY_ID;

/*
Prediction Result:
(1, 1, 'Alice', 500)
(2, 1, 'Bob', 500.6)
(3, 1, 'Charlie', 2295000000000012.0)
(None, 1, 'Dave', None)
*/