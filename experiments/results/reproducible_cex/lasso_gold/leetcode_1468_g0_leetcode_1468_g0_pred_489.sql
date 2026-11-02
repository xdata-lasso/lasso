-- Schema DDL
CREATE TABLE "Salaries" ("company_id" INTEGER, "employee_id" INTEGER, "employee_name" TEXT(255), "salary" INTEGER, PRIMARY KEY ("company_id", "employee_id"), CHECK ("salary" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "salaries" ("company_id", "employee_id", "employee_name", "salary") VALUES (1175, 1178, 'Zachary Ferrell', 10000);
INSERT INTO "salaries" ("company_id", "employee_id", "employee_name", "salary") VALUES (1175, 1179, 'Daniel Baker', 10000);
INSERT INTO "salaries" ("company_id", "employee_id", "employee_name", "salary") VALUES (1175, 1180, 'Shirley Suarez', 10000);
INSERT INTO "salaries" ("company_id", "employee_id", "employee_name", "salary") VALUES (1175, 1181, 'Christopher Bass', 10000);
INSERT INTO "salaries" ("company_id", "employee_id", "employee_name", "salary") VALUES (1175, 1182, 'Lisa Archer', 10000);
INSERT INTO "salaries" ("company_id", "employee_id", "employee_name", "salary") VALUES (1175, 1183, 'Aimee Montoya', 10000);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT S.COMPANY_ID, S.EMPLOYEE_ID, S.EMPLOYEE_NAME, ROUND(CASE WHEN X.MAX_SAL BETWEEN 1000 AND 10000 THEN SALARY * 0.76 WHEN X.MAX_SAL > 10000 THEN SALARY * 0.51 ELSE SALARY END, 0) AS SALARY FROM SALARIES AS S INNER JOIN (SELECT COMPANY_ID, MAX(SALARY) AS MAX_SAL FROM SALARIES GROUP BY COMPANY_ID) AS X ON S.COMPANY_ID = X.COMPANY_ID;

/*
Gold Result:
(1175, 1178, 'Zachary Ferrell', 7600.0)
(1175, 1179, 'Daniel Baker', 7600.0)
(1175, 1180, 'Shirley Suarez', 7600.0)
(1175, 1181, 'Christopher Bass', 7600.0)
(1175, 1182, 'Lisa Archer', 7600.0)
(1175, 1183, 'Aimee Montoya', 7600.0)
*/

-- Prediction Query
WITH T1 AS (SELECT *, MAX(SALARY) OVER (PARTITION BY COMPANY_ID ORDER BY COMPANY_ID) AS MX FROM SALARIES) SELECT COMPANY_ID, EMPLOYEE_ID, EMPLOYEE_NAME, ROUND(CASE WHEN MX < 1000 THEN SALARY WHEN MX BETWEEN 1000 AND 9999 THEN SALARY - (SALARY * 0.24) WHEN MX > 10000 THEN SALARY - (SALARY * 0.49) END) AS SALARY FROM T1 ORDER BY 1, 2, COMPANY_ID NULLS LAST, EMPLOYEE_ID NULLS LAST, EMPLOYEE_NAME NULLS LAST, SALARY NULLS LAST;

/*
Prediction Result:
(1175, 1178, 'Zachary Ferrell', None)
(1175, 1179, 'Daniel Baker', None)
(1175, 1180, 'Shirley Suarez', None)
(1175, 1181, 'Christopher Bass', None)
(1175, 1182, 'Lisa Archer', None)
(1175, 1183, 'Aimee Montoya', None)
*/