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
INSERT INTO "Document_Types" ("document_type_code", "document_description") VALUES ('20', '2');
INSERT INTO "Document_Types" ("document_type_code", "document_description") VALUES ('19', '2');
INSERT INTO "Documents" ("document_id", "grant_id", "document_type_code", "sent_date", "response_received_date", "other_details") VALUES (22, 24, '19', 2, 2, '2');
INSERT INTO "Documents" ("document_id", "grant_id", "document_type_code", "sent_date", "response_received_date", "other_details") VALUES (21, 23, '20', 2, 2, '2');
INSERT INTO "Grants" ("grant_id", "organisation_id", "grant_amount", "grant_start_date", "grant_end_date", "other_details") VALUES (23, 26, 2, 2, 2, '2');
INSERT INTO "Grants" ("grant_id", "organisation_id", "grant_amount", "grant_start_date", "grant_end_date", "other_details") VALUES (24, 26, 2, 2, 2, '2');
INSERT INTO "Organisation_Types" ("organisation_type", "organisation_type_description") VALUES ('28', '2');
INSERT INTO "Organisation_Types" ("organisation_type", "organisation_type_description") VALUES ('27', '2');
INSERT INTO "Organisations" ("organisation_id", "organisation_type", "organisation_details") VALUES (26, '27', '2');
INSERT INTO "Project_Outcomes" ("outcome_code", "project_id", "outcome_details") VALUES ('30', 2, '2');
INSERT INTO "Project_Outcomes" ("outcome_code", "project_id", "outcome_details") VALUES ('30', 2, '2');
INSERT INTO "Project_Staff" ("staff_id", "role_code", "project_id", "date_from", "date_to", "other_details") VALUES (37, '45', 2, 38, 39, '40');
INSERT INTO "Project_Staff" ("staff_id", "role_code", "project_id", "date_from", "date_to", "other_details") VALUES (41, '45', 2, 42, 43, '44');
INSERT INTO "Projects" ("project_id", "organisation_id", "project_details") VALUES (2, 26, '2');
INSERT INTO "Research_Outcomes" ("outcome_code", "outcome_description") VALUES ('29', '2');
INSERT INTO "Research_Outcomes" ("outcome_code", "outcome_description") VALUES ('30', '2');
INSERT INTO "Research_Staff" ("staff_id", "employer_organisation_id", "staff_details") VALUES (2, 26, '2');
INSERT INTO "Staff_Roles" ("role_code", "role_description") VALUES ('31', '2');
INSERT INTO "Staff_Roles" ("role_code", "role_description") VALUES ('45', '2');
INSERT INTO "Tasks" ("task_id", "project_id", "task_details", "eg agree objectives") VALUES (33, NULL, '2', '2');
INSERT INTO "Tasks" ("task_id", "project_id", "task_details", "eg agree objectives") VALUES (32, 2, '2', '2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT role_code FROM (SELECT LHS.role_code AS role_code, LHS.n AS n, LHS.maxn AS maxn, RHS.staff_id AS staff_id, RHS.date_from AS date_from, RHS.date_to AS date_to, RHS.other_details AS other_details FROM (SELECT role_code, n, MAX(n) OVER () AS maxn FROM (SELECT role_code, COUNT(*) AS n FROM project_staff GROUP BY role_code)) AS LHS INNER JOIN project_staff AS RHS ON (LHS.maxn = RHS.project_id AND LHS.role_code = RHS.role_code)) ORDER BY role_code;

/*
Gold Result:
('45',)
('45',)
*/

-- Prediction Query
SELECT role_code FROM Project_Staff GROUP BY role_code ORDER BY COUNT(*) DESC, role_code NULLS LAST LIMIT 1;

/*
Prediction Result:
('45',)
*/