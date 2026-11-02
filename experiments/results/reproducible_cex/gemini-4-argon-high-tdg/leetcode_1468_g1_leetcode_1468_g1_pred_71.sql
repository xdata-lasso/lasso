-- Schema DDL
CREATE TABLE "Salaries" ("company_id" INTEGER, "employee_id" INTEGER, "employee_name" TEXT(255), "salary" INTEGER, PRIMARY KEY ("company_id", "employee_id"), CHECK ("salary" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Salaries (company_id, employee_id, employee_name, salary) VALUES (1, 1, 'Emp_1_1', 999);
INSERT INTO Salaries (company_id, employee_id, employee_name, salary) VALUES (2, 1, 'Emp_2_1', 1000);
INSERT INTO Salaries (company_id, employee_id, employee_name, salary) VALUES (3, 1, 'Emp_3_1', 1001);
INSERT INTO Salaries (company_id, employee_id, employee_name, salary) VALUES (4, 1, 'Emp_4_1', 9999);
INSERT INTO Salaries (company_id, employee_id, employee_name, salary) VALUES (5, 1, 'Emp_5_1', 10000);
INSERT INTO Salaries (company_id, employee_id, employee_name, salary) VALUES (6, 1, 'Emp_6_1', 10001);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT S.COMPANY_ID, S.EMPLOYEE_ID, S.EMPLOYEE_NAME, CASE WHEN MAX_SALARY < 1000 THEN SALARY WHEN MAX_SALARY >= 1000 AND MAX_SALARY <= 10000 THEN ROUND(SALARY - SALARY * 0.24, 0) WHEN MAX_SALARY > 10000 THEN ROUND(SALARY - SALARY * 0.49, 0) END AS SALARY FROM SALARIES AS S JOIN (SELECT COMPANY_ID, MAX(SALARY) AS MAX_SALARY FROM SALARIES GROUP BY COMPANY_ID) AS T ON S.COMPANY_ID = T.COMPANY_ID;

/*
Gold Result:
(1, 1, 'Emp_1_1', 999)
(2, 1, 'Emp_2_1', 760.0)
(3, 1, 'Emp_3_1', 761.0)
(4, 1, 'Emp_4_1', 7599.0)
(5, 1, 'Emp_5_1', 7600.0)
(6, 1, 'Emp_6_1', 5101.0)
*/

-- Prediction Query
WITH T1 AS (SELECT *, MAX(SALARY) OVER (PARTITION BY COMPANY_ID) AS HIGHEST_SALARY FROM SALARIES) SELECT COMPANY_ID, EMPLOYEE_ID, EMPLOYEE_NAME, ROUND(SALARY * TAX_RATE, 0) AS SALARY FROM (SELECT *, CASE WHEN HIGHEST_SALARY < 1000 THEN 1 WHEN HIGHEST_SALARY >= 1000 AND HIGHEST_SALARY < 10000 THEN 0.76 WHEN HIGHEST_SALARY >= 10000 THEN 0.51 END AS TAX_RATE FROM T1) AS SUB;

/*
Prediction Result:
(1, 1, 'Emp_1_1', 999.0)
(2, 1, 'Emp_2_1', 760.0)
(3, 1, 'Emp_3_1', 761.0)
(4, 1, 'Emp_4_1', 7599.0)
(5, 1, 'Emp_5_1', 5100.0)
(6, 1, 'Emp_6_1', 5101.0)
*/