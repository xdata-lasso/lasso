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
-- DATASET 1
INSERT INTO regions (REGION_ID, REGION_NAME) VALUES (1, 'Americas');
INSERT INTO countries (COUNTRY_ID, REGION_ID, COUNTRY_NAME) VALUES ('US', 1, 'United States');
INSERT INTO locations (LOCATION_ID, COUNTRY_ID, STREET_ADDRESS, POSTAL_CODE, CITY, STATE_PROVINCE) VALUES (1000, 'US', '100 Main St', '10001', 'New York', 'NY');
INSERT INTO locations (LOCATION_ID, COUNTRY_ID, STREET_ADDRESS, POSTAL_CODE, CITY, STATE_PROVINCE) VALUES (2000, 'US', '200 Market St', '94105', 'San Francisco', 'CA');
INSERT INTO locations (LOCATION_ID, COUNTRY_ID, STREET_ADDRESS, POSTAL_CODE, CITY, STATE_PROVINCE) VALUES (3000, 'US', '300 Pine St', '98101', 'Seattle', 'WA');
INSERT INTO departments (DEPARTMENT_ID, DEPARTMENT_NAME, MANAGER_ID, LOCATION_ID) VALUES (10, 'Finance', 101, 1000);
INSERT INTO departments (DEPARTMENT_ID, DEPARTMENT_NAME, MANAGER_ID, LOCATION_ID) VALUES (20, 'Unassigned_Null_Loc', 102, NULL);
INSERT INTO departments (DEPARTMENT_ID, DEPARTMENT_NAME, MANAGER_ID, LOCATION_ID) VALUES (30, 'Unassigned_Bad_Loc', 103, 9999);
INSERT INTO departments (DEPARTMENT_ID, DEPARTMENT_NAME, MANAGER_ID, LOCATION_ID) VALUES (1000, 'Engineering', 2000, 3000);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT department_name, city, state_province FROM (SELECT LHS.department_id AS department_id, LHS.department_name AS department_name, LHS.manager_id AS manager_id, LHS.location_id AS location_id, RHS.street_address AS street_address, RHS.postal_code AS postal_code, RHS.city AS city, RHS.state_province AS state_province, RHS.country_id AS country_id FROM departments AS LHS INNER JOIN locations AS RHS ON (LHS.location_id = RHS.location_id)) ORDER BY department_name, city NULLS LAST, state_province NULLS LAST;

/*
Gold Result:
('Engineering', 'Seattle', 'WA')
('Finance', 'New York', 'NY')
*/

-- Prediction Query
SELECT T1.department_name, T2.city, T2.state_province FROM departments AS T1 JOIN locations AS T2 ON T2.location_id = T1.location_id;

/*
Prediction Result:
('Finance', 'New York', 'NY')
('Engineering', 'Seattle', 'WA')
*/