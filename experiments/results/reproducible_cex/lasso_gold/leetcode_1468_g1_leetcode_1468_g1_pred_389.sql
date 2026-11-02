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
SELECT COMPANY_ID, EMPLOYEE_ID, EMPLOYEE_NAME, CASE WHEN MAX(SALARY) OVER (PARTITION BY COMPANY_ID) > 10000 THEN ROUND(SALARY - (SALARY * (CAST(49 AS REAL) / 100)), 0) WHEN MAX(SALARY) OVER (PARTITION BY COMPANY_ID) > 1000 AND MAX(SALARY) OVER (PARTITION BY COMPANY_ID) < 10000 THEN ROUND(SALARY - (SALARY * (CAST(24 AS REAL) / 100)), 0) ELSE SALARY END AS SALARY FROM SALARIES;

/*
Prediction Result:
(1220, 1223, 'Rebecca Valencia', 1000)
(1220, 1224, 'Christine Wright', 1000)
(1220, 1225, 'Richard Henson', 1000)
(1220, 1226, 'Marc Moore', 1000)
(1220, 1227, 'Sharon Cherry', 1000)
(1220, 1228, 'Sierra Johnson', 1000)
*/