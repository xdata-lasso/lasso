-- Schema DDL
CREATE TABLE "Salaries" ("company_id" INTEGER, "employee_id" INTEGER, "employee_name" TEXT(255), "salary" INTEGER, PRIMARY KEY ("company_id", "employee_id"), CHECK ("salary" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "salaries" ("company_id", "employee_id", "employee_name", "salary") VALUES (1256, 1259, 'Michelle Evans', 10001);
INSERT INTO "salaries" ("company_id", "employee_id", "employee_name", "salary") VALUES (1256, 1260, 'Jason Powell', 10001);
INSERT INTO "salaries" ("company_id", "employee_id", "employee_name", "salary") VALUES (1256, 1261, 'Cameron Fisher', 10001);
INSERT INTO "salaries" ("company_id", "employee_id", "employee_name", "salary") VALUES (1256, 1262, 'Megan Orr', 10001);
INSERT INTO "salaries" ("company_id", "employee_id", "employee_name", "salary") VALUES (1256, 1263, 'Elizabeth Kelley', 10001);
INSERT INTO "salaries" ("company_id", "employee_id", "employee_name", "salary") VALUES (1256, 1264, 'Dustin Jordan', 10001);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT S.COMPANY_ID, S.EMPLOYEE_ID, S.EMPLOYEE_NAME, CASE WHEN MAX_SALARY < 1000 THEN SALARY WHEN MAX_SALARY >= 1000 AND MAX_SALARY <= 10000 THEN ROUND(SALARY - SALARY * 0.24, 0) WHEN MAX_SALARY > 10000 THEN ROUND(SALARY - SALARY * 0.49, 0) END AS SALARY FROM SALARIES AS S JOIN (SELECT COMPANY_ID, MAX(SALARY) AS MAX_SALARY FROM SALARIES GROUP BY COMPANY_ID) AS T ON S.COMPANY_ID = T.COMPANY_ID;

/*
Gold Result:
(1256, 1259, 'Michelle Evans', 5101.0)
(1256, 1260, 'Jason Powell', 5101.0)
(1256, 1261, 'Cameron Fisher', 5101.0)
(1256, 1262, 'Megan Orr', 5101.0)
(1256, 1263, 'Elizabeth Kelley', 5101.0)
(1256, 1264, 'Dustin Jordan', 5101.0)
*/

-- Prediction Query
SELECT S.COMPANY_ID, S.EMPLOYEE_ID, S.EMPLOYEE_NAME, ROUND(CASE WHEN MSAL < 1000 THEN SALARY WHEN MSAL BETWEEN 1000 AND 10001 THEN SALARY * (1 - 0.24) WHEN MSAL > 10000 THEN SALARY * (1 - 0.49) END, 0) AS SALARY FROM SALARIES AS S JOIN (SELECT COMPANY_ID, MAX(SALARY) AS MSAL FROM SALARIES GROUP BY COMPANY_ID) AS A ON S.COMPANY_ID = A.COMPANY_ID;

/*
Prediction Result:
(1256, 1259, 'Michelle Evans', 7601.0)
(1256, 1260, 'Jason Powell', 7601.0)
(1256, 1261, 'Cameron Fisher', 7601.0)
(1256, 1262, 'Megan Orr', 7601.0)
(1256, 1263, 'Elizabeth Kelley', 7601.0)
(1256, 1264, 'Dustin Jordan', 7601.0)
*/