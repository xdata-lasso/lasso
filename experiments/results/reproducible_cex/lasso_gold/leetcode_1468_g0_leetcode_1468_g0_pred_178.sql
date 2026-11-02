-- Schema DDL
CREATE TABLE "Salaries" ("company_id" INTEGER, "employee_id" INTEGER, "employee_name" TEXT(255), "salary" INTEGER, PRIMARY KEY ("company_id", "employee_id"), CHECK ("salary" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "salaries" ("company_id", "employee_id", "employee_name", "salary") VALUES (1184, 1187, 'Matthew Mcmillan', 10001);
INSERT INTO "salaries" ("company_id", "employee_id", "employee_name", "salary") VALUES (1184, 1188, 'Brian Rodriguez', 10001);
INSERT INTO "salaries" ("company_id", "employee_id", "employee_name", "salary") VALUES (1184, 1189, 'Denise Jacobs', 10001);
INSERT INTO "salaries" ("company_id", "employee_id", "employee_name", "salary") VALUES (1184, 1190, 'Christina Walters', 10001);
INSERT INTO "salaries" ("company_id", "employee_id", "employee_name", "salary") VALUES (1184, 1191, 'John Whitehead', 10001);
INSERT INTO "salaries" ("company_id", "employee_id", "employee_name", "salary") VALUES (1184, 1192, 'Anna Henderson', 10001);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT S.COMPANY_ID, S.EMPLOYEE_ID, S.EMPLOYEE_NAME, ROUND(CASE WHEN X.MAX_SAL BETWEEN 1000 AND 10000 THEN SALARY * 0.76 WHEN X.MAX_SAL > 10000 THEN SALARY * 0.51 ELSE SALARY END, 0) AS SALARY FROM SALARIES AS S INNER JOIN (SELECT COMPANY_ID, MAX(SALARY) AS MAX_SAL FROM SALARIES GROUP BY COMPANY_ID) AS X ON S.COMPANY_ID = X.COMPANY_ID;

/*
Gold Result:
(1184, 1187, 'Matthew Mcmillan', 5101.0)
(1184, 1188, 'Brian Rodriguez', 5101.0)
(1184, 1189, 'Denise Jacobs', 5101.0)
(1184, 1190, 'Christina Walters', 5101.0)
(1184, 1191, 'John Whitehead', 5101.0)
(1184, 1192, 'Anna Henderson', 5101.0)
*/

-- Prediction Query
SELECT S.COMPANY_ID, S.EMPLOYEE_ID, S.EMPLOYEE_NAME, ROUND(CASE WHEN MSAL < 1000 THEN SALARY WHEN MSAL BETWEEN 1000 AND 10001 THEN SALARY * (1 - 0.24) WHEN MSAL > 10000 THEN SALARY * (1 - 0.49) END, 0) AS SALARY FROM SALARIES AS S JOIN (SELECT COMPANY_ID, MAX(SALARY) AS MSAL FROM SALARIES GROUP BY COMPANY_ID) AS A ON S.COMPANY_ID = A.COMPANY_ID;

/*
Prediction Result:
(1184, 1187, 'Matthew Mcmillan', 7601.0)
(1184, 1188, 'Brian Rodriguez', 7601.0)
(1184, 1189, 'Denise Jacobs', 7601.0)
(1184, 1190, 'Christina Walters', 7601.0)
(1184, 1191, 'John Whitehead', 7601.0)
(1184, 1192, 'Anna Henderson', 7601.0)
*/