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
INSERT INTO "jobs" ("job_id", "job_title", "min_salary", "max_salary") VALUES ('t1__fdd61a', 't2__3b16d6', 1.0, 1.0);

INSERT INTO "jobs" ("job_id", "job_title", "min_salary", "max_salary") VALUES ('job_id_2', 't2__3b16d6', 2.0, 2.0);

INSERT INTO "jobs" ("job_id", "job_title", "min_salary", "max_salary") VALUES ('t1__35e66b', 'job_d027ff', 3.0, 3.0);

INSERT INTO "jobs" ("job_id", "job_title", "min_salary", "max_salary") VALUES ('@', 't2__3b16d6', 4.0, 4.0);

INSERT INTO "jobs" ("job_id", "job_title", "min_salary", "max_salary") VALUES ('A', 'job_d027ff', 5.0, 5.0);

INSERT INTO "jobs" ("job_id", "job_title", "min_salary", "max_salary") VALUES ('E', 't2__3b16d6', 6.0, 6.0);

INSERT INTO "jobs" ("job_id", "job_title", "min_salary", "max_salary") VALUES ('U', 't2__3b16d6', 7.0, 7.0);

INSERT INTO "jobs" ("job_id", "job_title", "min_salary", "max_salary") VALUES ('t2__bb2e4d', 'job_d027ff', 8.0, 8.0);

-- Inserting into table: employees --
INSERT INTO "employees" ("employee_id", "job_id", "department_id", "first_name", "last_name", "email", "phone_number", "hire_date", "salary", "commission_pct", "manager_id") VALUES (1.0, 't1__fdd61a', 1.0, 'emp_c6ddad', 'emp_d9068b', 'emp_786f90', 'emp_75207a', '2025-06-17', 0.01, 0.01, 1.0);

INSERT INTO "employees" ("employee_id", "job_id", "department_id", "first_name", "last_name", "email", "phone_number", "hire_date", "salary", "commission_pct", "manager_id") VALUES (2.0, 't1__fdd61a', 1.0, 'emp_c6ddad', 'emp_d9068b', 'emp_786f90', 'emp_75207a', '2025-06-13', 0.02, 0.02, 2.0);

INSERT INTO "employees" ("employee_id", "job_id", "department_id", "first_name", "last_name", "email", "phone_number", "hire_date", "salary", "commission_pct", "manager_id") VALUES (3.0, 't1__35e66b', 1.0, 'emp_c6ddad', 'emp_d9068b', 'emp_786f90', 'emp_75207a', '2023-11-15', 0.03, 0.03, 3.0);

INSERT INTO "employees" ("employee_id", "job_id", "department_id", "first_name", "last_name", "email", "phone_number", "hire_date", "salary", "commission_pct", "manager_id") VALUES (4.0, 'A', 1.0, 'emp_c6ddad', 'emp_d9068b', 'emp_786f90', 'emp_75207a', '2022-12-08', 0.04, 0.04, 4.0);

INSERT INTO "employees" ("employee_id", "job_id", "department_id", "first_name", "last_name", "email", "phone_number", "hire_date", "salary", "commission_pct", "manager_id") VALUES (5.0, 'A', 1.0, 'emp_c6ddad', 'emp_d9068b', 'emp_786f90', 'emp_75207a', '2021-02-05', 0.05, 0.05, 5.0);

INSERT INTO "employees" ("employee_id", "job_id", "department_id", "first_name", "last_name", "email", "phone_number", "hire_date", "salary", "commission_pct", "manager_id") VALUES (6.0, 'A', 1.0, 'emp_c6ddad', 'emp_d9068b', 'emp_786f90', 'emp_75207a', '2021-12-04', 0.06, 0.06, 6.0);

INSERT INTO "employees" ("employee_id", "job_id", "department_id", "first_name", "last_name", "email", "phone_number", "hire_date", "salary", "commission_pct", "manager_id") VALUES (7.0, 't1__fdd61a', 1.0, 'emp_c6ddad', 'emp_d9068b', 'emp_786f90', 'emp_75207a', '2020-12-20', NULL, 0.07, 7.0);

INSERT INTO "employees" ("employee_id", "job_id", "department_id", "first_name", "last_name", "email", "phone_number", "hire_date", "salary", "commission_pct", "manager_id") VALUES (8.0, 't1__35e66b', 1.0, 'emp_c6ddad', 'emp_d9068b', 'emp_786f90', 'emp_75207a', '2025-06-04', NULL, 0.08, 8.0);

INSERT INTO "employees" ("employee_id", "job_id", "department_id", "first_name", "last_name", "email", "phone_number", "hire_date", "salary", "commission_pct", "manager_id") VALUES (9.0, 't1__fdd61a', 1.0, 'emp_c6ddad', 'emp_d9068b', 'emp_786f90', 'emp_75207a', '2023-01-06', NULL, 0.09, 9.0);

INSERT INTO "employees" ("employee_id", "job_id", "department_id", "first_name", "last_name", "email", "phone_number", "hire_date", "salary", "commission_pct", "manager_id") VALUES (10.0, 't1__35e66b', 1.0, 'emp_c6ddad', 'emp_d9068b', 'emp_786f90', 'emp_75207a', '2020-01-20', NULL, 0.1, 10.0);

INSERT INTO "employees" ("employee_id", "job_id", "department_id", "first_name", "last_name", "email", "phone_number", "hire_date", "salary", "commission_pct", "manager_id") VALUES (11.0, 't1__fdd61a', 1.0, 'emp_c6ddad', 'emp_d9068b', 'emp_786f90', 'emp_75207a', '2024-03-30', NULL, 0.11, 11.0);

INSERT INTO "employees" ("employee_id", "job_id", "department_id", "first_name", "last_name", "email", "phone_number", "hire_date", "salary", "commission_pct", "manager_id") VALUES (12.0, 't1__35e66b', 1.0, 'emp_c6ddad', 'emp_d9068b', 'emp_786f90', 'emp_75207a', '2023-08-23', NULL, 0.12, 12.0);

INSERT INTO "employees" ("employee_id", "job_id", "department_id", "first_name", "last_name", "email", "phone_number", "hire_date", "salary", "commission_pct", "manager_id") VALUES (13.0, 't1__fdd61a', 1.0, 'emp_c6ddad', 'emp_d9068b', 'emp_786f90', 'emp_75207a', '2021-03-30', NULL, 0.13, 13.0);

INSERT INTO "employees" ("employee_id", "job_id", "department_id", "first_name", "last_name", "email", "phone_number", "hire_date", "salary", "commission_pct", "manager_id") VALUES (14.0, 't1__35e66b', 1.0, 'emp_c6ddad', 'emp_d9068b', 'emp_786f90', 'emp_75207a', '2023-01-03', NULL, 0.14, 14.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT job_title, meansalary AS avg_salary_ FROM (SELECT LHS.job_id AS job_id, LHS.meansalary AS meansalary, RHS.job_title AS job_title, RHS.min_salary AS min_salary, RHS.max_salary AS max_salary FROM (SELECT job_id, AVG(salary) AS meansalary FROM employees GROUP BY job_id) AS LHS INNER JOIN jobs AS RHS ON (LHS.job_id = RHS.job_id)) ORDER BY job_title, avg_salary_ NULLS LAST;

/*
Gold Result:
('job_d027ff', 0.03)
('job_d027ff', 0.049999999999999996)
('t2__3b16d6', 0.015)
*/

-- Prediction Query
SELECT job_title, AVG(salary) FROM employees AS T1 JOIN jobs AS T2 ON T1.job_id = T2.job_id GROUP BY T2.job_title;

/*
Prediction Result:
('job_d027ff', 0.045)
('t2__3b16d6', 0.015)
*/