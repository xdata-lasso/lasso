-- Schema DDL
CREATE TABLE "Salaries" ("company_id" INTEGER, "employee_id" INTEGER, "employee_name" TEXT(255), "salary" INTEGER, PRIMARY KEY ("company_id", "employee_id"), CHECK ("salary" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "salaries" ("company_id", "employee_id", "employee_name", "salary") VALUES (1032, 1035, 'Lisa Hensley', 1038);
INSERT INTO "salaries" ("company_id", "employee_id", "employee_name", "salary") VALUES (1032, 1036, 'Michele Williams', 1047.0);
INSERT INTO "salaries" ("company_id", "employee_id", "employee_name", "salary") VALUES (1032, 1037, 'Dylan Miller', 1056.0);
INSERT INTO "salaries" ("company_id", "employee_id", "employee_name", "salary") VALUES (1032, 1041, 'Brian Ramirez', 1044);
INSERT INTO "salaries" ("company_id", "employee_id", "employee_name", "salary") VALUES (1032, 1042, 'Holly Wood', 1053.0);
INSERT INTO "salaries" ("company_id", "employee_id", "employee_name", "salary") VALUES (1032, 1043, 'Derek Zuniga', 1062.0);
INSERT INTO "salaries" ("company_id", "employee_id", "employee_name", "salary") VALUES (1047, 1050, 'Lisa Jackson', NULL);
INSERT INTO "salaries" ("company_id", "employee_id", "employee_name", "salary") VALUES (1047, 1051, 'Carla Gray', NULL);
INSERT INTO "salaries" ("company_id", "employee_id", "employee_name", "salary") VALUES (1047, 1052, 'Margaret Hawkins DDS', NULL);
INSERT INTO "salaries" ("company_id", "employee_id", "employee_name", "salary") VALUES (1047, 1056, 'Patty Perez', NULL);
INSERT INTO "salaries" ("company_id", "employee_id", "employee_name", "salary") VALUES (1047, 1057, 'Ethan Adams', NULL);
INSERT INTO "salaries" ("company_id", "employee_id", "employee_name", "salary") VALUES (1047, 1058, 'Tommy Walter', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT S.COMPANY_ID, S.EMPLOYEE_ID, S.EMPLOYEE_NAME, CASE WHEN MAX_SALARY < 1000 THEN SALARY WHEN MAX_SALARY >= 1000 AND MAX_SALARY <= 10000 THEN ROUND(SALARY - SALARY * 0.24, 0) WHEN MAX_SALARY > 10000 THEN ROUND(SALARY - SALARY * 0.49, 0) END AS SALARY FROM SALARIES AS S JOIN (SELECT COMPANY_ID, MAX(SALARY) AS MAX_SALARY FROM SALARIES GROUP BY COMPANY_ID) AS T ON S.COMPANY_ID = T.COMPANY_ID;

/*
Gold Result:
(1032, 1035, 'Lisa Hensley', 789.0)
(1032, 1036, 'Michele Williams', 796.0)
(1032, 1037, 'Dylan Miller', 803.0)
(1032, 1041, 'Brian Ramirez', 793.0)
(1032, 1042, 'Holly Wood', 800.0)
(1032, 1043, 'Derek Zuniga', 807.0)
(1047, 1050, 'Lisa Jackson', None)
(1047, 1051, 'Carla Gray', None)
(1047, 1052, 'Margaret Hawkins DDS', None)
(1047, 1056, 'Patty Perez', None)
(1047, 1057, 'Ethan Adams', None)
(1047, 1058, 'Tommy Walter', None)
*/

-- Prediction Query
SELECT A.COMPANY_ID AS COMPANY_ID, A.EMPLOYEE_ID AS EMPLOYEE_ID, A.EMPLOYEE_NAME AS EMPLOYEE_NAME, ROUND((CASE WHEN MAX(B.SALARY) >= 10000 THEN A.SALARY * 0.51 WHEN MAX(B.SALARY) >= 1000 THEN A.SALARY * 0.76 ELSE A.SALARY END), 0) AS SALARY FROM SALARIES AS A CROSS JOIN SALARIES AS B WHERE A.COMPANY_ID = B.COMPANY_ID AND A.SALARY <= B.SALARY GROUP BY A.COMPANY_ID, A.EMPLOYEE_ID, A.EMPLOYEE_NAME;

/*
Prediction Result:
(1032, 1035, 'Lisa Hensley', 789.0)
(1032, 1036, 'Michele Williams', 796.0)
(1032, 1037, 'Dylan Miller', 803.0)
(1032, 1041, 'Brian Ramirez', 793.0)
(1032, 1042, 'Holly Wood', 800.0)
(1032, 1043, 'Derek Zuniga', 807.0)
*/