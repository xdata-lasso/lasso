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
INSERT INTO "Organisation_Types" ("organisation_type", "organisation_type_description") VALUES ('OT1', 'Type 1');
INSERT INTO "Organisations" ("organisation_id", "organisation_type", "organisation_details") VALUES (1, 'OT1', 'Org 1');
INSERT INTO "Organisations" ("organisation_id", "organisation_type", "organisation_details") VALUES (2, 'OT1', 'Org 2');
INSERT INTO "Organisations" ("organisation_id", "organisation_type", "organisation_details") VALUES (3, 'OT1', 'Org 3');
INSERT INTO "Research_Outcomes" ("outcome_code", "outcome_description") VALUES ('OC1', 'Desc 1');
INSERT INTO "Research_Outcomes" ("outcome_code", "outcome_description") VALUES ('OC2', 'Desc 2');
INSERT INTO "Projects" ("project_id", "organisation_id", "project_details") VALUES (10, 2, 'Alpha');
INSERT INTO "Projects" ("project_id", "organisation_id", "project_details") VALUES (20, 1, 'Alpha');
INSERT INTO "Projects" ("project_id", "organisation_id", "project_details") VALUES (30, 3, 'Beta');
INSERT INTO "Projects" ("project_id", "organisation_id", "project_details") VALUES (40, 2, NULL);
INSERT INTO "Projects" ("project_id", "organisation_id", "project_details") VALUES (50, 1, 'Gamma');
INSERT INTO "Project_Outcomes" ("outcome_code", "project_id", "outcome_details") VALUES ('OC1', 10, 'Detail A');
INSERT INTO "Project_Outcomes" ("outcome_code", "project_id", "outcome_details") VALUES ('OC2', 10, 'Detail A');
INSERT INTO "Project_Outcomes" ("outcome_code", "project_id", "outcome_details") VALUES ('OC1', 10, 'Detail B');
INSERT INTO "Project_Outcomes" ("outcome_code", "project_id", "outcome_details") VALUES ('OC1', 20, 'Detail C');
INSERT INTO "Project_Outcomes" ("outcome_code", "project_id", "outcome_details") VALUES ('OC1', 20, 'Detail D');
INSERT INTO "Project_Outcomes" ("outcome_code", "project_id", "outcome_details") VALUES ('OC1', 30, 'Detail E');
INSERT INTO "Project_Outcomes" ("outcome_code", "project_id", "outcome_details") VALUES ('OC2', 30, 'Detail E');
INSERT INTO "Project_Outcomes" ("outcome_code", "project_id", "outcome_details") VALUES ('OC1', 40, NULL);
INSERT INTO "Project_Outcomes" ("outcome_code", "project_id", "outcome_details") VALUES ('OC2', 40, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT project_details, project_id FROM (SELECT LHS.project_id AS project_id, LHS.organisation_id AS organisation_id, LHS.project_details AS project_details, RHS.outcome_details AS outcome_details FROM projects AS LHS INNER JOIN (SELECT outcome_details, project_id, COUNT(*) AS n FROM project_outcomes GROUP BY outcome_details, project_id) AS RHS ON (LHS.project_id = RHS.project_id AND LHS.organisation_id = RHS.n)) ORDER BY project_details, project_id NULLS LAST;

/*
Gold Result:
(None, 40)
('Alpha', 10)
('Alpha', 20)
('Alpha', 20)
*/

-- Prediction Query
SELECT T1.project_details, T1.project_id FROM Projects AS T1 JOIN Project_outcomes AS T2 ON T1.project_id = T2.project_id GROUP BY T1.project_id ORDER BY COUNT(*) DESC, T1.project_details NULLS LAST, T1.project_id NULLS LAST LIMIT 1;

/*
Prediction Result:
('Alpha', 10)
*/