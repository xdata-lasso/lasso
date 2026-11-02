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
SELECT S.COMPANY_ID, EMPLOYEE_ID, EMPLOYEE_NAME, ROUND(CAST(SALARY * T1.TAX_PCT AS REAL) / 100, 0) AS SALARY FROM (SELECT COMPANY_ID, CASE WHEN MAX_SALARY < 1000 THEN 100 WHEN MAX_SALARY > 1000 AND MAX_SALARY < 10000 THEN 76 WHEN MAX_SALARY > 10000 THEN 51 ELSE 0 END AS TAX_PCT FROM (SELECT COMPANY_ID, MAX(SALARY) AS MAX_SALARY FROM SALARIES GROUP BY COMPANY_ID) AS T) AS T1 JOIN SALARIES AS S ON T1.COMPANY_ID = S.COMPANY_ID;

/*
Prediction Result:
(1148, 1151, 'Tracy House', 0.0)
(1148, 1152, 'Carol Tucker', 0.0)
(1148, 1153, 'James Brown', 0.0)
(1148, 1154, 'William Baker', 0.0)
(1148, 1155, 'Jordan Henderson', 0.0)
(1148, 1156, 'Whitney Peters', 0.0)
*/