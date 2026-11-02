-- Schema DDL
CREATE TABLE "Salaries" ("company_id" INTEGER, "employee_id" INTEGER, "employee_name" TEXT(255), "salary" INTEGER, PRIMARY KEY ("company_id", "employee_id"), CHECK ("salary" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "salaries" ("company_id", "employee_id", "employee_name", "salary") VALUES (1247, 1250, 'Larry Dixon', 10000);
INSERT INTO "salaries" ("company_id", "employee_id", "employee_name", "salary") VALUES (1247, 1251, 'Kenneth Scott', 10000);
INSERT INTO "salaries" ("company_id", "employee_id", "employee_name", "salary") VALUES (1247, 1252, 'April Frost', 10000);
INSERT INTO "salaries" ("company_id", "employee_id", "employee_name", "salary") VALUES (1247, 1253, 'Michelle Harmon', 10000);
INSERT INTO "salaries" ("company_id", "employee_id", "employee_name", "salary") VALUES (1247, 1254, 'Helen Jones', 10000);
INSERT INTO "salaries" ("company_id", "employee_id", "employee_name", "salary") VALUES (1247, 1255, 'Erin Edwards', 10000);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT S.COMPANY_ID, S.EMPLOYEE_ID, S.EMPLOYEE_NAME, CASE WHEN MAX_SALARY < 1000 THEN SALARY WHEN MAX_SALARY >= 1000 AND MAX_SALARY <= 10000 THEN ROUND(SALARY - SALARY * 0.24, 0) WHEN MAX_SALARY > 10000 THEN ROUND(SALARY - SALARY * 0.49, 0) END AS SALARY FROM SALARIES AS S JOIN (SELECT COMPANY_ID, MAX(SALARY) AS MAX_SALARY FROM SALARIES GROUP BY COMPANY_ID) AS T ON S.COMPANY_ID = T.COMPANY_ID;

/*
Gold Result:
(1247, 1250, 'Larry Dixon', 7600.0)
(1247, 1251, 'Kenneth Scott', 7600.0)
(1247, 1252, 'April Frost', 7600.0)
(1247, 1253, 'Michelle Harmon', 7600.0)
(1247, 1254, 'Helen Jones', 7600.0)
(1247, 1255, 'Erin Edwards', 7600.0)
*/

-- Prediction Query
WITH CTE AS (SELECT *, MAX(SALARY) OVER (PARTITION BY COMPANY_ID) AS MXSALARY FROM SALARIES ORDER BY COMPANY_ID, SALARIES.employee_id NULLS LAST) SELECT COMPANY_ID, EMPLOYEE_ID, EMPLOYEE_NAME, ROUND(CASE WHEN MXSALARY < 1000 THEN SALARY WHEN MXSALARY < 10000 THEN 0.76 * SALARY ELSE 0.51 * SALARY END) AS SALARY FROM CTE;

/*
Prediction Result:
(1247, 1250, 'Larry Dixon', 5100.0)
(1247, 1251, 'Kenneth Scott', 5100.0)
(1247, 1252, 'April Frost', 5100.0)
(1247, 1253, 'Michelle Harmon', 5100.0)
(1247, 1254, 'Helen Jones', 5100.0)
(1247, 1255, 'Erin Edwards', 5100.0)
*/