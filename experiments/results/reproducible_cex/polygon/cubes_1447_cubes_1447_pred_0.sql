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
INSERT INTO "regions" ("region_id", "region_name") VALUES (18, '26');
INSERT INTO "regions" ("region_id", "region_name") VALUES (17, '26');
INSERT INTO "countries" ("country_id", "region_id", "country_name") VALUES ('19', 18, '26');
INSERT INTO "departments" ("department_id", "department_name", "manager_id", "location_id") VALUES (22, '53', 26, 42);
INSERT INTO "departments" ("department_id", "department_name", "manager_id", "location_id") VALUES (21, '54', 43, 44);
INSERT INTO "jobs" ("job_id", "job_title", "min_salary", "max_salary") VALUES ('24', '26', 26, 26);
INSERT INTO "jobs" ("job_id", "job_title", "min_salary", "max_salary") VALUES ('23', '26', 26, 26);
INSERT INTO "employees" ("employee_id", "job_id", "department_id", "first_name", "last_name", "email", "phone_number", "hire_date", "salary", "commission_pct", "manager_id") VALUES (26, NULL, 22, NULL, NULL, NULL, '37', NULL, NULL, NULL, NULL);
INSERT INTO "employees" ("employee_id", "job_id", "department_id", "first_name", "last_name", "email", "phone_number", "hire_date", "salary", "commission_pct", "manager_id") VALUES (25, '23', 21, '45', '46', '47', '48', '1000-02-19', 50, 51, 52);
INSERT INTO "job_history" ("employee_id", "start_date", "job_id", "department_id", "end_date") VALUES (26, '1000-01-27', '23', 21, '1000-01-27');
INSERT INTO "job_history" ("employee_id", "start_date", "job_id", "department_id", "end_date") VALUES (25, '1000-01-27', '24', 21, '1000-01-27');
INSERT INTO "locations" ("location_id", "country_id", "street_address", "postal_code", "city", "state_province") VALUES (29, '19', '26', '26', '26', '26');
INSERT INTO "locations" ("location_id", "country_id", "street_address", "postal_code", "city", "state_province") VALUES (28, '19', '26', '26', '26', '26');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT department_name FROM (SELECT LHS.employee_id AS employee_id, LHS.first_name AS first_name, LHS.last_name AS last_name, LHS.email AS email, LHS.phone_number AS phone_number, LHS.hire_date AS hire_date, LHS.job_id AS job_id, LHS.salary AS salary, LHS.commission_pct AS commission_pct, LHS.manager_id AS manager_id, LHS.department_id AS department_id, RHS.department_name AS department_name, RHS.location_id AS location_id FROM employees AS LHS INNER JOIN departments AS RHS ON (LHS.department_id = RHS.department_id AND LHS.employee_id = RHS.manager_id)) ORDER BY department_name;

/*
Gold Result:
('53',)
*/

-- Prediction Query
SELECT DISTINCT T2.department_name FROM employees AS T1 JOIN departments AS T2 ON T1.department_id = T2.department_id;

/*
Prediction Result:
('53',)
('54',)
*/