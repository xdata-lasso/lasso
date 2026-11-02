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
-- Tests standard anti-join, duplicate project_details (SELECT vs SELECT DISTINCT), ordering (ASC vs DESC), and multiple outcomes per project.
INSERT INTO "Organisation_Types" ("organisation_type", "organisation_type_description") VALUES ('UNI', 'University');
INSERT INTO "Organisations" ("organisation_id", "organisation_type", "organisation_details") VALUES (1, 'UNI', 'Org 1');
INSERT INTO "Organisations" ("organisation_id", "organisation_type", "organisation_details") VALUES (2, 'UNI', 'Org 2');
INSERT INTO "Research_Outcomes" ("outcome_code", "outcome_description") VALUES ('OUT1', 'Outcome 1');
INSERT INTO "Research_Outcomes" ("outcome_code", "outcome_description") VALUES ('OUT2', 'Outcome 2');
INSERT INTO "Projects" ("project_id", "organisation_id", "project_details") VALUES (1, 1, 'Zeta Project');
INSERT INTO "Projects" ("project_id", "organisation_id", "project_details") VALUES (2, 1, 'Alpha Project');
INSERT INTO "Projects" ("project_id", "organisation_id", "project_details") VALUES (3, 2, 'Alpha Project');
INSERT INTO "Projects" ("project_id", "organisation_id", "project_details") VALUES (4, 1, 'Beta Project');
INSERT INTO "Projects" ("project_id", "organisation_id", "project_details") VALUES (5, 2, 'Gamma Project');
INSERT INTO "Project_Outcomes" ("outcome_code", "project_id", "outcome_details") VALUES ('OUT1', 4, 'Beta Outcome 1');
INSERT INTO "Project_Outcomes" ("outcome_code", "project_id", "outcome_details") VALUES ('OUT2', 4, 'Beta Outcome 2');
INSERT INTO "Project_Outcomes" ("outcome_code", "project_id", "outcome_details") VALUES ('OUT1', 5, 'Gamma Outcome 1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT project_details FROM (SELECT * FROM projects AS LHS WHERE NOT EXISTS(SELECT 1 FROM project_outcomes AS RHS WHERE (LHS.project_id = RHS.project_id))) ORDER BY project_details;

/*
Gold Result:
('Alpha Project',)
('Alpha Project',)
('Zeta Project',)
*/

-- Prediction Query
SELECT project_details FROM Projects WHERE NOT project_id IN (SELECT project_id FROM Project_outcomes);

/*
Prediction Result:
('Zeta Project',)
('Alpha Project',)
('Alpha Project',)
*/