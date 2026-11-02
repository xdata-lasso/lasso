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
WITH MAX_SALARY AS (SELECT COMPANY_ID, MAX(SALARY) AS MAX_SALARY FROM SALARIES GROUP BY COMPANY_ID), MAX_SALARY_JOIN AS (SELECT S.COMPANY_ID, S.EMPLOYEE_ID, S.EMPLOYEE_NAME, S.SALARY, M.MAX_SALARY FROM SALARIES AS S LEFT JOIN MAX_SALARY AS M ON S.COMPANY_ID = M.COMPANY_ID) SELECT COMPANY_ID, EMPLOYEE_ID, EMPLOYEE_NAME, ROUND(CASE WHEN MAX_SALARY < 1000 THEN SALARY WHEN MAX_SALARY > 1000 AND MAX_SALARY < 10000 THEN SALARY * 0.76 ELSE SALARY * 0.51 END, 0) AS SALARY FROM MAX_SALARY_JOIN;

/*
Prediction Result:
(1148, 1151, 'Tracy House', 510.0)
(1148, 1152, 'Carol Tucker', 510.0)
(1148, 1153, 'James Brown', 510.0)
(1148, 1154, 'William Baker', 510.0)
(1148, 1155, 'Jordan Henderson', 510.0)
(1148, 1156, 'Whitney Peters', 510.0)
*/