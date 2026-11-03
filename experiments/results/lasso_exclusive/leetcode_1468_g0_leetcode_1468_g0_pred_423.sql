-- Schema DDL
CREATE TABLE "Salaries" ("company_id" INTEGER, "employee_id" INTEGER, "employee_name" TEXT(255), "salary" INTEGER, PRIMARY KEY ("company_id", "employee_id"), CHECK ("salary" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "salaries" ("company_id", "employee_id", "employee_name", "salary") VALUES (1329, 1332, 'Dustin Jordan', 1335);
INSERT INTO "salaries" ("company_id", "employee_id", "employee_name", "salary") VALUES (1330, 1333, 'Mary Marshall', 1344.0);
INSERT INTO "salaries" ("company_id", "employee_id", "employee_name", "salary") VALUES (1331, 1334, 'Daniel Kennedy', 1353.0);
INSERT INTO "salaries" ("company_id", "employee_id", "employee_name", "salary") VALUES (NULL, 1341, 'Rebecca Jackson', 1344);
INSERT INTO "salaries" ("company_id", "employee_id", "employee_name", "salary") VALUES (1339, 1342, 'Jose Schultz', 1353.0);
INSERT INTO "salaries" ("company_id", "employee_id", "employee_name", "salary") VALUES (1340, 1343, 'Robert Potter', 1362.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT S.COMPANY_ID, S.EMPLOYEE_ID, S.EMPLOYEE_NAME, ROUND(CASE WHEN X.MAX_SAL BETWEEN 1000 AND 10000 THEN SALARY * 0.76 WHEN X.MAX_SAL > 10000 THEN SALARY * 0.51 ELSE SALARY END, 0) AS SALARY FROM SALARIES AS S INNER JOIN (SELECT COMPANY_ID, MAX(SALARY) AS MAX_SAL FROM SALARIES GROUP BY COMPANY_ID) AS X ON S.COMPANY_ID = X.COMPANY_ID;

/*
Gold Result:
(1329, 1332, 'Dustin Jordan', 1015.0)
(1330, 1333, 'Mary Marshall', 1021.0)
(1331, 1334, 'Daniel Kennedy', 1028.0)
(1339, 1342, 'Jose Schultz', 1028.0)
(1340, 1343, 'Robert Potter', 1035.0)
*/

-- Prediction Query
WITH CTE(COMPANY_ID, RATE) AS (SELECT COMPANY_ID, CASE WHEN MAX(SALARY) BETWEEN 1000 AND 10000 THEN 0.24 WHEN MAX(SALARY) > 10000 THEN 0.49 ELSE 0 END FROM SALARIES GROUP BY COMPANY_ID) SELECT SALARIES.COMPANY_ID, EMPLOYEE_ID, EMPLOYEE_NAME, ROUND(SALARY * (1 - RATE)) AS SALARY FROM SALARIES LEFT JOIN CTE ON SALARIES.COMPANY_ID = CTE.COMPANY_ID;

/*
Prediction Result:
(1329, 1332, 'Dustin Jordan', 1015.0)
(1330, 1333, 'Mary Marshall', 1021.0)
(1331, 1334, 'Daniel Kennedy', 1028.0)
(None, 1341, 'Rebecca Jackson', None)
(1339, 1342, 'Jose Schultz', 1028.0)
(1340, 1343, 'Robert Potter', 1035.0)
*/