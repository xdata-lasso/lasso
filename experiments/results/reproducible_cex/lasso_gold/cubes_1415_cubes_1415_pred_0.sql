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
INSERT INTO "organisation_types" ("organisation_type", "organisation_type_description") VALUES ('Gentry PLC', 'Edwards, Rios and Foster');
INSERT INTO "organisation_types" ("organisation_type", "organisation_type_description") VALUES ('Conner Group', 'Brown, James and Ferrell');
INSERT INTO "staff_roles" ("role_code", "role_description") VALUES ('Proofreader', 'Customer service manager');
INSERT INTO "staff_roles" ("role_code", "role_description") VALUES ('Seismic interpreter', 'Food technologist');
INSERT INTO "staff_roles" ("role_code", "role_description") VALUES ('Sales executive', NULL);
INSERT INTO "organisations" ("organisation_id", "organisation_type", "organisation_details") VALUES (1020, 'Gentry PLC', 'Taylor-Mcgee');
INSERT INTO "organisations" ("organisation_id", "organisation_type", "organisation_details") VALUES (1026, 'Conner Group', 'Valencia, Smith and Le');
INSERT INTO "projects" ("project_id", "organisation_id", "project_details") VALUES (1021, 1020, 'nothing');
INSERT INTO "projects" ("project_id", "organisation_id", "project_details") VALUES (1027, 1026, 'rest');
INSERT INTO "project_staff" ("staff_id", "role_code", "project_id", "date_from", "date_to", "other_details") VALUES (1022.5, 'Proofreader', 1021, '1982-02-13', '1983-03-14', 'everyone');
INSERT INTO "project_staff" ("staff_id", "role_code", "project_id", "date_from", "date_to", "other_details") VALUES (1025.5, 'Sales executive', 1021, '1984-04-15', '1985-05-16', 'product');
INSERT INTO "project_staff" ("staff_id", "role_code", "project_id", "date_from", "date_to", "other_details") VALUES (1028.5, 'Seismic interpreter', 1027, '1986-06-17', '1987-07-18', 'value');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT project_id, n AS count___ FROM (SELECT * FROM (SELECT project_id, COUNT(*) AS n FROM project_staff GROUP BY project_id) AS LHS WHERE EXISTS(SELECT 1 FROM projects AS RHS WHERE (LHS.project_id = RHS.project_id))) ORDER BY project_id, count___ NULLS LAST;

/*
Gold Result:
(1021, 2)
(1027, 1)
*/

-- Prediction Query
SELECT T1.project_id, COUNT(*) FROM Project_Staff AS T1 JOIN Projects AS T2 ON T1.project_id = T2.project_id GROUP BY T1.project_id ORDER BY COUNT(*) ASC, T1.project_id NULLS LAST;

/*
Prediction Result:
(1027, 1)
(1021, 2)
*/