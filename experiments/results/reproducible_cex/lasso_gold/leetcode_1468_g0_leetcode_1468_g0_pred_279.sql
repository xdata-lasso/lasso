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
INSERT INTO "salaries" ("company_id", "employee_id", "employee_name", "salary") VALUES (1047, 1064, 'Matthew Foster', 1067);
INSERT INTO "salaries" ("company_id", "employee_id", "employee_name", "salary") VALUES (1047, 1065, 'Judy Baker', 1076.0);
INSERT INTO "salaries" ("company_id", "employee_id", "employee_name", "salary") VALUES (1047, 1066, 'Justin Baker', 1085.0);
INSERT INTO "salaries" ("company_id", "employee_id", "employee_name", "salary") VALUES (1047, 1070, 'Stephanie Ross', 1073);
INSERT INTO "salaries" ("company_id", "employee_id", "employee_name", "salary") VALUES (1047, 1071, 'Zachary Hicks', 1082.0);
INSERT INTO "salaries" ("company_id", "employee_id", "employee_name", "salary") VALUES (1047, 1072, 'Anthony Rodriguez', 1091.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT S.COMPANY_ID, S.EMPLOYEE_ID, S.EMPLOYEE_NAME, ROUND(CASE WHEN X.MAX_SAL BETWEEN 1000 AND 10000 THEN SALARY * 0.76 WHEN X.MAX_SAL > 10000 THEN SALARY * 0.51 ELSE SALARY END, 0) AS SALARY FROM SALARIES AS S INNER JOIN (SELECT COMPANY_ID, MAX(SALARY) AS MAX_SAL FROM SALARIES GROUP BY COMPANY_ID) AS X ON S.COMPANY_ID = X.COMPANY_ID;

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
(1047, 1064, 'Matthew Foster', 811.0)
(1047, 1065, 'Judy Baker', 818.0)
(1047, 1066, 'Justin Baker', 825.0)
(1047, 1070, 'Stephanie Ross', 815.0)
(1047, 1071, 'Zachary Hicks', 822.0)
(1047, 1072, 'Anthony Rodriguez', 829.0)
*/

-- Prediction Query
WITH TAX_RATE_BY_SALARY AS (SELECT *, CASE WHEN SALARY < 1000 THEN 0.0 WHEN SALARY <= 10000 THEN 0.24 ELSE 0.49 END AS TAX_RATE FROM SALARIES AS S), TAX_BY_COMPANY AS (SELECT COMPANY_ID, MAX(TAX_RATE) AS TAX FROM TAX_RATE_BY_SALARY AS T GROUP BY 1) SELECT S.COMPANY_ID, S.EMPLOYEE_ID, S.EMPLOYEE_NAME, ROUND(S.SALARY * (1 - T.TAX), 0) AS SALARY FROM SALARIES AS S LEFT JOIN TAX_BY_COMPANY AS T ON T.COMPANY_ID = S.COMPANY_ID;

/*
Prediction Result:
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
(1047, 1064, 'Matthew Foster', 544.0)
(1047, 1065, 'Judy Baker', 549.0)
(1047, 1066, 'Justin Baker', 553.0)
(1047, 1070, 'Stephanie Ross', 547.0)
(1047, 1071, 'Zachary Hicks', 552.0)
(1047, 1072, 'Anthony Rodriguez', 556.0)
*/