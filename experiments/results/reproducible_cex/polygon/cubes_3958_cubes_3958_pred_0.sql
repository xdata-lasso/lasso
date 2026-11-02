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
INSERT INTO "Document_Types" ("document_type_code", "document_description") VALUES ('16', '25');
INSERT INTO "Document_Types" ("document_type_code", "document_description") VALUES ('15', '25');
INSERT INTO "Documents" ("document_id", "grant_id", "document_type_code", "sent_date", "response_received_date", "other_details") VALUES (18, 20, '15', 25, 25, '25');
INSERT INTO "Documents" ("document_id", "grant_id", "document_type_code", "sent_date", "response_received_date", "other_details") VALUES (17, 19, '16', 25, 25, '25');
INSERT INTO "Grants" ("grant_id", "organisation_id", "grant_amount", "grant_start_date", "grant_end_date", "other_details") VALUES (19, 21, 25, 25, 25, '25');
INSERT INTO "Grants" ("grant_id", "organisation_id", "grant_amount", "grant_start_date", "grant_end_date", "other_details") VALUES (20, NULL, 25, 25, 25, '25');
INSERT INTO "Organisation_Types" ("organisation_type", "organisation_type_description") VALUES ('22', '25');
INSERT INTO "Organisations" ("organisation_id", "organisation_type", "organisation_details") VALUES (21, '22', '25');
INSERT INTO "Project_Outcomes" ("outcome_code", "project_id", "outcome_details") VALUES ('24', 25, '25');
INSERT INTO "Project_Staff" ("staff_id", "role_code", "project_id", "date_from", "date_to", "other_details") VALUES (27, '29', 25, NULL, 25, '25');
INSERT INTO "Project_Staff" ("staff_id", "role_code", "project_id", "date_from", "date_to", "other_details") VALUES (26, '28', 25, NULL, 25, '25');
INSERT INTO "Projects" ("project_id", "organisation_id", "project_details") VALUES (25, 21, '25');
INSERT INTO "Research_Outcomes" ("outcome_code", "outcome_description") VALUES ('23', '25');
INSERT INTO "Research_Outcomes" ("outcome_code", "outcome_description") VALUES ('24', '25');
INSERT INTO "Research_Staff" ("staff_id", "employer_organisation_id", "staff_details") VALUES (31, 21, '25');
INSERT INTO "Research_Staff" ("staff_id", "employer_organisation_id", "staff_details") VALUES (30, 21, '25');
INSERT INTO "Staff_Roles" ("role_code", "role_description") VALUES ('28', '25');
INSERT INTO "Staff_Roles" ("role_code", "role_description") VALUES ('29', '25');
INSERT INTO "Tasks" ("task_id", "project_id", "task_details", "eg agree objectives") VALUES (33, 25, '25', '25');
INSERT INTO "Tasks" ("task_id", "project_id", "task_details", "eg agree objectives") VALUES (32, 25, '25', '25');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT mindate_from AS date_from FROM (SELECT MIN(date_from) AS mindate_from FROM project_staff) ORDER BY date_from;

/*
Gold Result:
(None,)
*/

-- Prediction Query
SELECT date_from FROM Project_Staff ORDER BY date_from ASC, Project_Staff.staff_id NULLS LAST LIMIT 1;

/*
Prediction Result:
(None,)
*/