-- Schema DDL
CREATE TABLE "Salaries" ("company_id" INTEGER, "employee_id" INTEGER, "employee_name" TEXT(255), "salary" INTEGER, PRIMARY KEY ("company_id", "employee_id"), CHECK ("salary" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "salaries" ("company_id", "employee_id", "employee_name", "salary") VALUES (1238, 1241, 'Michelle Evans', 1244);
INSERT INTO "salaries" ("company_id", "employee_id", "employee_name", "salary") VALUES (1238, 1242, 'Jason Powell', 1253.0);
INSERT INTO "salaries" ("company_id", "employee_id", "employee_name", "salary") VALUES (1238, NULL, 'Cameron Fisher', 1262.0);
INSERT INTO "salaries" ("company_id", "employee_id", "employee_name", "salary") VALUES (1238, 1247, 'Megan Orr', 1250);
INSERT INTO "salaries" ("company_id", "employee_id", "employee_name", "salary") VALUES (1238, 1248, 'Elizabeth Kelley', 1259.0);
INSERT INTO "salaries" ("company_id", "employee_id", "employee_name", "salary") VALUES (1238, NULL, 'Dustin Jordan', 1268.0);
INSERT INTO "salaries" ("company_id", "employee_id", "employee_name", "salary") VALUES (1238, NULL, 'Cameron Fisher', 1262.0);
INSERT INTO "salaries" ("company_id", "employee_id", "employee_name", "salary") VALUES (1238, NULL, 'Dustin Jordan', 1268.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT S.COMPANY_ID, S.EMPLOYEE_ID, S.EMPLOYEE_NAME, ROUND(CASE WHEN X.MAX_SAL BETWEEN 1000 AND 10000 THEN SALARY * 0.76 WHEN X.MAX_SAL > 10000 THEN SALARY * 0.51 ELSE SALARY END, 0) AS SALARY FROM SALARIES AS S INNER JOIN (SELECT COMPANY_ID, MAX(SALARY) AS MAX_SAL FROM SALARIES GROUP BY COMPANY_ID) AS X ON S.COMPANY_ID = X.COMPANY_ID;

/*
Gold Result:
(1238, None, 'Cameron Fisher', 959.0)
(1238, None, 'Dustin Jordan', 964.0)
(1238, None, 'Cameron Fisher', 959.0)
(1238, None, 'Dustin Jordan', 964.0)
(1238, 1241, 'Michelle Evans', 945.0)
(1238, 1242, 'Jason Powell', 952.0)
(1238, 1247, 'Megan Orr', 950.0)
(1238, 1248, 'Elizabeth Kelley', 957.0)
*/

-- Prediction Query
WITH CTE AS (SELECT COMPANY_ID, MAX(SALARY) OVER (PARTITION BY COMPANY_ID) AS MAX_SALARY, EMPLOYEE_ID FROM SALARIES), C2 AS (SELECT COMPANY_ID, MAX_SALARY, EMPLOYEE_ID, CASE WHEN MAX_SALARY < 1000 THEN 1 WHEN MAX_SALARY BETWEEN 1000 AND 10000 THEN 1 - 0.24 ELSE 1 - 0.49 END AS RATE FROM CTE) SELECT S.COMPANY_ID, S.EMPLOYEE_ID, S.EMPLOYEE_NAME, ROUND(S.SALARY * C.RATE, 0) AS SALARY FROM SALARIES AS S JOIN C2 AS C ON S.COMPANY_ID = C.COMPANY_ID AND S.EMPLOYEE_ID = C.EMPLOYEE_ID;

/*
Prediction Result:
(1238, 1241, 'Michelle Evans', 945.0)
(1238, 1242, 'Jason Powell', 952.0)
(1238, 1247, 'Megan Orr', 950.0)
(1238, 1248, 'Elizabeth Kelley', 957.0)
*/