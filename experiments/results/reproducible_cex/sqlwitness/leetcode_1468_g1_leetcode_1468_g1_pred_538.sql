-- Schema DDL
CREATE TABLE "Salaries" ("company_id" INTEGER, "employee_id" INTEGER, "employee_name" TEXT(255), "salary" INTEGER, PRIMARY KEY ("company_id", "employee_id"), CHECK ("salary" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO salaries (company_id, employee_id, employee_name, salary) VALUES (1, 25, 'default2', 49), (9999, 49, 'default2', NULL), (1000, 49, 'default2', 1000), (1, 9999, 'default2', NULL), (1, 10000, 'default1', 1000), (50, 10000, 'default1', NULL), (9999, 23, 'default1', 24), (25, 24, NULL, 1001), (-1, 48, 'default1', 50), (10001, 9999, 'default2', 25), (999, 49, 'default1', 49);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT S.COMPANY_ID, S.EMPLOYEE_ID, S.EMPLOYEE_NAME, CASE WHEN MAX_SALARY < 1000 THEN SALARY WHEN MAX_SALARY >= 1000 AND MAX_SALARY <= 10000 THEN ROUND(SALARY - SALARY * 0.24, 0) WHEN MAX_SALARY > 10000 THEN ROUND(SALARY - SALARY * 0.49, 0) END AS SALARY FROM SALARIES AS S JOIN (SELECT COMPANY_ID, MAX(SALARY) AS MAX_SALARY FROM SALARIES GROUP BY COMPANY_ID) AS T ON S.COMPANY_ID = T.COMPANY_ID;

/*
Gold Result:
(-1, 48, 'default1', 50)
(1, 25, 'default2', 37.0)
(1, 9999, 'default2', None)
(1, 10000, 'default1', 760.0)
(25, 24, None, 761.0)
(50, 10000, 'default1', None)
(999, 49, 'default1', 49)
(1000, 49, 'default2', 760.0)
(9999, 23, 'default1', 24)
(9999, 49, 'default2', None)
(10001, 9999, 'default2', 25)
*/

-- Prediction Query
SELECT X.COMPANY_ID, X.EMPLOYEE_ID, X.EMPLOYEE_NAME, ROUND(X.SALARY - 0.01 * X.PCT * X.SALARY) AS SALARY FROM (SELECT A.*, CASE WHEN B.MAXIMUM <= 1000 THEN 0 WHEN B.MAXIMUM <= 10000 THEN 24 ELSE 49 END AS PCT FROM SALARIES AS A JOIN (SELECT COMPANY_ID, MAX(SALARY) AS MAXIMUM FROM SALARIES GROUP BY COMPANY_ID) AS B ON A.COMPANY_ID = B.COMPANY_ID) AS X;

/*
Prediction Result:
(-1, 48, 'default1', 50.0)
(1, 25, 'default2', 49.0)
(1, 9999, 'default2', None)
(1, 10000, 'default1', 1000.0)
(25, 24, None, 761.0)
(50, 10000, 'default1', None)
(999, 49, 'default1', 49.0)
(1000, 49, 'default2', 1000.0)
(9999, 23, 'default1', 24.0)
(9999, 49, 'default2', None)
(10001, 9999, 'default2', 25.0)
*/