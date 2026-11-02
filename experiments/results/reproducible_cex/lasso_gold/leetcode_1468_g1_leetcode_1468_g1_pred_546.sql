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
SELECT COMPANY_ID, EMPLOYEE_ID, EMPLOYEE_NAME, ROUND(CASE WHEN MAX(SALARY) OVER (PARTITION BY COMPANY_ID) < 1000 THEN SALARY WHEN MAX(SALARY) OVER (PARTITION BY COMPANY_ID) BETWEEN 1000 AND 10000 THEN SALARY * 0.76 WHEN MAX(SALARY) OVER (PARTITION BY COMPANY_ID) > 10000 THEN 0.51 * SALARY ELSE 0 END) AS SALARY FROM SALARIES GROUP BY 1, 2;

/*
Prediction Result:
(1032, 1035, 'Lisa Hensley', 789.0)
(1032, 1036, 'Michele Williams', 796.0)
(1032, 1037, 'Dylan Miller', 803.0)
(1032, 1041, 'Brian Ramirez', 793.0)
(1032, 1042, 'Holly Wood', 800.0)
(1032, 1043, 'Derek Zuniga', 807.0)
(1047, 1050, 'Lisa Jackson', 0.0)
(1047, 1051, 'Carla Gray', 0.0)
(1047, 1052, 'Margaret Hawkins DDS', 0.0)
(1047, 1056, 'Patty Perez', 0.0)
(1047, 1057, 'Ethan Adams', 0.0)
(1047, 1058, 'Tommy Walter', 0.0)
*/