-- Schema DDL
CREATE TABLE "Document_Types" ("document_type_code" TEXT(10) PRIMARY KEY, "document_description" TEXT(255));

CREATE TABLE "Documents" ("document_id" INTEGER PRIMARY KEY, "grant_id" INTEGER, "document_type_code" TEXT(10), "sent_date" DATETIME, "response_received_date" DATETIME, "other_details" TEXT(255), FOREIGN KEY ("grant_id") REFERENCES "Grants" ("grant_id"), FOREIGN KEY ("document_type_code") REFERENCES "Document_Types" ("document_type_code"));

CREATE TABLE "Grants" ("grant_id" INTEGER PRIMARY KEY, "organisation_id" INTEGER, "grant_amount" REAL(19, 4), "grant_start_date" DATETIME, "grant_end_date" DATETIME, "other_details" TEXT(255), FOREIGN KEY ("organisation_id") REFERENCES "Organisations" ("organisation_id"));

CREATE TABLE "Organisation_Types" ("organisation_type" TEXT(10) PRIMARY KEY, "organisation_type_description" TEXT(255));

CREATE TABLE "Organisations" ("organisation_id" INTEGER PRIMARY KEY, "organisation_type" TEXT(10), "organisation_details" TEXT(255), FOREIGN KEY ("organisation_type") REFERENCES "Organisation_Types" ("organisation_type"));

CREATE TABLE "Project_Outcomes" ("outcome_code" TEXT(10), "project_id" INTEGER, "outcome_details" TEXT(255), FOREIGN KEY ("outcome_code") REFERENCES "Research_Outcomes" ("outcome_code"), FOREIGN KEY ("project_id") REFERENCES "Projects" ("project_id"));

CREATE TABLE "Project_Staff" ("staff_id" REAL PRIMARY KEY, "role_code" TEXT(10), "project_id" INTEGER, "date_from" DATETIME, "date_to" DATETIME, "other_details" TEXT(255), FOREIGN KEY ("role_code") REFERENCES "Staff_Roles" ("role_code"), FOREIGN KEY ("project_id") REFERENCES "Projects" ("project_id"));

CREATE TABLE "Projects" ("project_id" INTEGER PRIMARY KEY, "organisation_id" INTEGER, "project_details" TEXT(255), FOREIGN KEY ("organisation_id") REFERENCES "Organisations" ("organisation_id"));

CREATE TABLE "Research_Outcomes" ("outcome_code" TEXT(10) PRIMARY KEY, "outcome_description" TEXT(255));

CREATE TABLE "Research_Staff" ("staff_id" INTEGER PRIMARY KEY, "employer_organisation_id" INTEGER, "staff_details" TEXT(255), FOREIGN KEY ("employer_organisation_id") REFERENCES "Organisations" ("organisation_id"));

CREATE TABLE "Staff_Roles" ("role_code" TEXT(10) PRIMARY KEY, "role_description" TEXT(255));

CREATE TABLE "Tasks" ("task_id" INTEGER PRIMARY KEY, "project_id" INTEGER, "task_details" TEXT(255), "eg Agree Objectives" TEXT(1), FOREIGN KEY ("project_id") REFERENCES "Projects" ("project_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "Organisation_Types" ("organisation_type", "organisation_type_description") VALUES ('UNI', 'University');
INSERT INTO "Organisations" ("organisation_id", "organisation_type", "organisation_details") VALUES (1, 'UNI', 'Main University');
INSERT INTO "Projects" ("project_id", "organisation_id", "project_details") VALUES (10, 1, 'AI Research');
INSERT INTO "Staff_Roles" ("role_code", "role_description") VALUES ('researcher', 'Research Scientist');
INSERT INTO "Staff_Roles" ("role_code", "role_description") VALUES ('manager', 'Project Manager');
INSERT INTO "Research_Staff" ("staff_id", "employer_organisation_id", "staff_details") VALUES (2, 1, 'Alice');
INSERT INTO "Research_Staff" ("staff_id", "employer_organisation_id", "staff_details") VALUES (5, 1, 'Bob');
INSERT INTO "Research_Staff" ("staff_id", "employer_organisation_id", "staff_details") VALUES (8, 1, 'Charlie');
INSERT INTO "Research_Staff" ("staff_id", "employer_organisation_id", "staff_details") VALUES (1, 1, 'Diana');
INSERT INTO "Research_Staff" ("staff_id", "employer_organisation_id", "staff_details") VALUES (3, 1, 'Evan');
INSERT INTO "Project_Staff" ("staff_id", "role_code", "project_id", "date_from", "date_to", "other_details") VALUES (1, 'researcher', 10, '2023-05-01 00:00:00', '2023-11-01 00:00:00', 'Late start');
INSERT INTO "Project_Staff" ("staff_id", "role_code", "project_id", "date_from", "date_to", "other_details") VALUES (2, 'researcher', 10, '2023-01-01 00:00:00', '2023-09-01 00:00:00', 'Tie date_from 1');
INSERT INTO "Project_Staff" ("staff_id", "role_code", "project_id", "date_from", "date_to", "other_details") VALUES (5, 'researcher', 10, '2023-01-01 00:00:00', '2023-03-01 00:00:00', 'Tie date_from 2');
INSERT INTO "Project_Staff" ("staff_id", "role_code", "project_id", "date_from", "date_to", "other_details") VALUES (8, 'researcher', 10, '2023-01-01 00:00:00', '2023-12-01 00:00:00', 'Tie date_from 3');
INSERT INTO "Project_Staff" ("staff_id", "role_code", "project_id", "date_from", "date_to", "other_details") VALUES (3, 'manager', 10, '2022-01-01 00:00:00', '2022-12-31 00:00:00', 'Non-researcher');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "date_from", "date_to" FROM "project_staff" WHERE ("role_code" = 'researcher') ORDER BY date_from, project_staff.staff_id NULLS LAST;

/*
Gold Result:
('2023-01-01 00:00:00', '2023-09-01 00:00:00')
('2023-01-01 00:00:00', '2023-03-01 00:00:00')
('2023-01-01 00:00:00', '2023-12-01 00:00:00')
('2023-05-01 00:00:00', '2023-11-01 00:00:00')
*/

-- Prediction Query
SELECT date_from, date_to FROM Project_Staff WHERE role_code = 'researcher';

/*
Prediction Result:
('2023-05-01 00:00:00', '2023-11-01 00:00:00')
('2023-01-01 00:00:00', '2023-09-01 00:00:00')
('2023-01-01 00:00:00', '2023-03-01 00:00:00')
('2023-01-01 00:00:00', '2023-12-01 00:00:00')
*/