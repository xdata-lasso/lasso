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
-- DATASET 2
-- Tie for minimum date_from, NULLs in foreign keys, and NULLs in date_from.
-- Tests INNER JOIN vs no join, WHERE date_from = (SELECT MIN(...)) without DISTINCT, and NULL handling in MIN().
INSERT INTO "Project_Staff" ("staff_id", "role_code", "project_id", "date_from", "date_to", "other_details") VALUES (1.0, NULL, NULL, NULL, '2018-01-01 00:00:00', 'Null date_from');
INSERT INTO "Project_Staff" ("staff_id", "role_code", "project_id", "date_from", "date_to", "other_details") VALUES (2.0, NULL, NULL, '2020-01-01 00:00:00', '2021-01-01 00:00:00', 'Min date_from tie 1');
INSERT INTO "Project_Staff" ("staff_id", "role_code", "project_id", "date_from", "date_to", "other_details") VALUES (3.0, NULL, NULL, '2020-01-01 00:00:00', '2022-01-01 00:00:00', 'Min date_from tie 2');
INSERT INTO "Project_Staff" ("staff_id", "role_code", "project_id", "date_from", "date_to", "other_details") VALUES (4.0, NULL, NULL, '2021-06-01 00:00:00', '2022-06-01 00:00:00', 'Later date_from');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT mindate_from AS date_from FROM (SELECT MIN(date_from) AS mindate_from FROM project_staff) ORDER BY date_from;

/*
Gold Result:
('2020-01-01 00:00:00',)
*/

-- Prediction Query
SELECT date_from FROM Project_Staff ORDER BY date_from ASC, Project_Staff.staff_id NULLS LAST LIMIT 1;

/*
Prediction Result:
(None,)
*/