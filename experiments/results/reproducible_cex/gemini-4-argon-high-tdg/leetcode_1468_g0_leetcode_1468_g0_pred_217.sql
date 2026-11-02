-- Schema DDL
CREATE TABLE "Salaries" ("company_id" INTEGER, "employee_id" INTEGER, "employee_name" TEXT(255), "salary" INTEGER, PRIMARY KEY ("company_id", "employee_id"), CHECK ("salary" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Salaries (company_id, employee_id, employee_name, salary) VALUES (1, 1, 'Tony', 2000);
INSERT INTO Salaries (company_id, employee_id, employee_name, salary) VALUES (1, 2, 'Pronub', 21300);
INSERT INTO Salaries (company_id, employee_id, employee_name, salary) VALUES (1, 3, 'Tyrrox', 10800);
INSERT INTO Salaries (company_id, employee_id, employee_name, salary) VALUES (1, 4, 'LowSalHighComp', 500);
INSERT INTO Salaries (company_id, employee_id, employee_name, salary) VALUES (2, 1, 'Pam', 300);
INSERT INTO Salaries (company_id, employee_id, employee_name, salary) VALUES (2, 7, 'Bassem', 450);
INSERT INTO Salaries (company_id, employee_id, employee_name, salary) VALUES (2, 9, 'Hermione', 700);
INSERT INTO Salaries (company_id, employee_id, employee_name, salary) VALUES (3, 7, 'Bocaben', 100);
INSERT INTO Salaries (company_id, employee_id, employee_name, salary) VALUES (3, 2, 'Ognjen', 2200);
INSERT INTO Salaries (company_id, employee_id, employee_name, salary) VALUES (3, 13, 'Nyancat', 3300);
INSERT INTO Salaries (company_id, employee_id, employee_name, salary) VALUES (3, 15, 'Morninngcat', 7777);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT S.COMPANY_ID, S.EMPLOYEE_ID, S.EMPLOYEE_NAME, ROUND(CASE WHEN X.MAX_SAL BETWEEN 1000 AND 10000 THEN SALARY * 0.76 WHEN X.MAX_SAL > 10000 THEN SALARY * 0.51 ELSE SALARY END, 0) AS SALARY FROM SALARIES AS S INNER JOIN (SELECT COMPANY_ID, MAX(SALARY) AS MAX_SAL FROM SALARIES GROUP BY COMPANY_ID) AS X ON S.COMPANY_ID = X.COMPANY_ID;

/*
Gold Result:
(1, 1, 'Tony', 1020.0)
(1, 2, 'Pronub', 10863.0)
(1, 3, 'Tyrrox', 5508.0)
(1, 4, 'LowSalHighComp', 255.0)
(2, 1, 'Pam', 300.0)
(2, 7, 'Bassem', 450.0)
(2, 9, 'Hermione', 700.0)
(3, 2, 'Ognjen', 1672.0)
(3, 7, 'Bocaben', 76.0)
(3, 13, 'Nyancat', 2508.0)
(3, 15, 'Morninngcat', 5911.0)
*/

-- Prediction Query
WITH CTE AS (SELECT COMPANY_ID, EMPLOYEE_ID, EMPLOYEE_NAME, SALARY, MAX(SALARY) OVER (PARTITION BY COMPANY_ID) AS MAX_SAL FROM SALARIES) SELECT COMPANY_ID, EMPLOYEE_ID, EMPLOYEE_NAME, CAST(CASE WHEN MAX_SAL < 1000 THEN SALARY WHEN MAX_SAL BETWEEN 1000 AND 10000 THEN SALARY - (0.24 * SALARY) WHEN MAX_SAL > 10000 THEN SALARY - (0.49 * SALARY) END AS REAL) AS SALARY FROM CTE;

/*
Prediction Result:
(1, 1, 'Tony', 1020.0)
(1, 2, 'Pronub', 10863.0)
(1, 3, 'Tyrrox', 5508.0)
(1, 4, 'LowSalHighComp', 255.0)
(2, 1, 'Pam', 300.0)
(2, 7, 'Bassem', 450.0)
(2, 9, 'Hermione', 700.0)
(3, 2, 'Ognjen', 1672.0)
(3, 7, 'Bocaben', 76.0)
(3, 13, 'Nyancat', 2508.0)
(3, 15, 'Morninngcat', 5910.52)
*/