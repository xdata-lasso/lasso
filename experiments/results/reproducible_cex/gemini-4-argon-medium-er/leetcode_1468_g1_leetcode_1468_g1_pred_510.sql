-- Schema DDL
CREATE TABLE "Salaries" ("company_id" INTEGER, "employee_id" INTEGER, "employee_name" TEXT(255), "salary" INTEGER, PRIMARY KEY ("company_id", "employee_id"), CHECK ("salary" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO Salaries (company_id, employee_id, employee_name, salary) VALUES (NULL, 1, 'Alice', 500);
INSERT INTO Salaries (company_id, employee_id, employee_name, salary) VALUES (1, 1, 'Bob', 20000);
INSERT INTO Salaries (company_id, employee_id, employee_name, salary) VALUES (1, 2, 'Charlie', 150);
INSERT INTO Salaries (company_id, employee_id, employee_name, salary) VALUES (1, 3, 'David', 350);
INSERT INTO Salaries (company_id, employee_id, employee_name, salary) VALUES (1, 4, 'Eve', 550);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT S.COMPANY_ID, S.EMPLOYEE_ID, S.EMPLOYEE_NAME, CASE WHEN MAX_SALARY < 1000 THEN SALARY WHEN MAX_SALARY >= 1000 AND MAX_SALARY <= 10000 THEN ROUND(SALARY - SALARY * 0.24, 0) WHEN MAX_SALARY > 10000 THEN ROUND(SALARY - SALARY * 0.49, 0) END AS SALARY FROM SALARIES AS S JOIN (SELECT COMPANY_ID, MAX(SALARY) AS MAX_SALARY FROM SALARIES GROUP BY COMPANY_ID) AS T ON S.COMPANY_ID = T.COMPANY_ID;

/*
Gold Result:
(1, 1, 'Bob', 10200.0)
(1, 2, 'Charlie', 77.0)
(1, 3, 'David', 179.0)
(1, 4, 'Eve', 281.0)
*/

-- Prediction Query
WITH CTE AS (SELECT COMPANY_ID, MAX(SALARY) AS MAXSL FROM SALARIES GROUP BY COMPANY_ID) SELECT S.COMPANY_ID, S.EMPLOYEE_ID, S.EMPLOYEE_NAME, CASE WHEN M.MAXSL < 1000 THEN S.SALARY WHEN M.MAXSL >= 1000 AND M.MAXSL <= 10000 THEN ROUND(S.SALARY * (1 - 0.24), 0) ELSE ROUND(S.SALARY * (1 - 0.49), 0) END AS SALARY FROM SALARIES AS S LEFT JOIN CTE AS M USING (COMPANY_ID);

/*
Prediction Result:
(None, 1, 'Alice', 255.0)
(1, 1, 'Bob', 10200.0)
(1, 2, 'Charlie', 77.0)
(1, 3, 'David', 179.0)
(1, 4, 'Eve', 281.0)
*/