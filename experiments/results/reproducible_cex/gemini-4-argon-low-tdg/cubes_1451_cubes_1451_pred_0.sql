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
-- DATASET 2
-- Tests duplicate preservation (SELECT vs SELECT DISTINCT), 1-to-N department-to-employee relationships,
-- primary sort order (first_name ASC), secondary tie-breaker sort order (department_name ASC),
-- and NULLS LAST behavior on department_name when first_name is tied.
INSERT INTO jobs (JOB_ID, JOB_TITLE, MIN_SALARY, MAX_SALARY) VALUES ('J1', 'Analyst', 40000, 80000);
INSERT INTO departments (DEPARTMENT_ID, DEPARTMENT_NAME, MANAGER_ID, LOCATION_ID) VALUES (10, 'Zebra_Dept', 101, 1000);
INSERT INTO departments (DEPARTMENT_ID, DEPARTMENT_NAME, MANAGER_ID, LOCATION_ID) VALUES (20, 'Alpha_Dept', 102, 1000);
INSERT INTO departments (DEPARTMENT_ID, DEPARTMENT_NAME, MANAGER_ID, LOCATION_ID) VALUES (30, NULL, 103, 1000);
INSERT INTO employees (EMPLOYEE_ID, JOB_ID, DEPARTMENT_ID, FIRST_NAME, LAST_NAME, EMAIL, PHONE_NUMBER, HIRE_DATE, SALARY, COMMISSION_PCT, MANAGER_ID) VALUES (1, 'J1', 10, 'Aaron', 'A', 'e1', '111', '2021-01-01', 50000, NULL, NULL);
INSERT INTO employees (EMPLOYEE_ID, JOB_ID, DEPARTMENT_ID, FIRST_NAME, LAST_NAME, EMAIL, PHONE_NUMBER, HIRE_DATE, SALARY, COMMISSION_PCT, MANAGER_ID) VALUES (2, 'J1', 20, 'Aaron', 'B', 'e2', '222', '2021-01-02', 50000, NULL, NULL);
INSERT INTO employees (EMPLOYEE_ID, JOB_ID, DEPARTMENT_ID, FIRST_NAME, LAST_NAME, EMAIL, PHONE_NUMBER, HIRE_DATE, SALARY, COMMISSION_PCT, MANAGER_ID) VALUES (3, 'J1', 30, 'Aaron', 'C', 'e3', '333', '2021-01-03', 50000, NULL, NULL);
INSERT INTO employees (EMPLOYEE_ID, JOB_ID, DEPARTMENT_ID, FIRST_NAME, LAST_NAME, EMAIL, PHONE_NUMBER, HIRE_DATE, SALARY, COMMISSION_PCT, MANAGER_ID) VALUES (4, 'J1', 20, 'Aaron', 'D', 'e4', '444', '2021-01-04', 60000, NULL, NULL);
INSERT INTO employees (EMPLOYEE_ID, JOB_ID, DEPARTMENT_ID, FIRST_NAME, LAST_NAME, EMAIL, PHONE_NUMBER, HIRE_DATE, SALARY, COMMISSION_PCT, MANAGER_ID) VALUES (5, 'J1', 10, 'Zack', 'E', 'e5', '555', '2021-01-05', 50000, NULL, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT first_name, department_name FROM (SELECT LHS.department_id AS department_id, LHS.department_name AS department_name, LHS.manager_id AS manager_id, LHS.location_id AS location_id, RHS.employee_id AS employee_id, RHS.first_name AS first_name, RHS.last_name AS last_name, RHS.email AS email, RHS.phone_number AS phone_number, RHS.hire_date AS hire_date, RHS.job_id AS job_id, RHS.salary AS salary, RHS.commission_pct AS commission_pct, RHS.manager_id AS manager_id_other FROM departments AS LHS INNER JOIN employees AS RHS ON (LHS.department_id = RHS.department_id)) ORDER BY first_name, department_name NULLS LAST;

/*
Gold Result:
('Aaron', 'Alpha_Dept')
('Aaron', 'Alpha_Dept')
('Aaron', 'Zebra_Dept')
('Aaron', None)
('Zack', 'Zebra_Dept')
*/

-- Prediction Query
SELECT T1.first_name, T2.department_name FROM employees AS T1 JOIN departments AS T2 ON T1.department_id = T2.department_id;

/*
Prediction Result:
('Aaron', 'Zebra_Dept')
('Aaron', 'Alpha_Dept')
('Aaron', None)
('Aaron', 'Alpha_Dept')
('Zack', 'Zebra_Dept')
*/