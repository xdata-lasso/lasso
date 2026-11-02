-- Schema DDL
CREATE TABLE "Salaries" ("company_id" INTEGER, "employee_id" INTEGER, "employee_name" TEXT(255), "salary" INTEGER, PRIMARY KEY ("company_id", "employee_id"), CHECK ("salary" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: salaries --
INSERT INTO "salaries" ("company_id", "employee_id", "employee_name", "salary") VALUES (1, -2147483648, 'sal_9b14c9', 247012447);

INSERT INTO "salaries" ("company_id", "employee_id", "employee_name", "salary") VALUES (1, -2147483647, 'sal_9b14c9', 1744686505);

INSERT INTO "salaries" ("company_id", "employee_id", "employee_name", "salary") VALUES (1, -2147483646, 'sal_9b14c9', 1115440883);

INSERT INTO "salaries" ("company_id", "employee_id", "employee_name", "salary") VALUES (1, 1, 's_s_f122f2', 1);

INSERT INTO "salaries" ("company_id", "employee_id", "employee_name", "salary") VALUES (1, -2147483644, 'sal_9b14c9', 1644814318);

INSERT INTO "salaries" ("company_id", "employee_id", "employee_name", "salary") VALUES (1, -2147483643, 'sal_9b14c9', 1465859724);

INSERT INTO "salaries" ("company_id", "employee_id", "employee_name", "salary") VALUES (1, -2147483642, 'sal_9b14c9', 1019800248);

INSERT INTO "salaries" ("company_id", "employee_id", "employee_name", "salary") VALUES (1, -2147483641, 'sal_9b14c9', 429706943);

INSERT INTO "salaries" ("company_id", "employee_id", "employee_name", "salary") VALUES (1, -2147483640, 'sal_9b14c9', 462974032);

INSERT INTO "salaries" ("company_id", "employee_id", "employee_name", "salary") VALUES (1, -2147483639, 'sal_9b14c9', 1861536320);

INSERT INTO "salaries" ("company_id", "employee_id", "employee_name", "salary") VALUES (-2147483647, -2147483638, 'sal_9b14c9', NULL);

INSERT INTO "salaries" ("company_id", "employee_id", "employee_name", "salary") VALUES (1, -2147483637, 'sal_9b14c9', NULL);

INSERT INTO "salaries" ("company_id", "employee_id", "employee_name", "salary") VALUES (1, -2147483636, 'sal_9b14c9', NULL);

INSERT INTO "salaries" ("company_id", "employee_id", "employee_name", "salary") VALUES (1, -2147483635, 'sal_9b14c9', NULL);

INSERT INTO "salaries" ("company_id", "employee_id", "employee_name", "salary") VALUES (-2147483646, -2147483634, NULL, 44952191);

INSERT INTO "salaries" ("company_id", "employee_id", "employee_name", "salary") VALUES (1, -2147483633, NULL, NULL);

INSERT INTO "salaries" ("company_id", "employee_id", "employee_name", "salary") VALUES (1, -2147483632, NULL, NULL);

INSERT INTO "salaries" ("company_id", "employee_id", "employee_name", "salary") VALUES (1, -2147483631, NULL, NULL);

INSERT INTO "salaries" ("company_id", "employee_id", "employee_name", "salary") VALUES (1, -2147483630, 'sal_9b14c9', NULL);

INSERT INTO "salaries" ("company_id", "employee_id", "employee_name", "salary") VALUES (1, -2147483629, 'sal_9b14c9', NULL);

INSERT INTO "salaries" ("company_id", "employee_id", "employee_name", "salary") VALUES (1, -2147483628, 'sal_9b14c9', NULL);

INSERT INTO "salaries" ("company_id", "employee_id", "employee_name", "salary") VALUES (1, -2147483627, 'sal_9b14c9', NULL);

INSERT INTO "salaries" ("company_id", "employee_id", "employee_name", "salary") VALUES (1, -2147483626, 'sal_9b14c9', NULL);

INSERT INTO "salaries" ("company_id", "employee_id", "employee_name", "salary") VALUES (1, -2147483625, 'sal_9b14c9', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT S.COMPANY_ID, S.EMPLOYEE_ID, S.EMPLOYEE_NAME, ROUND(CASE WHEN X.MAX_SAL BETWEEN 1000 AND 10000 THEN SALARY * 0.76 WHEN X.MAX_SAL > 10000 THEN SALARY * 0.51 ELSE SALARY END, 0) AS SALARY FROM SALARIES AS S INNER JOIN (SELECT COMPANY_ID, MAX(SALARY) AS MAX_SAL FROM SALARIES GROUP BY COMPANY_ID) AS X ON S.COMPANY_ID = X.COMPANY_ID;

/*
Gold Result:
(-2147483647, -2147483638, 'sal_9b14c9', None)
(-2147483646, -2147483634, None, 22925617.0)
(1, -2147483648, 'sal_9b14c9', 125976348.0)
(1, -2147483647, 'sal_9b14c9', 889790118.0)
(1, -2147483646, 'sal_9b14c9', 568874850.0)
(1, -2147483644, 'sal_9b14c9', 838855302.0)
(1, -2147483643, 'sal_9b14c9', 747588459.0)
(1, -2147483642, 'sal_9b14c9', 520098126.0)
(1, -2147483641, 'sal_9b14c9', 219150541.0)
(1, -2147483640, 'sal_9b14c9', 236116756.0)
(1, -2147483639, 'sal_9b14c9', 949383523.0)
(1, -2147483637, 'sal_9b14c9', None)
(1, -2147483636, 'sal_9b14c9', None)
(1, -2147483635, 'sal_9b14c9', None)
(1, -2147483633, None, None)
(1, -2147483632, None, None)
(1, -2147483631, None, None)
(1, -2147483630, 'sal_9b14c9', None)
(1, -2147483629, 'sal_9b14c9', None)
(1, -2147483628, 'sal_9b14c9', None)
(1, -2147483627, 'sal_9b14c9', None)
(1, -2147483626, 'sal_9b14c9', None)
(1, -2147483625, 'sal_9b14c9', None)
(1, 1, 's_s_f122f2', 1.0)
*/

-- Prediction Query
WITH A AS (SELECT COMPANY_ID, MAX(SALARY) AS MAX_SALARY FROM SALARIES GROUP BY 1), B AS (SELECT B.COMPANY_ID, EMPLOYEE_ID, EMPLOYEE_NAME, SALARY, MAX_SALARY FROM SALARIES AS B JOIN A ON A.COMPANY_ID = B.COMPANY_ID) SELECT COMPANY_ID, EMPLOYEE_ID, EMPLOYEE_NAME, CASE WHEN MAX_SALARY < 1000 THEN SALARY WHEN MAX_SALARY BETWEEN 1000 AND 10000 THEN ROUND((SALARY - (CAST(24 AS REAL) / 100) * SALARY), 0) WHEN MAX_SALARY > 10000 THEN ROUND((SALARY - (CAST(49 AS REAL) / 100) * SALARY), 0) ELSE 0 END AS SALARY FROM B;

/*
Prediction Result:
(-2147483647, -2147483638, 'sal_9b14c9', 0)
(-2147483646, -2147483634, None, 22925617.0)
(1, -2147483648, 'sal_9b14c9', 125976348.0)
(1, -2147483647, 'sal_9b14c9', 889790118.0)
(1, -2147483646, 'sal_9b14c9', 568874850.0)
(1, -2147483644, 'sal_9b14c9', 838855302.0)
(1, -2147483643, 'sal_9b14c9', 747588459.0)
(1, -2147483642, 'sal_9b14c9', 520098126.0)
(1, -2147483641, 'sal_9b14c9', 219150541.0)
(1, -2147483640, 'sal_9b14c9', 236116756.0)
(1, -2147483639, 'sal_9b14c9', 949383523.0)
(1, -2147483637, 'sal_9b14c9', None)
(1, -2147483636, 'sal_9b14c9', None)
(1, -2147483635, 'sal_9b14c9', None)
(1, -2147483633, None, None)
(1, -2147483632, None, None)
(1, -2147483631, None, None)
(1, -2147483630, 'sal_9b14c9', None)
(1, -2147483629, 'sal_9b14c9', None)
(1, -2147483628, 'sal_9b14c9', None)
(1, -2147483627, 'sal_9b14c9', None)
(1, -2147483626, 'sal_9b14c9', None)
(1, -2147483625, 'sal_9b14c9', None)
(1, 1, 's_s_f122f2', 1.0)
*/