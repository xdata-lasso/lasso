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
INSERT INTO Organisation_Types (organisation_type, organisation_type_description) VALUES ('OT1', 'University');
INSERT INTO Organisations (organisation_id, organisation_type, organisation_details) VALUES (1, 'OT1', 'Org 1');
INSERT INTO Projects (project_id, organisation_id, project_details) VALUES (1, 1, 'Proj 1');
INSERT INTO Projects (project_id, organisation_id, project_details) VALUES (2, 1, 'Proj 2');
INSERT INTO Research_Outcomes (outcome_code, outcome_description) VALUES ('OC1', 'Zebra');
INSERT INTO Research_Outcomes (outcome_code, outcome_description) VALUES ('OC2', 'Alpha');
INSERT INTO Research_Outcomes (outcome_code, outcome_description) VALUES ('OC3', 'Beta');
INSERT INTO Research_Outcomes (outcome_code, outcome_description) VALUES ('OC4', 'Alpha');
INSERT INTO Project_Outcomes (outcome_code, project_id, outcome_details) VALUES ('OC1', 1, 'Details 1');
INSERT INTO Project_Outcomes (outcome_code, project_id, outcome_details) VALUES ('OC1', 2, 'Details 1');
INSERT INTO Project_Outcomes (outcome_code, project_id, outcome_details) VALUES ('OC2', 1, 'Details 2');
INSERT INTO Project_Outcomes (outcome_code, project_id, outcome_details) VALUES ('OC4', 2, 'Details 3');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT outcome_description FROM (SELECT LHS.project_id AS project_id, LHS.outcome_code AS outcome_code, LHS.outcome_details AS outcome_details, RHS.outcome_description AS outcome_description FROM project_outcomes AS LHS INNER JOIN research_outcomes AS RHS ON (LHS.outcome_code = RHS.outcome_code)) ORDER BY outcome_description;

/*
Gold Result:
('Alpha',)
('Alpha',)
('Zebra',)
('Zebra',)
*/

-- Prediction Query
SELECT T1.outcome_description FROM Research_outcomes AS T1 JOIN Project_outcomes AS T2 ON T1.outcome_code = T2.outcome_code;

/*
Prediction Result:
('Zebra',)
('Zebra',)
('Alpha',)
('Alpha',)
*/