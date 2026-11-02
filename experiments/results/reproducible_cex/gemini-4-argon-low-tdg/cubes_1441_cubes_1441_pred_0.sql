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
-- DATASET 2
-- Tests ORDER BY tie-breaking (same first_name, different job_id), NULL handling in ORDER BY (NULLS LAST vs NULLS FIRST for both first_name and job_id), and duplicate rows (SELECT vs SELECT DISTINCT).
INSERT INTO "jobs" ("JOB_ID", "JOB_TITLE", "MIN_SALARY", "MAX_SALARY") VALUES ('J_A', 'Role A', 1000, 2000);
INSERT INTO "jobs" ("JOB_ID", "JOB_TITLE", "MIN_SALARY", "MAX_SALARY") VALUES ('J_B', 'Role B', 1000, 2000);
INSERT INTO "departments" ("DEPARTMENT_ID", "DEPARTMENT_NAME", "MANAGER_ID", "LOCATION_ID") VALUES (100, 'Finance', 1, 10);
INSERT INTO "employees" ("EMPLOYEE_ID", "FIRST_NAME", "LAST_NAME", "EMAIL", "PHONE_NUMBER", "HIRE_DATE", "JOB_ID", "SALARY", "COMMISSION_PCT", "MANAGER_ID", "DEPARTMENT_ID") VALUES (10, 'Zack', 'A', 'E1', '1', '2021-01-01', 'J_B', 1500, NULL, 1, 100);
INSERT INTO "employees" ("EMPLOYEE_ID", "FIRST_NAME", "LAST_NAME", "EMAIL", "PHONE_NUMBER", "HIRE_DATE", "JOB_ID", "SALARY", "COMMISSION_PCT", "MANAGER_ID", "DEPARTMENT_ID") VALUES (20, 'Aaron', 'B', 'E2', '2', '2021-01-02', 'J_B', 1500, NULL, 1, 100);
INSERT INTO "employees" ("EMPLOYEE_ID", "FIRST_NAME", "LAST_NAME", "EMAIL", "PHONE_NUMBER", "HIRE_DATE", "JOB_ID", "SALARY", "COMMISSION_PCT", "MANAGER_ID", "DEPARTMENT_ID") VALUES (30, 'Aaron', 'C', 'E3', '3', '2021-01-03', 'J_A', 1500, NULL, 1, 100);
INSERT INTO "employees" ("EMPLOYEE_ID", "FIRST_NAME", "LAST_NAME", "EMAIL", "PHONE_NUMBER", "HIRE_DATE", "JOB_ID", "SALARY", "COMMISSION_PCT", "MANAGER_ID", "DEPARTMENT_ID") VALUES (40, 'Aaron', 'D', 'E4', '4', '2021-01-04', NULL, 1500, NULL, 1, 100);
INSERT INTO "employees" ("EMPLOYEE_ID", "FIRST_NAME", "LAST_NAME", "EMAIL", "PHONE_NUMBER", "HIRE_DATE", "JOB_ID", "SALARY", "COMMISSION_PCT", "MANAGER_ID", "DEPARTMENT_ID") VALUES (50, 'Aaron', 'E', 'E5', '5', '2021-01-05', 'J_A', 1600, NULL, 1, 100);
INSERT INTO "employees" ("EMPLOYEE_ID", "FIRST_NAME", "LAST_NAME", "EMAIL", "PHONE_NUMBER", "HIRE_DATE", "JOB_ID", "SALARY", "COMMISSION_PCT", "MANAGER_ID", "DEPARTMENT_ID") VALUES (60, NULL, 'F', 'E6', '6', '2021-01-06', 'J_B', 1500, NULL, 1, 100);
INSERT INTO "employees" ("EMPLOYEE_ID", "FIRST_NAME", "LAST_NAME", "EMAIL", "PHONE_NUMBER", "HIRE_DATE", "JOB_ID", "SALARY", "COMMISSION_PCT", "MANAGER_ID", "DEPARTMENT_ID") VALUES (70, NULL, 'G', 'E7', '7', '2021-01-07', 'J_A', 1500, NULL, 1, 100);
INSERT INTO "employees" ("EMPLOYEE_ID", "FIRST_NAME", "LAST_NAME", "EMAIL", "PHONE_NUMBER", "HIRE_DATE", "JOB_ID", "SALARY", "COMMISSION_PCT", "MANAGER_ID", "DEPARTMENT_ID") VALUES (80, NULL, 'H', 'E8', '8', '2021-01-08', NULL, 1500, NULL, 1, 100);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "first_name", "job_id" FROM (SELECT "LHS"."employee_id" AS "employee_id", "LHS"."first_name" AS "first_name", "LHS"."last_name" AS "last_name", "LHS"."email" AS "email", "LHS"."phone_number" AS "phone_number", "LHS"."hire_date" AS "hire_date", "LHS"."job_id" AS "job_id", "LHS"."salary" AS "salary", "LHS"."commission_pct" AS "commission_pct", "LHS"."manager_id" AS "manager_id", "LHS"."department_id" AS "department_id", "RHS"."department_name" AS "department_name", "RHS"."manager_id" AS "manager_id_other", "RHS"."location_id" AS "location_id" FROM "employees" AS "LHS" INNER JOIN (SELECT * FROM "departments" WHERE ("department_name" = 'Finance')) AS RHS ON (LHS.department_id = RHS.department_id)) ORDER BY first_name, "first_name" NULLS LAST, "job_id" NULLS LAST;

/*
Gold Result:
(None, 'J_A')
(None, 'J_B')
(None, None)
('Aaron', 'J_A')
('Aaron', 'J_A')
('Aaron', 'J_B')
('Aaron', None)
('Zack', 'J_B')
*/

-- Prediction Query
SELECT T1.first_name, T1.job_id FROM employees AS T1 JOIN departments AS T2 ON T1.department_id = T2.department_id WHERE T2.department_name = 'Finance';

/*
Prediction Result:
('Zack', 'J_B')
('Aaron', 'J_B')
('Aaron', 'J_A')
('Aaron', None)
('Aaron', 'J_A')
(None, 'J_B')
(None, 'J_A')
(None, None)
*/