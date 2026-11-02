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
INSERT INTO "departments" ("department_id", "department_name", "manager_id", "location_id") VALUES (1051.5, 'Troy Liu', 1052.5, 1053.5);
INSERT INTO "departments" ("department_id", "department_name", "manager_id", "location_id") VALUES (1069.5, 'Joseph Martinez', 1070.5, 1071.5);
INSERT INTO "jobs" ("job_id", "job_title", "min_salary", "max_salary") VALUES ('General practice doctor', 'Restaurant manager, fast food', 1054.5, 1055.5);
INSERT INTO "jobs" ("job_id", "job_title", "min_salary", "max_salary") VALUES ('Equality and diversity officer', 'Bonds trader', 1072.5, 1073.5);
INSERT INTO "jobs" ("job_id", "job_title", "min_salary", "max_salary") VALUES ('Careers information officer', NULL, NULL, NULL);
INSERT INTO "employees" ("employee_id", "job_id", "department_id", "first_name", "last_name", "email", "phone_number", "hire_date", "salary", "commission_pct", "manager_id") VALUES (1056.5, 'General practice doctor', 1051.5, 'Kathleen', 'Romero', 'harrellkenneth@example.net', '793.625.2880x95701', '1975-06-06', 1057.5, 1058.5, 1059.5);
INSERT INTO "employees" ("employee_id", "job_id", "department_id", "first_name", "last_name", "email", "phone_number", "hire_date", "salary", "commission_pct", "manager_id") VALUES (1065.5, 'Careers information officer', 1051.5, 'Jessica', 'Cabrera', 'davidalvarez@example.net', '(848)796-3834', '1976-07-07', 1066.5, 1067.5, 1068.5);
INSERT INTO "employees" ("employee_id", "job_id", "department_id", "first_name", "last_name", "email", "phone_number", "hire_date", "salary", "commission_pct", "manager_id") VALUES (1074.5, 'Equality and diversity officer', 1069.5, 'Matthew', 'Chapman', 'briannasmith@example.net', '+1-403-910-5183x4738', '1977-08-08', 1075.5, 1076.5, 1077.5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT first_name, department_name FROM (SELECT LHS.department_id AS department_id, LHS.department_name AS department_name, LHS.manager_id AS manager_id, LHS.location_id AS location_id, RHS.employee_id AS employee_id, RHS.first_name AS first_name, RHS.last_name AS last_name, RHS.email AS email, RHS.phone_number AS phone_number, RHS.hire_date AS hire_date, RHS.job_id AS job_id, RHS.salary AS salary, RHS.commission_pct AS commission_pct, RHS.manager_id AS manager_id_other FROM departments AS LHS INNER JOIN employees AS RHS ON (LHS.department_id = RHS.department_id)) ORDER BY first_name, department_name NULLS LAST;

/*
Gold Result:
('Jessica', 'Troy Liu')
('Kathleen', 'Troy Liu')
('Matthew', 'Joseph Martinez')
*/

-- Prediction Query
SELECT T1.first_name, T2.department_name FROM employees AS T1 JOIN departments AS T2 ON T1.department_id = T2.department_id;

/*
Prediction Result:
('Kathleen', 'Troy Liu')
('Jessica', 'Troy Liu')
('Matthew', 'Joseph Martinez')
*/