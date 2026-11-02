-- Schema DDL
CREATE TABLE "Salaries" ("company_id" INTEGER, "employee_id" INTEGER, "employee_name" TEXT(255), "salary" INTEGER, PRIMARY KEY ("company_id", "employee_id"), CHECK ("salary" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO Salaries (company_id, employee_id, employee_name, salary) VALUES (10, 1, 'Bound_999_Max', 999);
INSERT INTO Salaries (company_id, employee_id, employee_name, salary) VALUES (10, 2, 'Bound_999_Sub', 500);
INSERT INTO Salaries (company_id, employee_id, employee_name, salary) VALUES (20, 1, 'Bound_1000_Max', 1000);
INSERT INTO Salaries (company_id, employee_id, employee_name, salary) VALUES (20, 2, 'Bound_1000_Sub', 500);
INSERT INTO Salaries (company_id, employee_id, employee_name, salary) VALUES (30, 1, 'Bound_1001_Max', 1001);
INSERT INTO Salaries (company_id, employee_id, employee_name, salary) VALUES (30, 2, 'Bound_1001_Sub', 500);
INSERT INTO Salaries (company_id, employee_id, employee_name, salary) VALUES (40, 1, 'Bound_9999_Max', 9999);
INSERT INTO Salaries (company_id, employee_id, employee_name, salary) VALUES (40, 2, 'Bound_9999_Sub', 500);
INSERT INTO Salaries (company_id, employee_id, employee_name, salary) VALUES (50, 1, 'Bound_10000_Max', 10000);
INSERT INTO Salaries (company_id, employee_id, employee_name, salary) VALUES (50, 2, 'Bound_10000_Sub', 500);
INSERT INTO Salaries (company_id, employee_id, employee_name, salary) VALUES (60, 1, 'Bound_10001_Max', 10001);
INSERT INTO Salaries (company_id, employee_id, employee_name, salary) VALUES (60, 2, 'Bound_10001_Sub', 500);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT S.COMPANY_ID, S.EMPLOYEE_ID, S.EMPLOYEE_NAME, ROUND(CASE WHEN X.MAX_SAL BETWEEN 1000 AND 10000 THEN SALARY * 0.76 WHEN X.MAX_SAL > 10000 THEN SALARY * 0.51 ELSE SALARY END, 0) AS SALARY FROM SALARIES AS S INNER JOIN (SELECT COMPANY_ID, MAX(SALARY) AS MAX_SAL FROM SALARIES GROUP BY COMPANY_ID) AS X ON S.COMPANY_ID = X.COMPANY_ID;

/*
Gold Result:
(10, 1, 'Bound_999_Max', 999.0)
(10, 2, 'Bound_999_Sub', 500.0)
(20, 1, 'Bound_1000_Max', 760.0)
(20, 2, 'Bound_1000_Sub', 380.0)
(30, 1, 'Bound_1001_Max', 761.0)
(30, 2, 'Bound_1001_Sub', 380.0)
(40, 1, 'Bound_9999_Max', 7599.0)
(40, 2, 'Bound_9999_Sub', 380.0)
(50, 1, 'Bound_10000_Max', 7600.0)
(50, 2, 'Bound_10000_Sub', 380.0)
(60, 1, 'Bound_10001_Max', 5101.0)
(60, 2, 'Bound_10001_Sub', 255.0)
*/

-- Prediction Query
WITH T1 AS (SELECT *, MAX(SALARY) OVER (PARTITION BY COMPANY_ID ORDER BY COMPANY_ID) AS MX FROM SALARIES) SELECT COMPANY_ID, EMPLOYEE_ID, EMPLOYEE_NAME, ROUND(CASE WHEN MX < 1000 THEN SALARY WHEN MX BETWEEN 1000 AND 9999 THEN SALARY - (SALARY * 0.24) WHEN MX > 10000 THEN SALARY - (SALARY * 0.49) END) AS SALARY FROM T1 ORDER BY 1, 2, COMPANY_ID NULLS LAST, EMPLOYEE_ID NULLS LAST, EMPLOYEE_NAME NULLS LAST, SALARY NULLS LAST;

/*
Prediction Result:
(10, 1, 'Bound_999_Max', 999.0)
(10, 2, 'Bound_999_Sub', 500.0)
(20, 1, 'Bound_1000_Max', 760.0)
(20, 2, 'Bound_1000_Sub', 380.0)
(30, 1, 'Bound_1001_Max', 761.0)
(30, 2, 'Bound_1001_Sub', 380.0)
(40, 1, 'Bound_9999_Max', 7599.0)
(40, 2, 'Bound_9999_Sub', 380.0)
(50, 1, 'Bound_10000_Max', None)
(50, 2, 'Bound_10000_Sub', None)
(60, 1, 'Bound_10001_Max', 5101.0)
(60, 2, 'Bound_10001_Sub', 255.0)
*/