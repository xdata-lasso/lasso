-- Schema DDL
CREATE TABLE "Salaries" ("company_id" INTEGER, "employee_id" INTEGER, "employee_name" TEXT(255), "salary" INTEGER, PRIMARY KEY ("company_id", "employee_id"), CHECK ("salary" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "salaries" ("company_id", "employee_id", "employee_name", "salary") VALUES (1220, 1223, 'Rebecca Valencia', 1000);
INSERT INTO "salaries" ("company_id", "employee_id", "employee_name", "salary") VALUES (1220, 1224, 'Christine Wright', 1000);
INSERT INTO "salaries" ("company_id", "employee_id", "employee_name", "salary") VALUES (1220, 1225, 'Richard Henson', 1000);
INSERT INTO "salaries" ("company_id", "employee_id", "employee_name", "salary") VALUES (1220, 1226, 'Marc Moore', 1000);
INSERT INTO "salaries" ("company_id", "employee_id", "employee_name", "salary") VALUES (1220, 1227, 'Sharon Cherry', 1000);
INSERT INTO "salaries" ("company_id", "employee_id", "employee_name", "salary") VALUES (1220, 1228, 'Sierra Johnson', 1000);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT S.COMPANY_ID, S.EMPLOYEE_ID, S.EMPLOYEE_NAME, CASE WHEN MAX_SALARY < 1000 THEN SALARY WHEN MAX_SALARY >= 1000 AND MAX_SALARY <= 10000 THEN ROUND(SALARY - SALARY * 0.24, 0) WHEN MAX_SALARY > 10000 THEN ROUND(SALARY - SALARY * 0.49, 0) END AS SALARY FROM SALARIES AS S JOIN (SELECT COMPANY_ID, MAX(SALARY) AS MAX_SALARY FROM SALARIES GROUP BY COMPANY_ID) AS T ON S.COMPANY_ID = T.COMPANY_ID;

/*
Gold Result:
(1220, 1223, 'Rebecca Valencia', 760.0)
(1220, 1224, 'Christine Wright', 760.0)
(1220, 1225, 'Richard Henson', 760.0)
(1220, 1226, 'Marc Moore', 760.0)
(1220, 1227, 'Sharon Cherry', 760.0)
(1220, 1228, 'Sierra Johnson', 760.0)
*/

-- Prediction Query
WITH MAXSAL(COMPANY_ID, MSALARY) AS (SELECT COMPANY_ID, MAX(SALARY) FROM SALARIES GROUP BY COMPANY_ID) SELECT COMPANY_ID, EMPLOYEE_ID, EMPLOYEE_NAME, CASE WHEN MSALARY > 1000 AND MSALARY < 10000 THEN ROUND(CAST((SALARY * 76) AS REAL) / 100) WHEN MSALARY > 10000 THEN ROUND(CAST((SALARY * 51) AS REAL) / 100) ELSE SALARY END AS SALARY FROM (SELECT SALARIES.COMPANY_ID, SALARIES.EMPLOYEE_ID, SALARIES.EMPLOYEE_NAME, SALARIES.SALARY, MAXSAL.MSALARY FROM SALARIES CROSS JOIN MAXSAL WHERE MAXSAL.COMPANY_ID = SALARIES.COMPANY_ID) AS T;

/*
Prediction Result:
(1220, 1223, 'Rebecca Valencia', 1000)
(1220, 1224, 'Christine Wright', 1000)
(1220, 1225, 'Richard Henson', 1000)
(1220, 1226, 'Marc Moore', 1000)
(1220, 1227, 'Sharon Cherry', 1000)
(1220, 1228, 'Sierra Johnson', 1000)
*/