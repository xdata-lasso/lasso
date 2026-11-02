-- Schema DDL
CREATE TABLE SALARIES (COMPANY_ID INTEGER, EMPLOYEE_ID INTEGER, EMPLOYEE_NAME TEXT(255), SALARY INTEGER, PRIMARY KEY (COMPANY_ID, EMPLOYEE_ID));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: salaries --
INSERT INTO "salaries" ("company_id", "employee_id", "employee_name", "salary") VALUES (1, -2147483648, 'sal_e10d80', -55602865);

INSERT INTO "salaries" ("company_id", "employee_id", "employee_name", "salary") VALUES (1, -2147483647, 'sal_e10d80', -59984348);

INSERT INTO "salaries" ("company_id", "employee_id", "employee_name", "salary") VALUES (1, -2147483646, 'sal_e10d80', -664303813);

INSERT INTO "salaries" ("company_id", "employee_id", "employee_name", "salary") VALUES (1, 1, 's_s_453042', 1);

INSERT INTO "salaries" ("company_id", "employee_id", "employee_name", "salary") VALUES (1, -2147483644, 'sal_e10d80', -1022641847);

INSERT INTO "salaries" ("company_id", "employee_id", "employee_name", "salary") VALUES (1, -2147483643, 'sal_e10d80', -1726781632);

INSERT INTO "salaries" ("company_id", "employee_id", "employee_name", "salary") VALUES (1, -2147483642, 'sal_e10d80', 247012447);

INSERT INTO "salaries" ("company_id", "employee_id", "employee_name", "salary") VALUES (1, -2147483641, 'sal_e10d80', -1980249628);

INSERT INTO "salaries" ("company_id", "employee_id", "employee_name", "salary") VALUES (1, -2147483640, 'sal_e10d80', -734455130);

INSERT INTO "salaries" ("company_id", "employee_id", "employee_name", "salary") VALUES (1, -2147483639, 'sal_e10d80', 1744686505);

INSERT INTO "salaries" ("company_id", "employee_id", "employee_name", "salary") VALUES (-2147483647, -2147483638, NULL, -1633151678);

INSERT INTO "salaries" ("company_id", "employee_id", "employee_name", "salary") VALUES (1, -2147483637, NULL, NULL);

INSERT INTO "salaries" ("company_id", "employee_id", "employee_name", "salary") VALUES (1, -2147483636, NULL, NULL);

INSERT INTO "salaries" ("company_id", "employee_id", "employee_name", "salary") VALUES (1, -2147483635, NULL, NULL);

INSERT INTO "salaries" ("company_id", "employee_id", "employee_name", "salary") VALUES (-2147483646, -2147483634, 'sal_e10d80', NULL);

INSERT INTO "salaries" ("company_id", "employee_id", "employee_name", "salary") VALUES (1, -2147483633, 'sal_e10d80', NULL);

INSERT INTO "salaries" ("company_id", "employee_id", "employee_name", "salary") VALUES (1, -2147483632, 'sal_e10d80', NULL);

INSERT INTO "salaries" ("company_id", "employee_id", "employee_name", "salary") VALUES (1, -2147483631, 'sal_e10d80', NULL);

INSERT INTO "salaries" ("company_id", "employee_id", "employee_name", "salary") VALUES (1, -2147483630, 'sal_e10d80', NULL);

INSERT INTO "salaries" ("company_id", "employee_id", "employee_name", "salary") VALUES (1, -2147483629, 'sal_e10d80', NULL);

INSERT INTO "salaries" ("company_id", "employee_id", "employee_name", "salary") VALUES (1, -2147483628, 'sal_e10d80', NULL);

INSERT INTO "salaries" ("company_id", "employee_id", "employee_name", "salary") VALUES (1, -2147483627, 'sal_e10d80', NULL);

INSERT INTO "salaries" ("company_id", "employee_id", "employee_name", "salary") VALUES (1, -2147483626, 'sal_e10d80', NULL);

INSERT INTO "salaries" ("company_id", "employee_id", "employee_name", "salary") VALUES (1, -2147483625, 'sal_e10d80', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT S.COMPANY_ID, S.EMPLOYEE_ID, S.EMPLOYEE_NAME, ROUND(CASE WHEN X.MAX_SAL BETWEEN 1000 AND 10000 THEN SALARY * 0.76 WHEN X.MAX_SAL > 10000 THEN SALARY * 0.51 ELSE SALARY END, 0) AS SALARY FROM SALARIES AS S INNER JOIN (SELECT COMPANY_ID, MAX(SALARY) AS MAX_SAL FROM SALARIES GROUP BY COMPANY_ID) AS X ON S.COMPANY_ID = X.COMPANY_ID;

/*
Gold Result:
(-2147483647, -2147483638, None, -1633151678.0)
(-2147483646, -2147483634, 'sal_e10d80', None)
(1, -2147483648, 'sal_e10d80', -28357461.0)
(1, -2147483647, 'sal_e10d80', -30592017.0)
(1, -2147483646, 'sal_e10d80', -338794945.0)
(1, -2147483644, 'sal_e10d80', -521547342.0)
(1, -2147483643, 'sal_e10d80', -880658632.0)
(1, -2147483642, 'sal_e10d80', 125976348.0)
(1, -2147483641, 'sal_e10d80', -1009927310.0)
(1, -2147483640, 'sal_e10d80', -374572116.0)
(1, -2147483639, 'sal_e10d80', 889790118.0)
(1, -2147483637, None, None)
(1, -2147483636, None, None)
(1, -2147483635, None, None)
(1, -2147483633, 'sal_e10d80', None)
(1, -2147483632, 'sal_e10d80', None)
(1, -2147483631, 'sal_e10d80', None)
(1, -2147483630, 'sal_e10d80', None)
(1, -2147483629, 'sal_e10d80', None)
(1, -2147483628, 'sal_e10d80', None)
(1, -2147483627, 'sal_e10d80', None)
(1, -2147483626, 'sal_e10d80', None)
(1, -2147483625, 'sal_e10d80', None)
(1, 1, 's_s_453042', 1.0)
*/

-- Prediction Query
WITH CT_TAX AS (SELECT CASE WHEN MAX(SALARY) < 1000 THEN 0 WHEN MAX(SALARY) < 10000 THEN 24 ELSE 49 END AS TAX_RATE, COMPANY_ID FROM SALARIES GROUP BY COMPANY_ID) SELECT S.COMPANY_ID, S.EMPLOYEE_ID, S.EMPLOYEE_NAME, ROUND((S.SALARY - (S.SALARY * C.TAX_RATE / 100))) AS SALARY FROM SALARIES AS S CROSS JOIN CT_TAX AS C WHERE S.COMPANY_ID = C.COMPANY_ID;

/*
Prediction Result:
(1, -2147483648, 'sal_e10d80', -28357462.0)
(1, -2147483647, 'sal_e10d80', -30592018.0)
(1, -2147483646, 'sal_e10d80', -338794945.0)
(1, 1, 's_s_453042', 1.0)
(1, -2147483644, 'sal_e10d80', -521547342.0)
(1, -2147483643, 'sal_e10d80', -880658633.0)
(1, -2147483642, 'sal_e10d80', 125976348.0)
(1, -2147483641, 'sal_e10d80', -1009927311.0)
(1, -2147483640, 'sal_e10d80', -374572117.0)
(1, -2147483639, 'sal_e10d80', 889790118.0)
(-2147483647, -2147483638, None, -1633151678.0)
(1, -2147483637, None, None)
(1, -2147483636, None, None)
(1, -2147483635, None, None)
(-2147483646, -2147483634, 'sal_e10d80', None)
(1, -2147483633, 'sal_e10d80', None)
(1, -2147483632, 'sal_e10d80', None)
(1, -2147483631, 'sal_e10d80', None)
(1, -2147483630, 'sal_e10d80', None)
(1, -2147483629, 'sal_e10d80', None)
(1, -2147483628, 'sal_e10d80', None)
(1, -2147483627, 'sal_e10d80', None)
(1, -2147483626, 'sal_e10d80', None)
(1, -2147483625, 'sal_e10d80', None)
*/