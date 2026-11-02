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
INSERT INTO "departments" ("department_id", "department_name", "manager_id", "location_id") VALUES (1019.5, 'Victoria Wyatt', 1021.5, 1023.5);
INSERT INTO "departments" ("department_id", "department_name", "manager_id", "location_id") VALUES (1020.5, 'Jamie Chavez', 1028.5, 1032.5);
INSERT INTO "departments" ("department_id", "department_name", "manager_id", "location_id") VALUES (1037.5, 'Jessica Silva', 1039.5, 1041.5);
INSERT INTO "departments" ("department_id", "department_name", "manager_id", "location_id") VALUES (1038.5, 'Zachary Taylor', 1046.5, 1050.5);
INSERT INTO "departments" ("department_id", "department_name", "manager_id", "location_id") VALUES (1071.5, 'Jack Galloway', 1056.5, 1058.5);
INSERT INTO "departments" ("department_id", "department_name", "manager_id", "location_id") VALUES (1055.5, 'Cynthia Allen', 1063.5, 1067.5);
INSERT INTO "jobs" ("job_id", "job_title", "min_salary", "max_salary") VALUES ('Medical sales representative', 'Metallurgist', 1025.5, 1027.5);
INSERT INTO "jobs" ("job_id", "job_title", "min_salary", "max_salary") VALUES ('Designer, textile', 'Marine scientist', 1032.5, 1036.5);
INSERT INTO "jobs" ("job_id", "job_title", "min_salary", "max_salary") VALUES ('Research officer, political party', 'Art gallery manager', 1043.5, 1045.5);
INSERT INTO "jobs" ("job_id", "job_title", "min_salary", "max_salary") VALUES ('Chemist, analytical', 'Clinical molecular geneticist', 1050.5, 1054.5);
INSERT INTO "jobs" ("job_id", "job_title", "min_salary", "max_salary") VALUES ('Tax adviser', 'Chartered certified accountant', 1060.5, 1062.5);
INSERT INTO "jobs" ("job_id", "job_title", "min_salary", "max_salary") VALUES ('Careers information officer', 'Radiographer, diagnostic', 1067.5, 1071.5);
INSERT INTO "employees" ("employee_id", "job_id", "department_id", "first_name", "last_name", "email", "phone_number", "hire_date", "salary", "commission_pct", "manager_id") VALUES (1029.5, 'Medical sales representative', 1019.5, 'Jason', 'Zuniga', 'amandasanchez@example.com', '+1-335-503-0564', '1976-07-07', 1031.5, 1033.5, 1035.5);
INSERT INTO "employees" ("employee_id", "job_id", "department_id", "first_name", "last_name", "email", "phone_number", "hire_date", "salary", "commission_pct", "manager_id") VALUES (1030.5, 'Medical sales representative', 1019.5, 'Joseph', 'Wong', 'onelson@example.net', '001-553-676-7242', '1976-07-08', 1050.5, 1054.5, 1058.5);
INSERT INTO "employees" ("employee_id", "job_id", "department_id", "first_name", "last_name", "email", "phone_number", "hire_date", "salary", "commission_pct", "manager_id") VALUES (1047.5, 'Research officer, political party', 1037.5, 'Eric', 'Becker', 'djames@example.net', '+1-645-414-6270', '1982-02-13', 1049.5, 1051.5, 1053.5);
INSERT INTO "employees" ("employee_id", "job_id", "department_id", "first_name", "last_name", "email", "phone_number", "hire_date", "salary", "commission_pct", "manager_id") VALUES (1048.5, 'Research officer, political party', 1037.5, 'Ernest', 'Carlson', 'tasha01@example.net', '914.289.3252x88095', '1982-02-14', 1068.5, 1072.5, 1076.5);
INSERT INTO "employees" ("employee_id", "job_id", "department_id", "first_name", "last_name", "email", "phone_number", "hire_date", "salary", "commission_pct", "manager_id") VALUES (1072.5, 'Tax adviser', 1037.5, 'Lisa', 'Patel', 'karroyo@example.com', '001-734-265-7871x331', '1988-08-19', 1065.5, 1067.5, 1069.5);
INSERT INTO "employees" ("employee_id", "job_id", "department_id", "first_name", "last_name", "email", "phone_number", "hire_date", "salary", "commission_pct", "manager_id") VALUES (1064.5, 'Tax adviser', 1037.5, 'Tiffany', 'Martinez', 'ibrandt@example.net', '001-383-293-0103', '1988-08-20', 1084.5, 1088.5, 1092.5);
INSERT INTO "job_history" ("employee_id", "start_date", "job_id", "department_id", "end_date") VALUES (1029.5, '1978-09-09', 'Medical sales representative', 1019.5, '1980-11-11');
INSERT INTO "job_history" ("employee_id", "start_date", "job_id", "department_id", "end_date") VALUES (1029.5, '1978-09-10', 'Designer, textile', 1019.5, '1980-11-12');
INSERT INTO "job_history" ("employee_id", "start_date", "job_id", "department_id", "end_date") VALUES (1047.5, '1984-04-15', NULL, 1037.5, '1986-06-17');
INSERT INTO "job_history" ("employee_id", "start_date", "job_id", "department_id", "end_date") VALUES (1047.5, '1984-04-16', NULL, 1037.5, '1986-06-18');
INSERT INTO "job_history" ("employee_id", "start_date", "job_id", "department_id", "end_date") VALUES (1047.5, '1990-10-21', 'Tax adviser', 1037.5, '1992-01-23');
INSERT INTO "job_history" ("employee_id", "start_date", "job_id", "department_id", "end_date") VALUES (1047.5, '1990-10-22', 'Careers information officer', 1037.5, '1992-01-24');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT employee_id FROM (SELECT department_id, employee_id, COUNT(*) AS n FROM job_history GROUP BY department_id, employee_id) WHERE (n = 2) ORDER BY employee_id;

/*
Gold Result:
(1029.5,)
*/

-- Prediction Query
SELECT employee_id FROM job_history GROUP BY employee_id HAVING COUNT(*) >= 2;

/*
Prediction Result:
(1029.5,)
(1047.5,)
*/