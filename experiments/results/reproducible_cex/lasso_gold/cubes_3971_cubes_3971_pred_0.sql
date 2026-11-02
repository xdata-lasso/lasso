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
INSERT INTO "organisation_types" ("organisation_type", "organisation_type_description") VALUES ('Bernard LLC', 'Davis Inc');
INSERT INTO "organisation_types" ("organisation_type", "organisation_type_description") VALUES ('Miller-Carter', 'Montgomery, Hensley and Ray');
INSERT INTO "staff_roles" ("role_code", "role_description") VALUES ('Mechanical engineer', 'Local government officer');
INSERT INTO "staff_roles" ("role_code", "role_description") VALUES ('Building control surveyor', 'Armed forces technical officer');
INSERT INTO "organisations" ("organisation_id", "organisation_type", "organisation_details") VALUES (1008, 'Bernard LLC', 'Baker, Williams and Stevens');
INSERT INTO "organisations" ("organisation_id", "organisation_type", "organisation_details") VALUES (1011, 'Miller-Carter', 'Perez, Roberts and Miller');
INSERT INTO "projects" ("project_id", "organisation_id", "project_details") VALUES (1009, 1008, 'capital');
INSERT INTO "projects" ("project_id", "organisation_id", "project_details") VALUES (1012, 1011, 'early');
INSERT INTO "project_staff" ("staff_id", "role_code", "project_id", "date_from", "date_to", "other_details") VALUES (1010.5, 'Mechanical engineer', 1009, '1976-07-07', '1977-08-08', 'win');
INSERT INTO "project_staff" ("staff_id", "role_code", "project_id", "date_from", "date_to", "other_details") VALUES (1013.5, 'Building control surveyor', 1012, '1978-09-09', NULL, 'trial');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT maxdate_to AS date_to FROM (SELECT other_details, MAX(date_to) AS maxdate_to FROM project_staff GROUP BY other_details) ORDER BY date_to;

/*
Gold Result:
(None,)
('1977-08-08',)
*/

-- Prediction Query
SELECT date_to FROM Project_Staff ORDER BY date_to DESC, Project_Staff.staff_id NULLS LAST LIMIT 1;

/*
Prediction Result:
('1977-08-08',)
*/