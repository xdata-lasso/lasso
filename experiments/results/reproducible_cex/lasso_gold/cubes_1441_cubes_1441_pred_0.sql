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
INSERT INTO "departments" ("department_id", "department_name", "manager_id", "location_id") VALUES (1170.5, 'Finance', 1171.5, 1172.5);
INSERT INTO "departments" ("department_id", "department_name", "manager_id", "location_id") VALUES (1179.5, 'Finance', 1180.5, 1181.5);
INSERT INTO "jobs" ("job_id", "job_title", "min_salary", "max_salary") VALUES ('Engineer, agricultural', 'Aeronautical engineer', 1173.5, 1174.5);
INSERT INTO "jobs" ("job_id", "job_title", "min_salary", "max_salary") VALUES ('Environmental health practitioner', 'Trading standards officer', 1182.5, 1183.5);
INSERT INTO "employees" ("employee_id", "job_id", "department_id", "first_name", "last_name", "email", "phone_number", "hire_date", "salary", "commission_pct", "manager_id") VALUES (1175.5, 'Engineer, agricultural', 1170.5, 'Heidi', 'Ross', 'jonathanfletcher@example.org', '768.750.1429x40196', '1988-08-19', 1176.5, 1177.5, 1178.5);
INSERT INTO "employees" ("employee_id", "job_id", "department_id", "first_name", "last_name", "email", "phone_number", "hire_date", "salary", "commission_pct", "manager_id") VALUES (1184.5, 'Environmental health practitioner', 1179.5, 'Donna', 'Wilson', 'michelle45@example.net', '783.856.1595x14846', '1989-09-20', 1185.5, 1186.5, 1187.5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "first_name", "job_id" FROM (SELECT "LHS"."employee_id" AS "employee_id", "LHS"."first_name" AS "first_name", "LHS"."last_name" AS "last_name", "LHS"."email" AS "email", "LHS"."phone_number" AS "phone_number", "LHS"."hire_date" AS "hire_date", "LHS"."job_id" AS "job_id", "LHS"."salary" AS "salary", "LHS"."commission_pct" AS "commission_pct", "LHS"."manager_id" AS "manager_id", "LHS"."department_id" AS "department_id", "RHS"."department_name" AS "department_name", "RHS"."manager_id" AS "manager_id_other", "RHS"."location_id" AS "location_id" FROM "employees" AS "LHS" INNER JOIN (SELECT * FROM "departments" WHERE ("department_name" = 'Finance')) AS RHS ON (LHS.department_id = RHS.department_id)) ORDER BY first_name, "first_name" NULLS LAST, "job_id" NULLS LAST;

/*
Gold Result:
('Donna', 'Environmental health practitioner')
('Heidi', 'Engineer, agricultural')
*/

-- Prediction Query
SELECT T1.first_name, T1.job_id FROM employees AS T1 JOIN departments AS T2 ON T1.department_id = T2.department_id WHERE T2.department_name = 'Finance';

/*
Prediction Result:
('Heidi', 'Engineer, agricultural')
('Donna', 'Environmental health practitioner')
*/