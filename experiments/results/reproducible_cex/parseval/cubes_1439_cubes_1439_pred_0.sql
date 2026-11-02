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
-- Inserting into table: departments --
INSERT INTO "departments" ("department_id", "department_name", "manager_id", "location_id") VALUES (1.0, 'dep_3b8bf1', 1.0, 1.0);

-- Inserting into table: jobs --
INSERT INTO "jobs" ("job_id", "job_title", "min_salary", "max_salary") VALUES ('job_id_1', 'job_d027ff', 1.0, 1.0);

-- Inserting into table: employees --
INSERT INTO "employees" ("employee_id", "job_id", "department_id", "first_name", "last_name", "email", "phone_number", "hire_date", "salary", "commission_pct", "manager_id") VALUES (1.0, 'job_id_1', 1.0, 'emp_c6ddad', 'emp_d9068b', 'emp_786f90', 'emp_75207a', '2025-06-13', 0.01, 0.01, 1.0);

-- Inserting into table: job_history --
INSERT INTO "job_history" ("employee_id", "start_date", "job_id", "department_id", "end_date") VALUES (1.0, '2023-03-15', 'job_id_1', 1.0, '2023-11-15');

INSERT INTO "job_history" ("employee_id", "start_date", "job_id", "department_id", "end_date") VALUES (1.0, '2022-12-08', 'job_id_1', 1.0, '2020-06-07');

INSERT INTO "job_history" ("employee_id", "start_date", "job_id", "department_id", "end_date") VALUES (1.0, '2023-04-14', 'job_id_1', 1.0, '2021-12-04');

INSERT INTO "job_history" ("employee_id", "start_date", "job_id", "department_id", "end_date") VALUES (1.0, '2020-06-08', 'job_id_1', 1.0, '2025-04-30');

INSERT INTO "job_history" ("employee_id", "start_date", "job_id", "department_id", "end_date") VALUES (1.0, '2021-02-11', 'job_id_1', 1.0, '2023-07-13');

INSERT INTO "job_history" ("employee_id", "start_date", "job_id", "department_id", "end_date") VALUES (1.0, '2020-12-20', 'job_id_1', 1.0, '2020-09-26');

INSERT INTO "job_history" ("employee_id", "start_date", "job_id", "department_id", "end_date") VALUES (1.0, '2021-05-05', 'job_id_1', 1.0, '2023-01-06');

INSERT INTO "job_history" ("employee_id", "start_date", "job_id", "department_id", "end_date") VALUES (1.0, '2020-01-20', 'job_id_1', 1.0, '2024-12-12');

INSERT INTO "job_history" ("employee_id", "start_date", "job_id", "department_id", "end_date") VALUES (1.0, '2022-09-17', 'job_id_1', 1.0, '2023-08-23');

INSERT INTO "job_history" ("employee_id", "start_date", "job_id", "department_id", "end_date") VALUES (1.0, '2023-04-22', 'job_id_1', 1.0, '2023-01-03');

INSERT INTO "job_history" ("employee_id", "start_date", "job_id", "department_id", "end_date") VALUES (1.0, '2020-03-30', 'job_id_1', 1.0, '2022-08-24');

INSERT INTO "job_history" ("employee_id", "start_date", "job_id", "department_id", "end_date") VALUES (1.0, '2021-04-10', 'job_id_1', 1.0, '2023-10-03');

INSERT INTO "job_history" ("employee_id", "start_date", "job_id", "department_id", "end_date") VALUES (1.0, '2022-01-04', 'job_id_1', 1.0, '2023-05-26');

INSERT INTO "job_history" ("employee_id", "start_date", "job_id", "department_id", "end_date") VALUES (1.0, '2021-05-27', 'job_id_1', 1.0, '2022-01-16');

INSERT INTO "job_history" ("employee_id", "start_date", "job_id", "department_id", "end_date") VALUES (1.0, '2022-04-29', 'job_id_1', 1.0, '2022-09-14');
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
(1.0,)
*/