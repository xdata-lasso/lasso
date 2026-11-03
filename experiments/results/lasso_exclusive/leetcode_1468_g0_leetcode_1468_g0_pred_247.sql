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
WITH HIGH AS (SELECT COMPANY_ID, MAX(SALARY) AS HIGHEST FROM SALARIES GROUP BY COMPANY_ID) SELECT S.COMPANY_ID, EMPLOYEE_ID, EMPLOYEE_NAME, ROUND(CASE WHEN HIGHEST < 1000 THEN (SALARY - SALARY * 0) WHEN HIGHEST >= 1000 AND HIGHEST <= 10000 THEN (SALARY - SALARY * 0.24) WHEN HIGHEST > 10000 THEN (SALARY - SALARY * 0.49) ELSE NULL END, 0) AS SALARY FROM HIGH AS H JOIN SALARIES AS S ON H.COMPANY_ID = S.COMPANY_ID GROUP BY 1, 2;

/*
Prediction Result:
(1238, None, 'Cameron Fisher', 959.0)
(1238, 1241, 'Michelle Evans', 945.0)
(1238, 1242, 'Jason Powell', 952.0)
(1238, 1247, 'Megan Orr', 950.0)
(1238, 1248, 'Elizabeth Kelley', 957.0)
*/