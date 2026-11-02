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
INSERT INTO Organisation_Types (organisation_type, organisation_type_description) VALUES ('T1', 'Z');
INSERT INTO Organisation_Types (organisation_type, organisation_type_description) VALUES ('T2', 'A');
INSERT INTO Organisations (organisation_id, organisation_type, organisation_details) VALUES (1, 'T1', 'quo');
INSERT INTO Organisations (organisation_id, organisation_type, organisation_details) VALUES (2, 'T2', 'quo');
INSERT INTO Organisations (organisation_id, organisation_type, organisation_details) VALUES (3, NULL, 'quo');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "organisation_type_description" FROM (SELECT "LHS"."organisation_id" AS "organisation_id", "LHS"."organisation_type" AS "organisation_type", "LHS"."organisation_details" AS "organisation_details", "RHS"."organisation_type_description" AS "organisation_type_description" FROM (SELECT * FROM "organisations" WHERE ("organisation_details" = 'quo')) AS LHS LEFT JOIN organisation_types AS RHS ON (LHS.organisation_type = RHS.organisation_type)) ORDER BY organisation_type_description, "organisation_type_description" NULLS LAST;

/*
Gold Result:
(None,)
('A',)
('Z',)
*/

-- Prediction Query
SELECT T1.organisation_type_description FROM organisation_Types AS T1 JOIN Organisations AS T2 ON T1.organisation_type = T2.organisation_type WHERE T2.organisation_details = 'quo';

/*
Prediction Result:
('Z',)
('A',)
*/