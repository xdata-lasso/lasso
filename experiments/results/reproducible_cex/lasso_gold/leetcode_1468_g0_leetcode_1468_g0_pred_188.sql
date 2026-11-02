-- Schema DDL
CREATE TABLE "Salaries" ("company_id" INTEGER, "employee_id" INTEGER, "employee_name" TEXT(255), "salary" INTEGER, PRIMARY KEY ("company_id", "employee_id"), CHECK ("salary" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "salaries" ("company_id", "employee_id", "employee_name", "salary") VALUES (1001, 1004, 'Allison Hill', 1007);
INSERT INTO "salaries" ("company_id", "employee_id", "employee_name", "salary") VALUES (1001, 1005, 'Noah Rhodes', 1016.0);
INSERT INTO "salaries" ("company_id", "employee_id", "employee_name", "salary") VALUES (1001, 1006, 'Angie Henderson', 1025.0);
INSERT INTO "salaries" ("company_id", "employee_id", "employee_name", "salary") VALUES (1001, 1010, 'Daniel Wagner', 1013);
INSERT INTO "salaries" ("company_id", "employee_id", "employee_name", "salary") VALUES (1001, 1011, 'Cristian Santos', 1022.0);
INSERT INTO "salaries" ("company_id", "employee_id", "employee_name", "salary") VALUES (1001, 1012, 'Connie Lawrence', 1031.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT S.COMPANY_ID, S.EMPLOYEE_ID, S.EMPLOYEE_NAME, ROUND(CASE WHEN X.MAX_SAL BETWEEN 1000 AND 10000 THEN SALARY * 0.76 WHEN X.MAX_SAL > 10000 THEN SALARY * 0.51 ELSE SALARY END, 0) AS SALARY FROM SALARIES AS S INNER JOIN (SELECT COMPANY_ID, MAX(SALARY) AS MAX_SAL FROM SALARIES GROUP BY COMPANY_ID) AS X ON S.COMPANY_ID = X.COMPANY_ID;

/*
Gold Result:
(1001, 1004, 'Allison Hill', 765.0)
(1001, 1005, 'Noah Rhodes', 772.0)
(1001, 1006, 'Angie Henderson', 779.0)
(1001, 1010, 'Daniel Wagner', 770.0)
(1001, 1011, 'Cristian Santos', 777.0)
(1001, 1012, 'Connie Lawrence', 784.0)
*/

-- Prediction Query
SELECT S.COMPANY_ID, S.EMPLOYEE_ID, S.EMPLOYEE_NAME, CAST(S.SALARY - (CASE WHEN CM.COMP_MAX < 1000 THEN 0 WHEN CM.COMP_MAX <= 10000 AND CM.COMP_MAX >= 1000 THEN 0.24 ELSE 0.49 END) * S.SALARY AS INTEGER) AS SALARY FROM SALARIES AS S LEFT JOIN (SELECT COMPANY_ID, MAX(SALARY) AS COMP_MAX FROM SALARIES GROUP BY COMPANY_ID) AS CM ON S.COMPANY_ID = CM.COMPANY_ID;

/*
Prediction Result:
(1001, 1004, 'Allison Hill', 765)
(1001, 1005, 'Noah Rhodes', 772)
(1001, 1006, 'Angie Henderson', 779)
(1001, 1010, 'Daniel Wagner', 769)
(1001, 1011, 'Cristian Santos', 776)
(1001, 1012, 'Connie Lawrence', 783)
*/