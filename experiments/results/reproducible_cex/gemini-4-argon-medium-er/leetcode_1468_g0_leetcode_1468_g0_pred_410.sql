-- Schema DDL
CREATE TABLE "Salaries" ("company_id" INTEGER, "employee_id" INTEGER, "employee_name" TEXT(255), "salary" INTEGER, PRIMARY KEY ("company_id", "employee_id"), CHECK ("salary" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Salaries" ("company_id", "employee_id", "employee_name", "salary") VALUES (1, 1, 'Alice', 500);
INSERT INTO "Salaries" ("company_id", "employee_id", "employee_name", "salary") VALUES (2, NULL, 'Bob', 2000);
INSERT INTO "Salaries" ("company_id", "employee_id", "employee_name", "salary") VALUES (2, NULL, 'Charlie', 2000);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT S.COMPANY_ID, S.EMPLOYEE_ID, S.EMPLOYEE_NAME, ROUND(CASE WHEN X.MAX_SAL BETWEEN 1000 AND 10000 THEN SALARY * 0.76 WHEN X.MAX_SAL > 10000 THEN SALARY * 0.51 ELSE SALARY END, 0) AS SALARY FROM SALARIES AS S INNER JOIN (SELECT COMPANY_ID, MAX(SALARY) AS MAX_SAL FROM SALARIES GROUP BY COMPANY_ID) AS X ON S.COMPANY_ID = X.COMPANY_ID;

/*
Gold Result:
(1, 1, 'Alice', 500.0)
(2, None, 'Bob', 1520.0)
(2, None, 'Charlie', 1520.0)
*/

-- Prediction Query
WITH TAX AS (SELECT COMPANY_ID, MAX(SALARY) AS MAXSALARY FROM SALARIES GROUP BY 1) SELECT S.COMPANY_ID, S.EMPLOYEE_ID, S.EMPLOYEE_NAME, CASE WHEN T.MAXSALARY < 1000 THEN SALARY * 1 WHEN T.MAXSALARY >= 1000 AND T.MAXSALARY <= 10000 THEN ROUND(SALARY * 0.76) WHEN T.MAXSALARY > 10000 THEN ROUND(SALARY * 0.51) END AS SALARY FROM SALARIES AS S JOIN TAX AS T ON S.COMPANY_ID = T.COMPANY_ID GROUP BY 1, 2;

/*
Prediction Result:
(1, 1, 'Alice', 500)
(2, None, 'Bob', 1520.0)
*/