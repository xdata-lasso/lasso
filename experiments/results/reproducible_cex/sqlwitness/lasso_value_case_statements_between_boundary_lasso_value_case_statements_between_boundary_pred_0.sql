-- Schema DDL
CREATE TABLE SALARIES (COMPANY_ID INTEGER, EMPLOYEE_ID INTEGER, EMPLOYEE_NAME TEXT(255), SALARY INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO salaries (company_id, employee_id, employee_name, salary) VALUES (1000, NULL, NULL, 999), (1, 1, 'default1', 1), (0, 1, NULL, 0), (1001, 10001, 'default2', 10000);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CASE WHEN SALARY BETWEEN 1000 AND 10000 THEN SALARY * 0.76 ELSE SALARY * 0.51 END AS SALARY FROM SALARIES;

/*
Gold Result:
(509.49,)
(0.51,)
(0.0,)
(7600.0,)
*/

-- Prediction Query
SELECT CASE WHEN SALARY < 1000 THEN SALARY * 0.51 WHEN SALARY < 10000 THEN SALARY * 0.76 ELSE SALARY * 0.51 END AS SALARY FROM SALARIES;

/*
Prediction Result:
(509.49,)
(0.51,)
(0.0,)
(5100.0,)
*/