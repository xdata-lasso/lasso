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
-- Tests critical distinction between GROUP BY job_id vs GROUP BY job_title (and SELECT DISTINCT).
-- Two different JOB_IDs share the exact same JOB_TITLE.
-- Also tests secondary ORDER BY avg_salary_ ASC vs DESC when job_title is tied, and NULLS LAST when avg_salary_ is NULL.
INSERT INTO "jobs" ("JOB_ID", "JOB_TITLE", "MIN_SALARY", "MAX_SALARY") VALUES ('J_ANA1', 'Analyst', 4000, 8000);
INSERT INTO "jobs" ("JOB_ID", "JOB_TITLE", "MIN_SALARY", "MAX_SALARY") VALUES ('J_ANA2', 'Analyst', 5000, 9000);
INSERT INTO "jobs" ("JOB_ID", "JOB_TITLE", "MIN_SALARY", "MAX_SALARY") VALUES ('J_ANA3', 'Analyst', 3000, 6000);
INSERT INTO "jobs" ("JOB_ID", "JOB_TITLE", "MIN_SALARY", "MAX_SALARY") VALUES ('J_ANA4', 'Analyst', 3000, 6000);
INSERT INTO "employees" ("EMPLOYEE_ID", "JOB_ID", "SALARY") VALUES (1, 'J_ANA1', 8000);
INSERT INTO "employees" ("EMPLOYEE_ID", "JOB_ID", "SALARY") VALUES (2, 'J_ANA2', 4000);
INSERT INTO "employees" ("EMPLOYEE_ID", "JOB_ID", "SALARY") VALUES (3, 'J_ANA2', 4000);
INSERT INTO "employees" ("EMPLOYEE_ID", "JOB_ID", "SALARY") VALUES (4, 'J_ANA3', NULL);
INSERT INTO "employees" ("EMPLOYEE_ID", "JOB_ID", "SALARY") VALUES (5, 'J_ANA4', 8000);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT job_title, meansalary AS avg_salary_ FROM (SELECT LHS.job_id AS job_id, LHS.meansalary AS meansalary, RHS.job_title AS job_title, RHS.min_salary AS min_salary, RHS.max_salary AS max_salary FROM (SELECT job_id, AVG(salary) AS meansalary FROM employees GROUP BY job_id) AS LHS INNER JOIN jobs AS RHS ON (LHS.job_id = RHS.job_id)) ORDER BY job_title, avg_salary_ NULLS LAST;

/*
Gold Result:
('Analyst', 4000.0)
('Analyst', 8000.0)
('Analyst', 8000.0)
('Analyst', None)
*/

-- Prediction Query
SELECT job_title, AVG(salary) FROM employees AS T1 JOIN jobs AS T2 ON T1.job_id = T2.job_id GROUP BY T2.job_title;

/*
Prediction Result:
('Analyst', 6000.0)
*/