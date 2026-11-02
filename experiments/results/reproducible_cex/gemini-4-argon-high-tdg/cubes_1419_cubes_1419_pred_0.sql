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
INSERT INTO Organisation_Types (organisation_type, organisation_type_description) VALUES ('UNI', 'University');
INSERT INTO Organisations (organisation_id, organisation_type, organisation_details) VALUES (1, 'UNI', 'Main University');
INSERT INTO Staff_Roles (role_code, role_description) VALUES ('researcher', 'Research Scientist');
INSERT INTO Staff_Roles (role_code, role_description) VALUES ('leader', 'Project Leader');
INSERT INTO Staff_Roles (role_code, role_description) VALUES ('analyst', 'Data Analyst');
INSERT INTO Projects (project_id, organisation_id, project_details) VALUES (1, 1, 'Gamma Project');
INSERT INTO Projects (project_id, organisation_id, project_details) VALUES (2, 1, 'Alpha Project');
INSERT INTO Projects (project_id, organisation_id, project_details) VALUES (3, 1, 'Beta Project');
INSERT INTO Projects (project_id, organisation_id, project_details) VALUES (4, 1, 'Delta Project');
INSERT INTO Project_Staff (staff_id, role_code, project_id, date_from, date_to, other_details) VALUES (101.0, 'leader', 2, '2022-01-01', '2022-12-31', 'Lead on Alpha');
INSERT INTO Project_Staff (staff_id, role_code, project_id, date_from, date_to, other_details) VALUES (102.0, 'analyst', 2, '2022-02-01', '2022-12-31', 'Analyst on Alpha');
INSERT INTO Project_Staff (staff_id, role_code, project_id, date_from, date_to, other_details) VALUES (103.0, 'researcher', 3, '2022-01-01', '2022-12-31', 'Researcher on Beta');
INSERT INTO Project_Staff (staff_id, role_code, project_id, date_from, date_to, other_details) VALUES (104.0, 'researcher', 4, '2022-01-01', '2022-06-30', 'Researcher on Delta');
INSERT INTO Project_Staff (staff_id, role_code, project_id, date_from, date_to, other_details) VALUES (105.0, 'leader', 4, '2022-01-01', '2022-12-31', 'Leader on Delta');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "project_details" FROM (SELECT * FROM "projects" AS "LHS" WHERE NOT EXISTS(SELECT 1 FROM (SELECT * FROM "project_staff" WHERE ("role_code" = 'researcher')) AS RHS WHERE (LHS.project_id = RHS.project_id))) ORDER BY project_details, "project_details" NULLS LAST;

/*
Gold Result:
('Alpha Project',)
('Gamma Project',)
*/

-- Prediction Query
SELECT project_details FROM Projects WHERE NOT project_id IN (SELECT project_id FROM Project_Staff WHERE role_code = 'researcher');

/*
Prediction Result:
('Gamma Project',)
('Alpha Project',)
*/