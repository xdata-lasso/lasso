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
WITH MAXES AS (SELECT COMPANY_ID, MAX(SALARY) AS MAX_SALARY FROM SALARIES GROUP BY COMPANY_ID) SELECT SALARIES.COMPANY_ID, EMPLOYEE_ID, EMPLOYEE_NAME, CASE WHEN MAX_SALARY > 10000 THEN CAST(SALARY - (SALARY * 0.49) AS UBIGINT) WHEN MAX_SALARY >= 1000 AND MAX_SALARY <= 10000 THEN CAST(SALARY - (SALARY * 0.24) AS UBIGINT) ELSE SALARY END AS SALARY FROM SALARIES INNER JOIN MAXES ON SALARIES.COMPANY_ID = MAXES.COMPANY_ID;

/*
Prediction Result:
(1, 1, 'Tony', 1020)
(1, 2, 'Pronub', 10863)
(1, 3, 'Tyrrox', 5508)
(1, 4, 'LowSalHighComp', 255)
(2, 1, 'Pam', 300)
(2, 7, 'Bassem', 450)
(2, 9, 'Hermione', 700)
(3, 2, 'Ognjen', 1672)
(3, 7, 'Bocaben', 76)
(3, 13, 'Nyancat', 2508)
(3, 15, 'Morninngcat', 5910)
*/