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
INSERT INTO "Document_Types" ("document_type_code", "document_description") VALUES ('23', '1');
INSERT INTO "Document_Types" ("document_type_code", "document_description") VALUES ('22', '1');
INSERT INTO "Documents" ("document_id", "grant_id", "document_type_code", "sent_date", "response_received_date", "other_details") VALUES (1, NULL, '23', 1, 1, '1');
INSERT INTO "Grants" ("grant_id", "organisation_id", "grant_amount", "grant_start_date", "grant_end_date", "other_details") VALUES (24, NULL, 1, 1, 1, '1');
INSERT INTO "Organisation_Types" ("organisation_type", "organisation_type_description") VALUES ('27', '1');
INSERT INTO "Organisation_Types" ("organisation_type", "organisation_type_description") VALUES ('26', '1');
INSERT INTO "Organisations" ("organisation_id", "organisation_type", "organisation_details") VALUES (35, '27', '1');
INSERT INTO "Organisations" ("organisation_id", "organisation_type", "organisation_details") VALUES (1, '26', '1');
INSERT INTO "Project_Outcomes" ("outcome_code", "project_id", "outcome_details") VALUES ('28', 31, NULL);
INSERT INTO "Project_Outcomes" ("outcome_code", "project_id", "outcome_details") VALUES (NULL, 32, '40');
INSERT INTO "Project_Staff" ("staff_id", "role_code", "project_id", "date_from", "date_to", "other_details") VALUES (1, '34', 32, 1, 1, '1');
INSERT INTO "Projects" ("project_id", "organisation_id", "project_details") VALUES (31, 1, '46');
INSERT INTO "Projects" ("project_id", "organisation_id", "project_details") VALUES (32, 35, '47');
INSERT INTO "Research_Outcomes" ("outcome_code", "outcome_description") VALUES ('29', '1');
INSERT INTO "Research_Outcomes" ("outcome_code", "outcome_description") VALUES ('28', '1');
INSERT INTO "Research_Staff" ("staff_id", "employer_organisation_id", "staff_details") VALUES (37, 1, '1');
INSERT INTO "Research_Staff" ("staff_id", "employer_organisation_id", "staff_details") VALUES (36, 1, '1');
INSERT INTO "Staff_Roles" ("role_code", "role_description") VALUES ('33', '1');
INSERT INTO "Staff_Roles" ("role_code", "role_description") VALUES ('34', '1');
INSERT INTO "Tasks" ("task_id", "project_id", "task_details", "eg agree objectives") VALUES (39, 32, '1', '1');
INSERT INTO "Tasks" ("task_id", "project_id", "task_details", "eg agree objectives") VALUES (38, 32, '1', '1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT project_details, project_id FROM (SELECT LHS.outcome_details AS outcome_details, LHS.project_id AS project_id, LHS.maxn AS maxn, RHS.project_details AS project_details FROM (SELECT outcome_details, project_id, MAX(n) AS maxn FROM (SELECT outcome_details, project_id, COUNT(*) AS n FROM project_outcomes GROUP BY outcome_details, project_id) GROUP BY outcome_details, project_id) AS LHS INNER JOIN projects AS RHS ON (LHS.project_id = RHS.project_id AND LHS.maxn = RHS.organisation_id)) ORDER BY project_details, project_id NULLS LAST;

/*
Gold Result:
('46', 31)
*/

-- Prediction Query
SELECT T1.project_details, T1.project_id FROM Projects AS T1 JOIN Project_outcomes AS T2 ON T1.project_id = T2.project_id GROUP BY T1.project_id ORDER BY COUNT(*) DESC, T1.project_details NULLS LAST, T1.project_id NULLS LAST LIMIT 1;

/*
Prediction Result:
('46', 31)
*/