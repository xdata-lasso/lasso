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
INSERT INTO "regions" ("region_id", "region_name") VALUES (12, '18');
INSERT INTO "regions" ("region_id", "region_name") VALUES (11, '18');
INSERT INTO "countries" ("country_id", "region_id", "country_name") VALUES ('13', 12, '18');
INSERT INTO "departments" ("department_id", "department_name", "manager_id", "location_id") VALUES (15, '18', 18, 18);
INSERT INTO "departments" ("department_id", "department_name", "manager_id", "location_id") VALUES (22, '18', 18, 18);
INSERT INTO "jobs" ("job_id", "job_title", "min_salary", "max_salary") VALUES ('17', '18', 18, 18);
INSERT INTO "jobs" ("job_id", "job_title", "min_salary", "max_salary") VALUES ('16', '18', 18, 18);
INSERT INTO "employees" ("employee_id", "job_id", "department_id", "first_name", "last_name", "email", "phone_number", "hire_date", "salary", "commission_pct", "manager_id") VALUES (18, '16', NULL, '18', '18', '18', '18', '1000-01-19', 18, 18, 18);
INSERT INTO "job_history" ("employee_id", "start_date", "job_id", "department_id", "end_date") VALUES (18, '1000-01-21', '16', NULL, '1000-01-19');
INSERT INTO "job_history" ("employee_id", "start_date", "job_id", "department_id", "end_date") VALUES (18, '1000-01-20', '17', 22, '1000-01-19');
INSERT INTO "locations" ("location_id", "country_id", "street_address", "postal_code", "city", "state_province") VALUES (24, '13', '18', '18', '18', '18');
INSERT INTO "locations" ("location_id", "country_id", "street_address", "postal_code", "city", "state_province") VALUES (23, NULL, '18', '18', '18', '18');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT employee_id FROM (SELECT department_id, employee_id, COUNT(*) AS n FROM job_history GROUP BY department_id, employee_id) WHERE (n = 2) ORDER BY employee_id;

/*
Gold Result:
*/

-- Prediction Query
SELECT employee_id FROM job_history GROUP BY employee_id HAVING COUNT(*) >= 2;

/*
Prediction Result:
(18.0,)
*/