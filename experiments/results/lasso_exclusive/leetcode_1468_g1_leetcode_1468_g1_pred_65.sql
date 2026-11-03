-- Schema DDL
CREATE TABLE "Salaries" ("company_id" INTEGER, "employee_id" INTEGER, "employee_name" TEXT(255), "salary" INTEGER, PRIMARY KEY ("company_id", "employee_id"), CHECK ("salary" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "salaries" ("company_id", "employee_id", "employee_name", "salary") VALUES (1293, 1296, 'Crystal Johnson', 1299);
INSERT INTO "salaries" ("company_id", "employee_id", "employee_name", "salary") VALUES (1294, 1297, 'Garrett Lin', 1308.0);
INSERT INTO "salaries" ("company_id", "employee_id", "employee_name", "salary") VALUES (1295, 1298, 'Diana May', 1317.0);
INSERT INTO "salaries" ("company_id", "employee_id", "employee_name", "salary") VALUES (NULL, 1305, 'William Herrera', 1308);
INSERT INTO "salaries" ("company_id", "employee_id", "employee_name", "salary") VALUES (1303, 1306, 'Ashley Waller', 1317.0);
INSERT INTO "salaries" ("company_id", "employee_id", "employee_name", "salary") VALUES (1304, 1307, 'Victor Baker', 1326.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT S.COMPANY_ID, S.EMPLOYEE_ID, S.EMPLOYEE_NAME, CASE WHEN MAX_SALARY < 1000 THEN SALARY WHEN MAX_SALARY >= 1000 AND MAX_SALARY <= 10000 THEN ROUND(SALARY - SALARY * 0.24, 0) WHEN MAX_SALARY > 10000 THEN ROUND(SALARY - SALARY * 0.49, 0) END AS SALARY FROM SALARIES AS S JOIN (SELECT COMPANY_ID, MAX(SALARY) AS MAX_SALARY FROM SALARIES GROUP BY COMPANY_ID) AS T ON S.COMPANY_ID = T.COMPANY_ID;

/*
Gold Result:
(1293, 1296, 'Crystal Johnson', 987.0)
(1294, 1297, 'Garrett Lin', 994.0)
(1295, 1298, 'Diana May', 1001.0)
(1303, 1306, 'Ashley Waller', 1001.0)
(1304, 1307, 'Victor Baker', 1008.0)
*/

-- Prediction Query
WITH CTE1 AS (SELECT COMPANY_ID, EMPLOYEE_ID, EMPLOYEE_NAME, MAX(SALARY) AS MAX_SALARY FROM SALARIES GROUP BY COMPANY_ID) SELECT A.COMPANY_ID, A.EMPLOYEE_ID, A.EMPLOYEE_NAME, CASE WHEN B.MAX_SALARY > 10000 THEN ROUND(SALARY - CAST(SALARY * 49 AS REAL) / 100, 0) WHEN B.MAX_SALARY >= 1000 THEN ROUND(SALARY - CAST(SALARY * 24 AS REAL) / 100, 0) ELSE SALARY END AS SALARY FROM SALARIES AS A LEFT JOIN CTE1 AS B ON A.COMPANY_ID = B.COMPANY_ID;

/*
Prediction Result:
(1293, 1296, 'Crystal Johnson', 987.0)
(1294, 1297, 'Garrett Lin', 994.0)
(1295, 1298, 'Diana May', 1001.0)
(None, 1305, 'William Herrera', 1308)
(1303, 1306, 'Ashley Waller', 1001.0)
(1304, 1307, 'Victor Baker', 1008.0)
*/