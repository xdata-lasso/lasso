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
SELECT S.COMPANY_ID, S.EMPLOYEE_ID, S.EMPLOYEE_NAME, CAST(S.SALARY - (CASE WHEN CM.COMP_MAX < 1000 THEN 0 WHEN CM.COMP_MAX <= 10000 AND CM.COMP_MAX >= 1000 THEN 0.24 ELSE 0.49 END) * S.SALARY AS INTEGER) AS SALARY FROM SALARIES AS S LEFT JOIN (SELECT COMPANY_ID, MAX(SALARY) AS COMP_MAX FROM SALARIES GROUP BY COMPANY_ID) AS CM ON S.COMPANY_ID = CM.COMPANY_ID;

/*
Prediction Result:
(1, 1, 'Emp_1_1', 999)
(2, 1, 'Emp_2_1', 760)
(3, 1, 'Emp_3_1', 760)
(4, 1, 'Emp_4_1', 7599)
(5, 1, 'Emp_5_1', 7600)
(6, 1, 'Emp_6_1', 5100)
*/