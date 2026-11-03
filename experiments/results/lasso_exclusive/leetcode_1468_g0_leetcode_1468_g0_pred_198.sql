-- Schema DDL
CREATE TABLE "Salaries" ("company_id" INTEGER, "employee_id" INTEGER, "employee_name" TEXT(255), "salary" INTEGER, PRIMARY KEY ("company_id", "employee_id"), CHECK ("salary" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "salaries" ("company_id", "employee_id", "employee_name", "salary") VALUES (1053, 1056, 'Lisa Jackson', 0.16887417218543047);
INSERT INTO "salaries" ("company_id", "employee_id", "employee_name", "salary") VALUES (1054, 1057, 'Carla Gray', 0.16887417218543047);
INSERT INTO "salaries" ("company_id", "employee_id", "employee_name", "salary") VALUES (1055, 1058, 'Margaret Hawkins DDS', 0.16887417218543047);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT S.COMPANY_ID, S.EMPLOYEE_ID, S.EMPLOYEE_NAME, ROUND(CASE WHEN X.MAX_SAL BETWEEN 1000 AND 10000 THEN SALARY * 0.76 WHEN X.MAX_SAL > 10000 THEN SALARY * 0.51 ELSE SALARY END, 0) AS SALARY FROM SALARIES AS S INNER JOIN (SELECT COMPANY_ID, MAX(SALARY) AS MAX_SAL FROM SALARIES GROUP BY COMPANY_ID) AS X ON S.COMPANY_ID = X.COMPANY_ID;

/*
Gold Result:
(1053, 1056, 'Lisa Jackson', 0.0)
(1054, 1057, 'Carla Gray', 0.0)
(1055, 1058, 'Margaret Hawkins DDS', 0.0)
*/

-- Prediction Query
SELECT X.COMPANY_ID, X.EMPLOYEE_ID, X.EMPLOYEE_NAME, CASE WHEN MAX_SALARY < 1000 THEN SALARY WHEN MAX_SALARY BETWEEN 1000 AND 10000 THEN ROUND((1 - 0.24) * SALARY) ELSE ROUND((1 - 0.49) * SALARY) END AS SALARY FROM SALARIES AS X JOIN (SELECT COMPANY_ID, MAX(SALARY) AS MAX_SALARY FROM SALARIES GROUP BY 1) AS Y ON X.COMPANY_ID = Y.COMPANY_ID;

/*
Prediction Result:
(1053, 1056, 'Lisa Jackson', 0.16887417218543047)
(1054, 1057, 'Carla Gray', 0.16887417218543047)
(1055, 1058, 'Margaret Hawkins DDS', 0.16887417218543047)
*/