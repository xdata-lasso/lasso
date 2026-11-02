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
INSERT INTO "document_types" ("document_type_code", "document_description") VALUES ('science', 'Participant commercial rock clear.');
INSERT INTO "document_types" ("document_type_code", "document_description") VALUES ('executive', 'Decision wall then fire.');
INSERT INTO "organisation_types" ("organisation_type", "organisation_type_description") VALUES ('Nelson-Schaefer', 'Hawkins, Cohen and Cameron');
INSERT INTO "organisation_types" ("organisation_type", "organisation_type_description") VALUES ('Porter, Wilkerson and Day', 'Baker and Sons');
INSERT INTO "organisations" ("organisation_id", "organisation_type", "organisation_details") VALUES (1022, 'Nelson-Schaefer', 'Perez Inc');
INSERT INTO "organisations" ("organisation_id", "organisation_type", "organisation_details") VALUES (1026, 'Porter, Wilkerson and Day', 'Hoffman, Baker and Richards');
INSERT INTO "grants" ("grant_id", "organisation_id", "grant_amount", "grant_start_date", "grant_end_date", "other_details") VALUES (1023, 1022, 1024.5, '1990-10-21', '1991-11-22', 'support');
INSERT INTO "documents" ("document_id", "grant_id", "document_type_code", "sent_date", "response_received_date", "other_details") VALUES (1025, 1023, 'science', '1992-01-23', '1993-02-01', 'four');
INSERT INTO "documents" ("document_id", "grant_id", "document_type_code", "sent_date", "response_received_date", "other_details") VALUES (1028, 1023, 'executive', '1996-05-04', '1997-06-05', 'institution');
INSERT INTO "documents" ("document_id", "grant_id", "document_type_code", "sent_date", "response_received_date", "other_details") VALUES (1029, 1023, 'executive', '1996-05-04', '1997-06-05', 'institution');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT grant_id, n AS count___ FROM (SELECT * FROM (SELECT * FROM (SELECT grant_id, other_details, COUNT(*) AS n FROM documents GROUP BY grant_id, other_details) ORDER BY n DESC) LIMIT 1);

/*
Gold Result:
(1023, 2)
*/

-- Prediction Query
SELECT grant_id, COUNT(*) FROM Documents GROUP BY grant_id ORDER BY COUNT(*) DESC, grant_id NULLS LAST LIMIT 1;

/*
Prediction Result:
(1023, 3)
*/