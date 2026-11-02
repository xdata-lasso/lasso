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
INSERT INTO "departments" ("department_id", "department_name", "manager_id", "location_id") VALUES (80.0, 'Ross Price', 1179.5, 1180.5);
INSERT INTO "jobs" ("job_id", "job_title", "min_salary", "max_salary") VALUES ('Television/film/video producer', 'Advertising account planner', 1181.5, 1182.5);
INSERT INTO "jobs" ("job_id", "job_title", "min_salary", "max_salary") VALUES ('Writer', 'Pharmacist, community', 1189.5, 1190.5);
INSERT INTO "employees" ("employee_id", "job_id", "department_id", "first_name", "last_name", "email", "phone_number", "hire_date", "salary", "commission_pct", "manager_id") VALUES (1191.5, 'Television/film/video producer', 80.0, 'Anthony', 'Cannon', 'millerroy@example.com', '(804)665-3755', '1992-01-23', 1184.5, 1185.5, 1186.5);
INSERT INTO "employees" ("employee_id", "job_id", "department_id", "first_name", "last_name", "email", "phone_number", "hire_date", "salary", "commission_pct", "manager_id") VALUES (1183.5, 'Writer', 80.0, 'Melissa', 'Long', 'wwoods@example.com', '001-766-888-9373x46706', '1993-02-01', 1192.5, 1193.5, 1194.5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT employee_id, job_title FROM (SELECT LHS.employee_id AS employee_id, LHS.first_name AS first_name, LHS.last_name AS last_name, LHS.email AS email, LHS.phone_number AS phone_number, LHS.hire_date AS hire_date, LHS.job_id AS job_id, LHS.salary AS salary, LHS.commission_pct AS commission_pct, LHS.manager_id AS manager_id, LHS.department_id AS department_id, RHS.job_title AS job_title, RHS.min_salary AS min_salary, RHS.max_salary AS max_salary FROM (SELECT * FROM employees WHERE (department_id = 80.0)) AS LHS INNER JOIN jobs AS RHS ON (LHS.job_id = RHS.job_id)) ORDER BY employee_id, job_title NULLS LAST;

/*
Gold Result:
(1183.5, 'Pharmacist, community')
(1191.5, 'Advertising account planner')
*/

-- Prediction Query
SELECT T1.employee_id, T2.job_title FROM employees AS T1 JOIN jobs AS T2 ON T1.job_id = T2.job_id WHERE T1.department_id = 80;

/*
Prediction Result:
(1191.5, 'Advertising account planner')
(1183.5, 'Pharmacist, community')
*/