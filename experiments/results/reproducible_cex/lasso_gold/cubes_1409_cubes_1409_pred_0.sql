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
INSERT INTO "organisation_types" ("organisation_type", "organisation_type_description") VALUES ('Cruz PLC', 'Rice-Maddox');
INSERT INTO "organisation_types" ("organisation_type", "organisation_type_description") VALUES ('Sellers, George and Burns', 'Hickman LLC');
INSERT INTO "research_outcomes" ("outcome_code", "outcome_description") VALUES ('traditional', 'Quite boy those.');
INSERT INTO "research_outcomes" ("outcome_code", "outcome_description") VALUES ('education', 'Drive note bad rule.');
INSERT INTO "organisations" ("organisation_id", "organisation_type", "organisation_details") VALUES (1013, 'Cruz PLC', 'Mack-Peterson');
INSERT INTO "organisations" ("organisation_id", "organisation_type", "organisation_details") VALUES (1017, 'Sellers, George and Burns', 'Spence PLC');
INSERT INTO "projects" ("project_id", "organisation_id", "project_details") VALUES (1014, 1013, 'finally');
INSERT INTO "projects" ("project_id", "organisation_id", "project_details") VALUES (1018, 1017, 'space');
INSERT INTO "projects" ("project_id", "organisation_id", "project_details") VALUES (1016, NULL, NULL);
INSERT INTO "project_outcomes" ("outcome_code", "project_id", "outcome_details") VALUES ('traditional', 1014, 'learn');
INSERT INTO "project_outcomes" ("outcome_code", "project_id", "outcome_details") VALUES ('traditional', 1016, 'start');
INSERT INTO "project_outcomes" ("outcome_code", "project_id", "outcome_details") VALUES ('education', 1018, 'car');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT outcome_description FROM (SELECT LHS.project_id AS project_id, LHS.outcome_code AS outcome_code, LHS.outcome_details AS outcome_details, RHS.outcome_description AS outcome_description FROM project_outcomes AS LHS INNER JOIN research_outcomes AS RHS ON (LHS.outcome_code = RHS.outcome_code)) ORDER BY outcome_description;

/*
Gold Result:
('Drive note bad rule.',)
('Quite boy those.',)
('Quite boy those.',)
*/

-- Prediction Query
SELECT T1.outcome_description FROM Research_outcomes AS T1 JOIN Project_outcomes AS T2 ON T1.outcome_code = T2.outcome_code;

/*
Prediction Result:
('Quite boy those.',)
('Quite boy those.',)
('Drive note bad rule.',)
*/