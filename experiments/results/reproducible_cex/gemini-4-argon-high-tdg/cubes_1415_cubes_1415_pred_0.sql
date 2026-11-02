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
INSERT INTO Staff_Roles (role_code, role_description) VALUES ('RES', 'Researcher');
INSERT INTO Staff_Roles (role_code, role_description) VALUES ('LEAD', 'Project Lead');
INSERT INTO Projects (project_id, organisation_id, project_details) VALUES (10, 1, 'Alpha Project');
INSERT INTO Projects (project_id, organisation_id, project_details) VALUES (20, 1, 'Beta Project');
INSERT INTO Projects (project_id, organisation_id, project_details) VALUES (30, 1, 'Gamma Project');
INSERT INTO Projects (project_id, organisation_id, project_details) VALUES (40, 1, 'Unstaffed Project');
INSERT INTO Project_Staff (staff_id, role_code, project_id, date_from, date_to, other_details) VALUES (101.0, 'LEAD', 10, '2023-01-01', '2023-12-31', 'Full time');
INSERT INTO Project_Staff (staff_id, role_code, project_id, date_from, date_to, other_details) VALUES (102.0, 'RES', 10, '2023-02-01', '2023-12-31', 'Part time');
INSERT INTO Project_Staff (staff_id, role_code, project_id, date_from, date_to, other_details) VALUES (103.0, 'RES', 10, '2023-03-01', '2023-12-31', 'Contractor');
INSERT INTO Project_Staff (staff_id, role_code, project_id, date_from, date_to, other_details) VALUES (104.0, 'LEAD', 20, '2023-01-01', '2023-06-30', 'Lead only');
INSERT INTO Project_Staff (staff_id, role_code, project_id, date_from, date_to, other_details) VALUES (105.0, 'LEAD', 30, '2023-01-01', '2023-12-31', 'Co-lead 1');
INSERT INTO Project_Staff (staff_id, role_code, project_id, date_from, date_to, other_details) VALUES (106.0, 'RES', 30, '2023-01-01', '2023-12-31', 'Researcher 1');
INSERT INTO Project_Staff (staff_id, role_code, project_id, date_from, date_to, other_details) VALUES (107.0, 'RES', NULL, '2023-01-01', '2023-12-31', 'Unassigned staff 1');
INSERT INTO Project_Staff (staff_id, role_code, project_id, date_from, date_to, other_details) VALUES (108.0, 'LEAD', NULL, '2023-05-01', '2023-12-31', 'Unassigned staff 2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT project_id, n AS count___ FROM (SELECT * FROM (SELECT project_id, COUNT(*) AS n FROM project_staff GROUP BY project_id) AS LHS WHERE EXISTS(SELECT 1 FROM projects AS RHS WHERE (LHS.project_id = RHS.project_id))) ORDER BY project_id, count___ NULLS LAST;

/*
Gold Result:
(10, 3)
(20, 1)
(30, 2)
*/

-- Prediction Query
SELECT T1.project_id, COUNT(*) FROM Project_Staff AS T1 JOIN Projects AS T2 ON T1.project_id = T2.project_id GROUP BY T1.project_id ORDER BY COUNT(*) ASC, T1.project_id NULLS LAST;

/*
Prediction Result:
(20, 1)
(30, 2)
(10, 3)
*/