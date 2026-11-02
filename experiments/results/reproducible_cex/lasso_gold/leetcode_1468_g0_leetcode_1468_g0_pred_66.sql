-- Schema DDL
CREATE TABLE "Salaries" ("company_id" INTEGER, "employee_id" INTEGER, "employee_name" TEXT(255), "salary" INTEGER, PRIMARY KEY ("company_id", "employee_id"), CHECK ("salary" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "salaries" ("company_id", "employee_id", "employee_name", "salary") VALUES (1148, 1151, 'Tracy House', 1000);
INSERT INTO "salaries" ("company_id", "employee_id", "employee_name", "salary") VALUES (1148, 1152, 'Carol Tucker', 1000);
INSERT INTO "salaries" ("company_id", "employee_id", "employee_name", "salary") VALUES (1148, 1153, 'James Brown', 1000);
INSERT INTO "salaries" ("company_id", "employee_id", "employee_name", "salary") VALUES (1148, 1154, 'William Baker', 1000);
INSERT INTO "salaries" ("company_id", "employee_id", "employee_name", "salary") VALUES (1148, 1155, 'Jordan Henderson', 1000);
INSERT INTO "salaries" ("company_id", "employee_id", "employee_name", "salary") VALUES (1148, 1156, 'Whitney Peters', 1000);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT S.COMPANY_ID, S.EMPLOYEE_ID, S.EMPLOYEE_NAME, ROUND(CASE WHEN X.MAX_SAL BETWEEN 1000 AND 10000 THEN SALARY * 0.76 WHEN X.MAX_SAL > 10000 THEN SALARY * 0.51 ELSE SALARY END, 0) AS SALARY FROM SALARIES AS S INNER JOIN (SELECT COMPANY_ID, MAX(SALARY) AS MAX_SAL FROM SALARIES GROUP BY COMPANY_ID) AS X ON S.COMPANY_ID = X.COMPANY_ID;

/*
Gold Result:
(1148, 1151, 'Tracy House', 760.0)
(1148, 1152, 'Carol Tucker', 760.0)
(1148, 1153, 'James Brown', 760.0)
(1148, 1154, 'William Baker', 760.0)
(1148, 1155, 'Jordan Henderson', 760.0)
(1148, 1156, 'Whitney Peters', 760.0)
*/

-- Prediction Query
WITH COMPANYMAXSALARIES AS (SELECT COMPANY_ID, MAX(SALARY) AS MAX_SALARY FROM SALARIES GROUP BY COMPANY_ID), COMPANYTAX AS (SELECT COMPANY_ID, (CASE WHEN MAX_SALARY > 10000 THEN 0.49 WHEN MAX_SALARY > 1000 THEN 0.24 ELSE 0 END) AS TAX_PERCENT FROM COMPANYMAXSALARIES), EMPLOYEEPAYCHECKAFTERTAX AS (SELECT S.COMPANY_ID, S.EMPLOYEE_ID, S.EMPLOYEE_NAME, ROUND(S.SALARY * (1 - C.TAX_PERCENT), 0) AS SALARY FROM SALARIES AS S INNER JOIN COMPANYTAX AS C ON S.COMPANY_ID = C.COMPANY_ID) SELECT * FROM EMPLOYEEPAYCHECKAFTERTAX;

/*
Prediction Result:
(1148, 1151, 'Tracy House', 1000.0)
(1148, 1152, 'Carol Tucker', 1000.0)
(1148, 1153, 'James Brown', 1000.0)
(1148, 1154, 'William Baker', 1000.0)
(1148, 1155, 'Jordan Henderson', 1000.0)
(1148, 1156, 'Whitney Peters', 1000.0)
*/