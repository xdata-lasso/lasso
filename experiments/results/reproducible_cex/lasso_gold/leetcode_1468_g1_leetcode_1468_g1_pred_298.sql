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
SELECT S.COMPANY_ID, S.EMPLOYEE_ID, S.EMPLOYEE_NAME, CASE WHEN MAX_SALARY < 1000 THEN SALARY WHEN MAX_SALARY >= 1000 AND MAX_SALARY <= 10000 THEN ROUND(SALARY - SALARY * 0.24, 0) WHEN MAX_SALARY > 10000 THEN ROUND(SALARY - SALARY * 0.49, 0) END AS SALARY FROM SALARIES AS S JOIN (SELECT COMPANY_ID, MAX(SALARY) AS MAX_SALARY FROM SALARIES GROUP BY COMPANY_ID) AS T ON S.COMPANY_ID = T.COMPANY_ID;

/*
Gold Result:
(1053, 1056, 'Lisa Jackson', 0.16887417218543047)
(1054, 1057, 'Carla Gray', 0.16887417218543047)
(1055, 1058, 'Margaret Hawkins DDS', 0.16887417218543047)
*/

-- Prediction Query
WITH A AS (SELECT COMPANY_ID, CASE WHEN MAX(SALARY) < 1000 THEN 0 WHEN MAX(SALARY) > 10000 THEN 0.49 ELSE 0.24 END AS RATE FROM SALARIES GROUP BY COMPANY_ID) SELECT S.COMPANY_ID, EMPLOYEE_ID, EMPLOYEE_NAME, ROUND(SALARY * (1 - RATE)) AS SALARY FROM SALARIES AS S INNER JOIN A USING (COMPANY_ID);

/*
Prediction Result:
(1053, 1056, 'Lisa Jackson', 0.0)
(1054, 1057, 'Carla Gray', 0.0)
(1055, 1058, 'Margaret Hawkins DDS', 0.0)
*/