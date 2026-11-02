-- Schema DDL
CREATE TABLE "Salaries" ("company_id" INTEGER, "employee_id" INTEGER, "employee_name" TEXT(255), "salary" INTEGER, PRIMARY KEY ("company_id", "employee_id"), CHECK ("salary" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: salaries --
INSERT INTO "salaries" ("company_id", "employee_id", "employee_name", "salary") VALUES (1, -2147483648, 'sal_9b14c9', 247012447);

INSERT INTO "salaries" ("company_id", "employee_id", "employee_name", "salary") VALUES (1, -2147483647, 'sal_9b14c9', 1744686505);

INSERT INTO "salaries" ("company_id", "employee_id", "employee_name", "salary") VALUES (1, -2147483646, 'sal_9b14c9', 1115440883);

INSERT INTO "salaries" ("company_id", "employee_id", "employee_name", "salary") VALUES (1, 1, 's_s_42b915', 1);

INSERT INTO "salaries" ("company_id", "employee_id", "employee_name", "salary") VALUES (1, -2147483644, 'sal_9b14c9', 1644814318);

INSERT INTO "salaries" ("company_id", "employee_id", "employee_name", "salary") VALUES (1, -2147483643, 'sal_9b14c9', 1465859724);

INSERT INTO "salaries" ("company_id", "employee_id", "employee_name", "salary") VALUES (1, -2147483642, 'sal_9b14c9', 1019800248);

INSERT INTO "salaries" ("company_id", "employee_id", "employee_name", "salary") VALUES (1, -2147483641, 'sal_9b14c9', 429706943);

INSERT INTO "salaries" ("company_id", "employee_id", "employee_name", "salary") VALUES (1, -2147483640, 'sal_9b14c9', 462974032);

INSERT INTO "salaries" ("company_id", "employee_id", "employee_name", "salary") VALUES (1, -2147483639, 'sal_9b14c9', 1861536320);

INSERT INTO "salaries" ("company_id", "employee_id", "employee_name", "salary") VALUES (-2147483647, -2147483638, NULL, 44952191);

INSERT INTO "salaries" ("company_id", "employee_id", "employee_name", "salary") VALUES (1, -2147483637, NULL, NULL);

INSERT INTO "salaries" ("company_id", "employee_id", "employee_name", "salary") VALUES (1, -2147483636, NULL, NULL);

INSERT INTO "salaries" ("company_id", "employee_id", "employee_name", "salary") VALUES (1, -2147483635, NULL, NULL);

INSERT INTO "salaries" ("company_id", "employee_id", "employee_name", "salary") VALUES (-2147483646, -2147483634, 'sal_9b14c9', NULL);

INSERT INTO "salaries" ("company_id", "employee_id", "employee_name", "salary") VALUES (1, -2147483633, 'sal_9b14c9', NULL);

INSERT INTO "salaries" ("company_id", "employee_id", "employee_name", "salary") VALUES (1, -2147483632, 'sal_9b14c9', NULL);

INSERT INTO "salaries" ("company_id", "employee_id", "employee_name", "salary") VALUES (1, -2147483631, 'sal_9b14c9', NULL);

INSERT INTO "salaries" ("company_id", "employee_id", "employee_name", "salary") VALUES (1, -2147483630, 'sal_9b14c9', NULL);

INSERT INTO "salaries" ("company_id", "employee_id", "employee_name", "salary") VALUES (1, -2147483629, 'sal_9b14c9', NULL);

INSERT INTO "salaries" ("company_id", "employee_id", "employee_name", "salary") VALUES (1, -2147483628, 'sal_9b14c9', NULL);

INSERT INTO "salaries" ("company_id", "employee_id", "employee_name", "salary") VALUES (1, -2147483627, 'sal_9b14c9', NULL);

INSERT INTO "salaries" ("company_id", "employee_id", "employee_name", "salary") VALUES (1, -2147483626, 'sal_9b14c9', NULL);

INSERT INTO "salaries" ("company_id", "employee_id", "employee_name", "salary") VALUES (1, -2147483625, 'sal_9b14c9', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT S.COMPANY_ID, S.EMPLOYEE_ID, S.EMPLOYEE_NAME, CASE WHEN MAX_SALARY < 1000 THEN SALARY WHEN MAX_SALARY >= 1000 AND MAX_SALARY <= 10000 THEN ROUND(SALARY - SALARY * 0.24, 0) WHEN MAX_SALARY > 10000 THEN ROUND(SALARY - SALARY * 0.49, 0) END AS SALARY FROM SALARIES AS S JOIN (SELECT COMPANY_ID, MAX(SALARY) AS MAX_SALARY FROM SALARIES GROUP BY COMPANY_ID) AS T ON S.COMPANY_ID = T.COMPANY_ID;

/*
Gold Result:
(-2147483647, -2147483638, None, 22925617.0)
(-2147483646, -2147483634, 'sal_9b14c9', None)
(1, -2147483648, 'sal_9b14c9', 125976348.0)
(1, -2147483647, 'sal_9b14c9', 889790118.0)
(1, -2147483646, 'sal_9b14c9', 568874850.0)
(1, -2147483644, 'sal_9b14c9', 838855302.0)
(1, -2147483643, 'sal_9b14c9', 747588459.0)
(1, -2147483642, 'sal_9b14c9', 520098126.0)
(1, -2147483641, 'sal_9b14c9', 219150541.0)
(1, -2147483640, 'sal_9b14c9', 236116756.0)
(1, -2147483639, 'sal_9b14c9', 949383523.0)
(1, -2147483637, None, None)
(1, -2147483636, None, None)
(1, -2147483635, None, None)
(1, -2147483633, 'sal_9b14c9', None)
(1, -2147483632, 'sal_9b14c9', None)
(1, -2147483631, 'sal_9b14c9', None)
(1, -2147483630, 'sal_9b14c9', None)
(1, -2147483629, 'sal_9b14c9', None)
(1, -2147483628, 'sal_9b14c9', None)
(1, -2147483627, 'sal_9b14c9', None)
(1, -2147483626, 'sal_9b14c9', None)
(1, -2147483625, 'sal_9b14c9', None)
(1, 1, 's_s_42b915', 1.0)
*/

-- Prediction Query
WITH MAXES AS (SELECT COMPANY_ID, MAX(SALARY) AS MAX_SALARY FROM SALARIES GROUP BY COMPANY_ID) SELECT SALARIES.COMPANY_ID, EMPLOYEE_ID, EMPLOYEE_NAME, CASE WHEN MAX_SALARY > 10000 THEN CAST(SALARY - (SALARY * 0.49) AS UBIGINT) WHEN MAX_SALARY >= 1000 AND MAX_SALARY <= 10000 THEN CAST(SALARY - (SALARY * 0.24) AS UBIGINT) ELSE SALARY END AS SALARY FROM SALARIES INNER JOIN MAXES ON SALARIES.COMPANY_ID = MAXES.COMPANY_ID;

/*
Prediction Result:
(-2147483647, -2147483638, None, 22925617)
(-2147483646, -2147483634, 'sal_9b14c9', None)
(1, -2147483648, 'sal_9b14c9', 125976347)
(1, -2147483647, 'sal_9b14c9', 889790117)
(1, -2147483646, 'sal_9b14c9', 568874850)
(1, -2147483644, 'sal_9b14c9', 838855302)
(1, -2147483643, 'sal_9b14c9', 747588459)
(1, -2147483642, 'sal_9b14c9', 520098126)
(1, -2147483641, 'sal_9b14c9', 219150540)
(1, -2147483640, 'sal_9b14c9', 236116756)
(1, -2147483639, 'sal_9b14c9', 949383523)
(1, -2147483637, None, None)
(1, -2147483636, None, None)
(1, -2147483635, None, None)
(1, -2147483633, 'sal_9b14c9', None)
(1, -2147483632, 'sal_9b14c9', None)
(1, -2147483631, 'sal_9b14c9', None)
(1, -2147483630, 'sal_9b14c9', None)
(1, -2147483629, 'sal_9b14c9', None)
(1, -2147483628, 'sal_9b14c9', None)
(1, -2147483627, 'sal_9b14c9', None)
(1, -2147483626, 'sal_9b14c9', None)
(1, -2147483625, 'sal_9b14c9', None)
(1, 1, 's_s_42b915', 0)
*/