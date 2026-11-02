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
WITH TAX AS (SELECT *, CASE WHEN MAX(SALARY) < 1000 THEN 0 WHEN 1000 <= MAX(SALARY) AND MAX(SALARY) < 10000 THEN 0.24 WHEN 10000 <= MAX(SALARY) THEN 0.49 END AS TAX_RATE FROM SALARIES GROUP BY COMPANY_ID) SELECT A.COMPANY_ID, A.EMPLOYEE_ID, A.EMPLOYEE_NAME, ROUND(A.SALARY * (1 - B.TAX_RATE), 0) AS SALARY FROM SALARIES AS A LEFT JOIN TAX AS B ON A.COMPANY_ID = B.COMPANY_ID;

/*
Prediction Result:
(1175, 1178, 'Zachary Ferrell', 5100.0)
(1175, 1179, 'Daniel Baker', 5100.0)
(1175, 1180, 'Shirley Suarez', 5100.0)
(1175, 1181, 'Christopher Bass', 5100.0)
(1175, 1182, 'Lisa Archer', 5100.0)
(1175, 1183, 'Aimee Montoya', 5100.0)
*/