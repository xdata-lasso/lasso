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
INSERT INTO "regions" ("region_id", "region_name") VALUES (17, '-80');
INSERT INTO "regions" ("region_id", "region_name") VALUES (16, '-80');
INSERT INTO "countries" ("country_id", "region_id", "country_name") VALUES ('19', 16, '-80');
INSERT INTO "countries" ("country_id", "region_id", "country_name") VALUES ('18', 17, '-80');
INSERT INTO "departments" ("department_id", "department_name", "manager_id", "location_id") VALUES (25, '-80', -80, -80);
INSERT INTO "departments" ("department_id", "department_name", "manager_id", "location_id") VALUES (20, '-80', -80, -80);
INSERT INTO "jobs" ("job_id", "job_title", "min_salary", "max_salary") VALUES ('22', '52', 48, NULL);
INSERT INTO "jobs" ("job_id", "job_title", "min_salary", "max_salary") VALUES ('21', '52', NULL, NULL);
INSERT INTO "employees" ("employee_id", "job_id", "department_id", "first_name", "last_name", "email", "phone_number", "hire_date", "salary", "commission_pct", "manager_id") VALUES (24, '21', 25, '55', '56', '57', '58', '1000-03-01', -80, 60, 61);
INSERT INTO "employees" ("employee_id", "job_id", "department_id", "first_name", "last_name", "email", "phone_number", "hire_date", "salary", "commission_pct", "manager_id") VALUES (23, '22', 25, '62', '63', '64', '65', '1000-03-08', -80, 67, 68);
INSERT INTO "job_history" ("employee_id", "start_date", "job_id", "department_id", "end_date") VALUES (23, '0999-10-13', '22', 20, '0999-10-13');
INSERT INTO "locations" ("location_id", "country_id", "street_address", "postal_code", "city", "state_province") VALUES (27, '18', '-80', '-80', '-80', '-80');
INSERT INTO "locations" ("location_id", "country_id", "street_address", "postal_code", "city", "state_province") VALUES (26, '19', '-80', '-80', '-80', '-80');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT job_title, meansalary AS avg_salary_ FROM (SELECT LHS.job_id AS job_id, LHS.meansalary AS meansalary, RHS.job_title AS job_title, RHS.min_salary AS min_salary, RHS.max_salary AS max_salary FROM (SELECT job_id, AVG(salary) AS meansalary FROM employees GROUP BY job_id) AS LHS INNER JOIN jobs AS RHS ON (LHS.job_id = RHS.job_id)) ORDER BY job_title, avg_salary_ NULLS LAST;

/*
Gold Result:
('52', -80.0)
('52', -80.0)
*/

-- Prediction Query
SELECT job_title, AVG(salary) FROM employees AS T1 JOIN jobs AS T2 ON T1.job_id = T2.job_id GROUP BY T2.job_title;

/*
Prediction Result:
('52', -80.0)
*/