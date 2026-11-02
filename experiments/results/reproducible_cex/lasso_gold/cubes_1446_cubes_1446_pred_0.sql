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
INSERT INTO "departments" ("department_id", "department_name", "manager_id", "location_id") VALUES (1055.5, 'David Bradley', 1056.5, 1057.5);
INSERT INTO "departments" ("department_id", "department_name", "manager_id", "location_id") VALUES (1056.5, 'Joseph Martinez', 1064.5, 1065.5);
INSERT INTO "jobs" ("job_id", "job_title", "min_salary", "max_salary") VALUES ('Careers information officer', 'Chartered certified accountant', 1058.5, 1059.5);
INSERT INTO "jobs" ("job_id", "job_title", "min_salary", "max_salary") VALUES ('Equality and diversity officer', 'Bonds trader', 1066.5, 1067.5);
INSERT INTO "employees" ("employee_id", "job_id", "department_id", "first_name", "last_name", "email", "phone_number", "hire_date", "salary", "commission_pct", "manager_id") VALUES (1060.5, 'Careers information officer', 1055.5, 'Jessica', 'Cabrera', 'davidalvarez@example.net', '(848)796-3834', '1992-01-23', 1061.5, 1062.5, 1063.5);
INSERT INTO "job_history" ("employee_id", "start_date", "job_id", "department_id", "end_date") VALUES (1060.5, '1993-02-01', 'Careers information officer', 1055.5, '1994-03-02');
INSERT INTO "job_history" ("employee_id", "start_date", "job_id", "department_id", "end_date") VALUES (1060.5, '1996-05-04', 'Equality and diversity officer', 1056.5, '1994-03-02');
INSERT INTO "job_history" ("employee_id", "start_date", "job_id", "department_id", "end_date") VALUES (1060.5, '1997-06-05', 'Equality and diversity officer', 1056.5, '1994-03-02');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT employee_id, maxend_date AS max_end_date_ FROM (SELECT department_id, employee_id, MAX(end_date) AS maxend_date FROM job_history GROUP BY department_id, employee_id) ORDER BY employee_id, max_end_date_ NULLS LAST;

/*
Gold Result:
(1060.5, '1994-03-02')
(1060.5, '1994-03-02')
*/

-- Prediction Query
SELECT employee_id, MAX(end_date) FROM job_history GROUP BY employee_id;

/*
Prediction Result:
(1060.5, '1994-03-02')
*/