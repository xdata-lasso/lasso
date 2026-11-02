-- Schema DDL
CREATE TABLE SALARIES (COMPANY_ID INTEGER, EMPLOYEE_ID INTEGER, EMPLOYEE_NAME TEXT(255), SALARY INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: salaries --
INSERT INTO "salaries" ("company_id", "employee_id", "employee_name", "salary") VALUES (-55602865, -59984348, 'sal_e10d80', 1);

INSERT INTO "salaries" ("company_id", "employee_id", "employee_name", "salary") VALUES (-664303813, -1022641847, 'sal_e10d80', NULL);

INSERT INTO "salaries" ("company_id", "employee_id", "employee_name", "salary") VALUES (-1726781632, 247012447, 'sal_e10d80', 10000);

INSERT INTO "salaries" ("company_id", "employee_id", "employee_name", "salary") VALUES (2, -1980249628, 'sal_e10d80', 0);

INSERT INTO "salaries" ("company_id", "employee_id", "employee_name", "salary") VALUES (3, -734455130, 'sal_e10d80', 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CASE WHEN SALARY BETWEEN 1000 AND 10000 THEN SALARY * 0.76 ELSE SALARY * 0.51 END AS SALARY FROM SALARIES;

/*
Gold Result:
(0.51,)
(None,)
(7600.0,)
(0.0,)
(0.0,)
*/

-- Prediction Query
SELECT CASE WHEN SALARY < 1000 THEN SALARY * 0.51 WHEN SALARY < 10000 THEN SALARY * 0.76 ELSE SALARY * 0.51 END AS SALARY FROM SALARIES;

/*
Prediction Result:
(0.51,)
(None,)
(5100.0,)
(0.0,)
(0.0,)
*/