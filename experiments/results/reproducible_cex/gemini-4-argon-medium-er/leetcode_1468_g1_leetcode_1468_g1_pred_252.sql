-- Schema DDL
CREATE TABLE "Salaries" ("company_id" INTEGER, "employee_id" INTEGER, "employee_name" TEXT(255), "salary" INTEGER, PRIMARY KEY ("company_id", "employee_id"), CHECK ("salary" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Salaries" ("company_id", "employee_id", "employee_name", "salary") VALUES (NULL, 1, 'Alice', 500);
INSERT INTO "Salaries" ("company_id", "employee_id", "employee_name", "salary") VALUES (1, 1, 'Bob', 500);
INSERT INTO "Salaries" ("company_id", "employee_id", "employee_name", "salary") VALUES (2, 1, 'Charlie', 20000);
INSERT INTO "Salaries" ("company_id", "employee_id", "employee_name", "salary") VALUES (2, 2, 'David', 150);
INSERT INTO "Salaries" ("company_id", "employee_id", "employee_name", "salary") VALUES (2, 3, 'Eve', 250);
INSERT INTO "Salaries" ("company_id", "employee_id", "employee_name", "salary") VALUES (2, 4, 'Frank', 350);
INSERT INTO "Salaries" ("company_id", "employee_id", "employee_name", "salary") VALUES (2, 5, 'Grace', 450);
INSERT INTO "Salaries" ("company_id", "employee_id", "employee_name", "salary") VALUES (2, 6, 'Heidi', 550);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT S.COMPANY_ID, S.EMPLOYEE_ID, S.EMPLOYEE_NAME, CASE WHEN MAX_SALARY < 1000 THEN SALARY WHEN MAX_SALARY >= 1000 AND MAX_SALARY <= 10000 THEN ROUND(SALARY - SALARY * 0.24, 0) WHEN MAX_SALARY > 10000 THEN ROUND(SALARY - SALARY * 0.49, 0) END AS SALARY FROM SALARIES AS S JOIN (SELECT COMPANY_ID, MAX(SALARY) AS MAX_SALARY FROM SALARIES GROUP BY COMPANY_ID) AS T ON S.COMPANY_ID = T.COMPANY_ID;

/*
Gold Result:
(1, 1, 'Bob', 500)
(2, 1, 'Charlie', 10200.0)
(2, 2, 'David', 77.0)
(2, 3, 'Eve', 128.0)
(2, 4, 'Frank', 179.0)
(2, 5, 'Grace', 230.0)
(2, 6, 'Heidi', 281.0)
*/

-- Prediction Query
WITH MAX_SALARIES AS (SELECT COMPANY_ID, MAX(SALARY) AS MAX_SALARY FROM SALARIES GROUP BY COMPANY_ID) SELECT S.COMPANY_ID, S.EMPLOYEE_ID, S.EMPLOYEE_NAME, ROUND(CASE WHEN MS.MAX_SALARY < 1000 THEN S.SALARY WHEN MS.MAX_SALARY > 10000 THEN S.SALARY * 0.51 ELSE S.SALARY * 0.76 END) AS SALARY FROM SALARIES AS S LEFT JOIN MAX_SALARIES AS MS ON S.COMPANY_ID = MS.COMPANY_ID;

/*
Prediction Result:
(None, 1, 'Alice', 380.0)
(1, 1, 'Bob', 500.0)
(2, 1, 'Charlie', 10200.0)
(2, 2, 'David', 77.0)
(2, 3, 'Eve', 128.0)
(2, 4, 'Frank', 179.0)
(2, 5, 'Grace', 230.0)
(2, 6, 'Heidi', 281.0)
*/