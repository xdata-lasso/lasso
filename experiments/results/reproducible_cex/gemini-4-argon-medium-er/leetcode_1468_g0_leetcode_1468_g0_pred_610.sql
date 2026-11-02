-- Schema DDL
CREATE TABLE "Salaries" ("company_id" INTEGER, "employee_id" INTEGER, "employee_name" TEXT(255), "salary" INTEGER, PRIMARY KEY ("company_id", "employee_id"), CHECK ("salary" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Salaries" ("company_id", "employee_id", "employee_name", "salary") VALUES (NULL, 1, 'Alice', 500);
INSERT INTO "Salaries" ("company_id", "employee_id", "employee_name", "salary") VALUES (1, 1, 'Bob', 20000);
INSERT INTO "Salaries" ("company_id", "employee_id", "employee_name", "salary") VALUES (1, 2, 'Charlie', 150);
INSERT INTO "Salaries" ("company_id", "employee_id", "employee_name", "salary") VALUES (1, 3, 'David', 350);
INSERT INTO "Salaries" ("company_id", "employee_id", "employee_name", "salary") VALUES (1, 4, 'Eve', 550);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT S.COMPANY_ID, S.EMPLOYEE_ID, S.EMPLOYEE_NAME, ROUND(CASE WHEN X.MAX_SAL BETWEEN 1000 AND 10000 THEN SALARY * 0.76 WHEN X.MAX_SAL > 10000 THEN SALARY * 0.51 ELSE SALARY END, 0) AS SALARY FROM SALARIES AS S INNER JOIN (SELECT COMPANY_ID, MAX(SALARY) AS MAX_SAL FROM SALARIES GROUP BY COMPANY_ID) AS X ON S.COMPANY_ID = X.COMPANY_ID;

/*
Gold Result:
(1, 1, 'Bob', 10200.0)
(1, 2, 'Charlie', 77.0)
(1, 3, 'David', 179.0)
(1, 4, 'Eve', 281.0)
*/

-- Prediction Query
SELECT S.COMPANY_ID, S.EMPLOYEE_ID, S.EMPLOYEE_NAME, ROUND((CASE WHEN C.M < 1000 THEN S.SALARY WHEN C.M >= 1000 AND C.M <= 10000 THEN S.SALARY - (S.SALARY * 0.24) WHEN C.M > 10000 THEN S.SALARY - (S.SALARY * 0.49) END)) AS SALARY FROM SALARIES AS S LEFT JOIN (SELECT MAX(SALARY) AS M, COMPANY_ID FROM SALARIES GROUP BY 2) AS C ON S.COMPANY_ID = C.COMPANY_ID;

/*
Prediction Result:
(None, 1, 'Alice', None)
(1, 1, 'Bob', 10200.0)
(1, 2, 'Charlie', 77.0)
(1, 3, 'David', 179.0)
(1, 4, 'Eve', 281.0)
*/