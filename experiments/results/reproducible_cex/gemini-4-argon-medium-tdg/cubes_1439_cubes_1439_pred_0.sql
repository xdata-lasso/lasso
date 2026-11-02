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
-- Tests basic count logic (n=1, n=2, n=3), grouping by both (department_id, employee_id) vs grouping by only employee_id or only department_id, and ordering.
INSERT INTO "departments" ("DEPARTMENT_ID", "DEPARTMENT_NAME") VALUES (10, 'Admin');
INSERT INTO "departments" ("DEPARTMENT_ID", "DEPARTMENT_NAME") VALUES (20, 'Sales');
INSERT INTO "departments" ("DEPARTMENT_ID", "DEPARTMENT_NAME") VALUES (30, 'IT');
INSERT INTO "jobs" ("JOB_ID", "JOB_TITLE") VALUES ('J1', 'Clerk');
INSERT INTO "jobs" ("JOB_ID", "JOB_TITLE") VALUES ('J2', 'Manager');
INSERT INTO "employees" ("EMPLOYEE_ID", "JOB_ID", "DEPARTMENT_ID", "LAST_NAME", "EMAIL", "HIRE_DATE") VALUES (101, 'J1', 10, 'Smith', 'SMITH', '2020-01-01');
INSERT INTO "employees" ("EMPLOYEE_ID", "JOB_ID", "DEPARTMENT_ID", "LAST_NAME", "EMAIL", "HIRE_DATE") VALUES (102, 'J1', 10, 'Jones', 'JONES', '2020-01-01');
INSERT INTO "employees" ("EMPLOYEE_ID", "JOB_ID", "DEPARTMENT_ID", "LAST_NAME", "EMAIL", "HIRE_DATE") VALUES (103, 'J1', 20, 'Williams', 'WILLIAMS', '2020-01-01');
INSERT INTO "employees" ("EMPLOYEE_ID", "JOB_ID", "DEPARTMENT_ID", "LAST_NAME", "EMAIL", "HIRE_DATE") VALUES (104, 'J1', 30, 'Brown', 'BROWN', '2020-01-01');
INSERT INTO "employees" ("EMPLOYEE_ID", "JOB_ID", "DEPARTMENT_ID", "LAST_NAME", "EMAIL", "HIRE_DATE") VALUES (105, 'J2', 30, 'Davis', 'DAVIS', '2020-01-01');
-- Employee 105: 2 records in the SAME department (Dept 30), with the SAME job_id -> Should be returned (tests COUNT(*) vs COUNT(DISTINCT job_id) and ORDER BY with 102)
INSERT INTO "job_history" ("EMPLOYEE_ID", "START_DATE", "END_DATE", "JOB_ID", "DEPARTMENT_ID") VALUES (105, '2018-01-01', '2018-06-01', 'J1', 30);
INSERT INTO "job_history" ("EMPLOYEE_ID", "START_DATE", "END_DATE", "JOB_ID", "DEPARTMENT_ID") VALUES (105, '2019-01-01', '2019-06-01', 'J1', 30);
-- Employee 102: 2 records in the SAME department (Dept 10), different jobs -> Should be returned
INSERT INTO "job_history" ("EMPLOYEE_ID", "START_DATE", "END_DATE", "JOB_ID", "DEPARTMENT_ID") VALUES (102, '2018-01-01', '2018-06-01', 'J1', 10);
INSERT INTO "job_history" ("EMPLOYEE_ID", "START_DATE", "END_DATE", "JOB_ID", "DEPARTMENT_ID") VALUES (102, '2019-01-01', '2019-06-01', 'J2', 10);
-- Employee 101: 1 record in Dept 10, 1 record in Dept 20 (Total=2, but n=1 per dept) -> Should NOT be returned (kills GROUP BY employee_id only)
INSERT INTO "job_history" ("EMPLOYEE_ID", "START_DATE", "END_DATE", "JOB_ID", "DEPARTMENT_ID") VALUES (101, '2018-01-01', '2018-06-01', 'J1', 10);
INSERT INTO "job_history" ("EMPLOYEE_ID", "START_DATE", "END_DATE", "JOB_ID", "DEPARTMENT_ID") VALUES (101, '2019-01-01', '2019-06-01', 'J1', 20);
-- Employee 103: 1 record in Dept 20 (Note: Dept 20 now has 2 records total: one from 101, one from 103) -> Should NOT be returned (kills GROUP BY department_id only)
INSERT INTO "job_history" ("EMPLOYEE_ID", "START_DATE", "END_DATE", "JOB_ID", "DEPARTMENT_ID") VALUES (103, '2018-01-01', '2018-06-01', 'J1', 20);
-- Employee 104: 3 records in Dept 30 -> Should NOT be returned (kills n >= 2 or n > 1)
INSERT INTO "job_history" ("EMPLOYEE_ID", "START_DATE", "END_DATE", "JOB_ID", "DEPARTMENT_ID") VALUES (104, '2017-01-01', '2017-06-01', 'J1', 30);
INSERT INTO "job_history" ("EMPLOYEE_ID", "START_DATE", "END_DATE", "JOB_ID", "DEPARTMENT_ID") VALUES (104, '2018-01-01', '2018-06-01', 'J2', 30);
INSERT INTO "job_history" ("EMPLOYEE_ID", "START_DATE", "END_DATE", "JOB_ID", "DEPARTMENT_ID") VALUES (104, '2019-01-01', '2019-06-01', 'J1', 30);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT employee_id FROM (SELECT department_id, employee_id, COUNT(*) AS n FROM job_history GROUP BY department_id, employee_id) WHERE (n = 2) ORDER BY employee_id;

/*
Gold Result:
(102.0,)
(105.0,)
*/

-- Prediction Query
SELECT employee_id FROM job_history GROUP BY employee_id HAVING COUNT(*) >= 2;

/*
Prediction Result:
(101.0,)
(102.0,)
(104.0,)
(105.0,)
*/