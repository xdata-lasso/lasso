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
SELECT S1.COMPANY_ID, S1.EMPLOYEE_ID, S1.EMPLOYEE_NAME, (CASE WHEN N.COMPANY_MAX < 1000 THEN S1.SALARY WHEN N.COMPANY_MAX >= 10000 THEN ROUND(0.51 * S1.SALARY, 0) ELSE ROUND(0.76 * S1.SALARY, 0) END) AS SALARY FROM SALARIES AS S1 JOIN (SELECT S2.COMPANY_ID, MAX(S2.SALARY) AS COMPANY_MAX FROM SALARIES AS S2 GROUP BY S2.COMPANY_ID) AS N ON S1.COMPANY_ID = N.COMPANY_ID;

/*
Prediction Result:
(1247, 1250, 'Larry Dixon', 5100.0)
(1247, 1251, 'Kenneth Scott', 5100.0)
(1247, 1252, 'April Frost', 5100.0)
(1247, 1253, 'Michelle Harmon', 5100.0)
(1247, 1254, 'Helen Jones', 5100.0)
(1247, 1255, 'Erin Edwards', 5100.0)
*/