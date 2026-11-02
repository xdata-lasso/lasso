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
INSERT INTO "Document_Types" ("document_type_code", "document_description") VALUES ('16', '22');
INSERT INTO "Document_Types" ("document_type_code", "document_description") VALUES ('15', '22');
INSERT INTO "Documents" ("document_id", "grant_id", "document_type_code", "sent_date", "response_received_date", "other_details") VALUES (18, 20, '16', 22, 22, '22');
INSERT INTO "Documents" ("document_id", "grant_id", "document_type_code", "sent_date", "response_received_date", "other_details") VALUES (17, 19, '16', 22, 22, '22');
INSERT INTO "Grants" ("grant_id", "organisation_id", "grant_amount", "grant_start_date", "grant_end_date", "other_details") VALUES (19, 22, 22, 22, 22, '22');
INSERT INTO "Grants" ("grant_id", "organisation_id", "grant_amount", "grant_start_date", "grant_end_date", "other_details") VALUES (20, 22, 22, 22, 22, '22');
INSERT INTO "Organisation_Types" ("organisation_type", "organisation_type_description") VALUES ('24', '22');
INSERT INTO "Organisation_Types" ("organisation_type", "organisation_type_description") VALUES ('23', '22');
INSERT INTO "Organisations" ("organisation_id", "organisation_type", "organisation_details") VALUES (22, NULL, '22');
INSERT INTO "Project_Outcomes" ("outcome_code", "project_id", "outcome_details") VALUES (NULL, 27, '22');
INSERT INTO "Project_Outcomes" ("outcome_code", "project_id", "outcome_details") VALUES ('26', NULL, '22');
INSERT INTO "Project_Staff" ("staff_id", "role_code", "project_id", "date_from", "date_to", "other_details") VALUES (29, '31', 27, 22, NULL, '34');
INSERT INTO "Project_Staff" ("staff_id", "role_code", "project_id", "date_from", "date_to", "other_details") VALUES (28, '31', 27, 22, NULL, '34');
INSERT INTO "Projects" ("project_id", "organisation_id", "project_details") VALUES (27, 22, '22');
INSERT INTO "Research_Outcomes" ("outcome_code", "outcome_description") VALUES ('25', '22');
INSERT INTO "Research_Outcomes" ("outcome_code", "outcome_description") VALUES ('26', '22');
INSERT INTO "Research_Staff" ("staff_id", "employer_organisation_id", "staff_details") VALUES (33, 22, '22');
INSERT INTO "Staff_Roles" ("role_code", "role_description") VALUES ('30', '22');
INSERT INTO "Staff_Roles" ("role_code", "role_description") VALUES ('31', '22');
INSERT INTO "Tasks" ("task_id", "project_id", "task_details", "eg agree objectives") VALUES (22, 27, '22', '22');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT maxdate_to AS date_to FROM (SELECT other_details, MAX(date_to) AS maxdate_to FROM project_staff GROUP BY other_details) ORDER BY date_to;

/*
Gold Result:
(None,)
*/

-- Prediction Query
SELECT date_to FROM Project_Staff ORDER BY date_to DESC, Project_Staff.staff_id NULLS LAST LIMIT 1;

/*
Prediction Result:
(None,)
*/