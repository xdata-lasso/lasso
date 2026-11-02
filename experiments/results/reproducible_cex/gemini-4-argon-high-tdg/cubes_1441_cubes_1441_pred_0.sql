-- Schema DDL
CREATE TABLE "regions" ("REGION_ID" REAL(5, 0) PRIMARY KEY, "REGION_NAME" TEXT(25));

CREATE TABLE "countries" ("COUNTRY_ID" TEXT(2) PRIMARY KEY, "REGION_ID" REAL(10, 0), "COUNTRY_NAME" TEXT(40), FOREIGN KEY ("REGION_ID") REFERENCES "regions" ("REGION_ID"));

CREATE TABLE "departments" ("DEPARTMENT_ID" REAL(4, 0) PRIMARY KEY, "DEPARTMENT_NAME" TEXT(30), "MANAGER_ID" REAL(6, 0), "LOCATION_ID" REAL(4, 0));

CREATE TABLE "jobs" ("JOB_ID" TEXT(10) PRIMARY KEY, "JOB_TITLE" TEXT(35), "MIN_SALARY" REAL(6, 0), "MAX_SALARY" REAL(6, 0));

CREATE TABLE "employees" ("EMPLOYEE_ID" REAL(6, 0) PRIMARY KEY, "JOB_ID" TEXT(10), "DEPARTMENT_ID" REAL(4, 0), "FIRST_NAME" TEXT(20), "LAST_NAME" TEXT(25), "EMAIL" TEXT(25), "PHONE_NUMBER" TEXT(20), "HIRE_DATE" DATE, "SALARY" REAL(8, 2), "COMMISSION_PCT" REAL(2, 2), "MANAGER_ID" REAL(6, 0), FOREIGN KEY ("JOB_ID") REFERENCES "jobs" ("JOB_ID"), FOREIGN KEY ("DEPARTMENT_ID") REFERENCES "departments" ("DEPARTMENT_ID"));

CREATE TABLE "job_history" ("EMPLOYEE_ID" REAL(6, 0), "START_DATE" DATE, "JOB_ID" TEXT(10), "DEPARTMENT_ID" REAL(4, 0), "END_DATE" DATE, PRIMARY KEY ("EMPLOYEE_ID", "START_DATE"), FOREIGN KEY ("JOB_ID") REFERENCES "jobs" ("JOB_ID"), FOREIGN KEY ("DEPARTMENT_ID") REFERENCES "departments" ("DEPARTMENT_ID"), FOREIGN KEY ("EMPLOYEE_ID") REFERENCES "employees" ("EMPLOYEE_ID"));

CREATE TABLE "locations" ("LOCATION_ID" REAL(4, 0) PRIMARY KEY, "COUNTRY_ID" TEXT(2), "STREET_ADDRESS" TEXT(40), "POSTAL_CODE" TEXT(12), "CITY" TEXT(30), "STATE_PROVINCE" TEXT(25), FOREIGN KEY ("COUNTRY_ID") REFERENCES "countries" ("COUNTRY_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "jobs" ("JOB_ID", "JOB_TITLE", "MIN_SALARY", "MAX_SALARY") VALUES ('FI_MGR', 'Finance Manager', 8200, 16000);
INSERT INTO "jobs" ("JOB_ID", "JOB_TITLE", "MIN_SALARY", "MAX_SALARY") VALUES ('FI_ACCOUNT', 'Accountant', 4200, 9000);
INSERT INTO "jobs" ("JOB_ID", "JOB_TITLE", "MIN_SALARY", "MAX_SALARY") VALUES ('SA_REP', 'Sales Representative', 6000, 12000);
INSERT INTO "departments" ("DEPARTMENT_ID", "DEPARTMENT_NAME", "MANAGER_ID", "LOCATION_ID") VALUES (100, 'Finance', 200, 1700);
INSERT INTO "departments" ("DEPARTMENT_ID", "DEPARTMENT_NAME", "MANAGER_ID", "LOCATION_ID") VALUES (80, 'Sales', 101, 2500);
INSERT INTO "departments" ("DEPARTMENT_ID", "DEPARTMENT_NAME", "MANAGER_ID", "LOCATION_ID") VALUES (90, 'Executive', 102, 1700);
INSERT INTO "employees" ("EMPLOYEE_ID", "JOB_ID", "DEPARTMENT_ID", "FIRST_NAME", "LAST_NAME", "EMAIL", "PHONE_NUMBER", "HIRE_DATE", "SALARY", "COMMISSION_PCT", "MANAGER_ID") VALUES (101, 'FI_MGR', 100, 'Zack', 'Adams', 'ZADAMS', '515.123.4567', '2020-01-15', 12000.00, NULL, 102);
INSERT INTO "employees" ("EMPLOYEE_ID", "JOB_ID", "DEPARTMENT_ID", "FIRST_NAME", "LAST_NAME", "EMAIL", "PHONE_NUMBER", "HIRE_DATE", "SALARY", "COMMISSION_PCT", "MANAGER_ID") VALUES (102, 'FI_MGR', 100, 'Alice', 'Baker', 'ABAKER', '515.123.4568', '2019-03-10', 15000.00, NULL, NULL);
INSERT INTO "employees" ("EMPLOYEE_ID", "JOB_ID", "DEPARTMENT_ID", "FIRST_NAME", "LAST_NAME", "EMAIL", "PHONE_NUMBER", "HIRE_DATE", "SALARY", "COMMISSION_PCT", "MANAGER_ID") VALUES (103, 'FI_ACCOUNT', 100, 'Alice', 'Clark', 'ACLARK', '515.123.4569', '2021-06-01', 7500.00, NULL, 102);
INSERT INTO "employees" ("EMPLOYEE_ID", "JOB_ID", "DEPARTMENT_ID", "FIRST_NAME", "LAST_NAME", "EMAIL", "PHONE_NUMBER", "HIRE_DATE", "SALARY", "COMMISSION_PCT", "MANAGER_ID") VALUES (200, 'SA_REP', 80, 'Bob', 'Davis', 'BDAVIS', '515.123.4570', '2018-11-20', 9500.00, 0.20, 200);
INSERT INTO "employees" ("EMPLOYEE_ID", "JOB_ID", "DEPARTMENT_ID", "FIRST_NAME", "LAST_NAME", "EMAIL", "PHONE_NUMBER", "HIRE_DATE", "SALARY", "COMMISSION_PCT", "MANAGER_ID") VALUES (201, 'FI_ACCOUNT', NULL, 'Charlie', 'Evans', 'CEVANS', '515.123.4571', '2022-02-14', 6000.00, NULL, 200);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "first_name", "job_id" FROM (SELECT "LHS"."employee_id" AS "employee_id", "LHS"."first_name" AS "first_name", "LHS"."last_name" AS "last_name", "LHS"."email" AS "email", "LHS"."phone_number" AS "phone_number", "LHS"."hire_date" AS "hire_date", "LHS"."job_id" AS "job_id", "LHS"."salary" AS "salary", "LHS"."commission_pct" AS "commission_pct", "LHS"."manager_id" AS "manager_id", "LHS"."department_id" AS "department_id", "RHS"."department_name" AS "department_name", "RHS"."manager_id" AS "manager_id_other", "RHS"."location_id" AS "location_id" FROM "employees" AS "LHS" INNER JOIN (SELECT * FROM "departments" WHERE ("department_name" = 'Finance')) AS RHS ON (LHS.department_id = RHS.department_id)) ORDER BY first_name, "first_name" NULLS LAST, "job_id" NULLS LAST;

/*
Gold Result:
('Alice', 'FI_ACCOUNT')
('Alice', 'FI_MGR')
('Zack', 'FI_MGR')
*/

-- Prediction Query
SELECT T1.first_name, T1.job_id FROM employees AS T1 JOIN departments AS T2 ON T1.department_id = T2.department_id WHERE T2.department_name = 'Finance';

/*
Prediction Result:
('Zack', 'FI_MGR')
('Alice', 'FI_MGR')
('Alice', 'FI_ACCOUNT')
*/