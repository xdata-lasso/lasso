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
INSERT INTO "Document_Types" ("document_type_code", "document_description") VALUES ('23', '37');
INSERT INTO "Document_Types" ("document_type_code", "document_description") VALUES ('22', '37');
INSERT INTO "Documents" ("document_id", "grant_id", "document_type_code", "sent_date", "response_received_date", "other_details") VALUES (25, 26, NULL, 37, 37, '37');
INSERT INTO "Documents" ("document_id", "grant_id", "document_type_code", "sent_date", "response_received_date", "other_details") VALUES (24, 27, '22', 37, 37, '37');
INSERT INTO "Grants" ("grant_id", "organisation_id", "grant_amount", "grant_start_date", "grant_end_date", "other_details") VALUES (26, NULL, 37, 37, 37, '37');
INSERT INTO "Grants" ("grant_id", "organisation_id", "grant_amount", "grant_start_date", "grant_end_date", "other_details") VALUES (27, 37, 37, 37, 37, '37');
INSERT INTO "Organisation_Types" ("organisation_type", "organisation_type_description") VALUES ('29', '37');
INSERT INTO "Organisation_Types" ("organisation_type", "organisation_type_description") VALUES ('28', '37');
INSERT INTO "Organisations" ("organisation_id", "organisation_type", "organisation_details") VALUES (37, NULL, '47');
INSERT INTO "Organisations" ("organisation_id", "organisation_type", "organisation_details") VALUES (38, '29', '46');
INSERT INTO "Project_Outcomes" ("outcome_code", "project_id", "outcome_details") VALUES (NULL, 32, '37');
INSERT INTO "Project_Outcomes" ("outcome_code", "project_id", "outcome_details") VALUES ('30', 33, '37');
INSERT INTO "Project_Staff" ("staff_id", "role_code", "project_id", "date_from", "date_to", "other_details") VALUES (37, '34', 32, 37, 37, '37');
INSERT INTO "Projects" ("project_id", "organisation_id", "project_details") VALUES (32, NULL, '37');
INSERT INTO "Projects" ("project_id", "organisation_id", "project_details") VALUES (33, 38, '37');
INSERT INTO "Research_Outcomes" ("outcome_code", "outcome_description") VALUES ('30', '37');
INSERT INTO "Research_Outcomes" ("outcome_code", "outcome_description") VALUES ('31', '37');
INSERT INTO "Research_Staff" ("staff_id", "employer_organisation_id", "staff_details") VALUES (48, 37, '47');
INSERT INTO "Research_Staff" ("staff_id", "employer_organisation_id", "staff_details") VALUES (36, 38, '45');
INSERT INTO "Staff_Roles" ("role_code", "role_description") VALUES ('34', '37');
INSERT INTO "Staff_Roles" ("role_code", "role_description") VALUES ('35', '37');
INSERT INTO "Tasks" ("task_id", "project_id", "task_details", "eg agree objectives") VALUES (40, 32, '37', '37');
INSERT INTO "Tasks" ("task_id", "project_id", "task_details", "eg agree objectives") VALUES (39, 33, '37', '37');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT organisation_type FROM (SELECT organisation_id, organisation_type, organisation_details, staff_id, employer_organisation_id, organisation_details AS staff_details FROM (SELECT LHS.organisation_id AS organisation_id, LHS.organisation_type AS organisation_type, LHS.organisation_details AS organisation_details, RHS.staff_id AS staff_id, RHS.employer_organisation_id AS employer_organisation_id FROM organisations AS LHS INNER JOIN research_staff AS RHS ON (LHS.organisation_details = RHS.staff_details))) ORDER BY organisation_type;

/*
Gold Result:
(None,)
*/

-- Prediction Query
SELECT T1.organisation_type FROM Organisations AS T1 JOIN Research_Staff AS T2 ON T1.organisation_id = T2.employer_organisation_id GROUP BY T1.organisation_type ORDER BY COUNT(*) DESC, T1.organisation_type NULLS LAST LIMIT 1;

/*
Prediction Result:
('29',)
*/