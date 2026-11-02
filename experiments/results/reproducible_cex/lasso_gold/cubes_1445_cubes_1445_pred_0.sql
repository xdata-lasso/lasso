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
INSERT INTO "departments" ("department_id", "department_name", "manager_id", "location_id") VALUES (1020.5, 'Amber Perez', 1021.5, 1022.5);
INSERT INTO "departments" ("department_id", "department_name", "manager_id", "location_id") VALUES (1029.5, 'Devin Schaefer', 1030.5, 1031.5);
INSERT INTO "jobs" ("job_id", "job_title", "min_salary", "max_salary") VALUES ('Horticultural consultant', 'Cartographer', 1023.5, 1024.5);
INSERT INTO "jobs" ("job_id", "job_title", "min_salary", "max_salary") VALUES ('Surveyor, hydrographic', 'English as a foreign language teacher', 1032.5, 1033.5);
INSERT INTO "employees" ("employee_id", "job_id", "department_id", "first_name", "last_name", "email", "phone_number", "hire_date", "salary", "commission_pct", "manager_id") VALUES (1025.5, 'Horticultural consultant', 1020.5, 'Melissa', 'Delacruz', 'oramirez@example.com', '(555)434-1928', '1972-03-03', 1026.5, 1027.5, 1028.5);
INSERT INTO "employees" ("employee_id", "job_id", "department_id", "first_name", "last_name", "email", "phone_number", "hire_date", "salary", "commission_pct", "manager_id") VALUES (1034.5, 'Surveyor, hydrographic', 1029.5, 'Gabrielle', 'Cameron', 'perezantonio@example.com', '(541)639-5376x7242', '1973-04-04', NULL, 1036.5, 1037.5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT minsalary AS min_salary_, department_id FROM (SELECT department_id, MIN(salary) AS minsalary FROM employees GROUP BY department_id) ORDER BY min_salary_, department_id NULLS LAST;

/*
Gold Result:
(None, 1029.5)
(1026.5, 1020.5)
*/

-- Prediction Query
SELECT MIN(salary), department_id FROM employees GROUP BY department_id;

/*
Prediction Result:
(1026.5, 1020.5)
(None, 1029.5)
*/