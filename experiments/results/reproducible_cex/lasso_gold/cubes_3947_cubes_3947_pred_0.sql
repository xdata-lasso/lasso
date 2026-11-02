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
INSERT INTO "document_types" ("document_type_code", "document_description") VALUES ('morning', 'Regular');
INSERT INTO "document_types" ("document_type_code", "document_description") VALUES ('lot', 'Regular');
INSERT INTO "organisation_types" ("organisation_type", "organisation_type_description") VALUES ('Moore, Yu and Miller', 'Jones Inc');
INSERT INTO "organisation_types" ("organisation_type", "organisation_type_description") VALUES ('Hickman-Walls', 'Ellis PLC');
INSERT INTO "organisations" ("organisation_id", "organisation_type", "organisation_details") VALUES (1062, 'Moore, Yu and Miller', 'Hensley, Powell and David');
INSERT INTO "organisations" ("organisation_id", "organisation_type", "organisation_details") VALUES (1068, 'Hickman-Walls', 'Jones and Sons');
INSERT INTO "grants" ("grant_id", "organisation_id", "grant_amount", "grant_start_date", "grant_end_date", "other_details") VALUES (1063, 1062, 101.0, '1988-11-08', '1989-01-09', 'over');
INSERT INTO "grants" ("grant_id", "organisation_id", "grant_amount", "grant_start_date", "grant_end_date", "other_details") VALUES (1069, 1068, 101.0, '1996-08-16', '1997-09-17', 'move');
INSERT INTO "documents" ("document_id", "grant_id", "document_type_code", "sent_date", "response_received_date", "other_details") VALUES (1064, 1063, 'morning', '1990-02-10', '1991-03-11', 'employee');
INSERT INTO "documents" ("document_id", "grant_id", "document_type_code", "sent_date", "response_received_date", "other_details") VALUES (1067, 1063, 'morning', '1994-06-14', '1995-07-15', 'first');
INSERT INTO "documents" ("document_id", "grant_id", "document_type_code", "sent_date", "response_received_date", "other_details") VALUES (1070, 1069, 'lot', '1998-10-18', '1970-11-19', 'evidence');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "response_received_date" FROM (SELECT "LHS"."grant_id" AS "grant_id", "LHS"."organisation_id" AS "organisation_id", "LHS"."grant_amount" AS "grant_amount", "LHS"."grant_start_date" AS "grant_start_date", "LHS"."grant_end_date" AS "grant_end_date", "LHS"."other_details" AS "other_details", "RHS"."document_type_code" AS "document_type_code", "RHS"."document_description" AS "document_description", "RHS"."document_id" AS "document_id", "RHS"."sent_date" AS "sent_date", "RHS"."response_received_date" AS "response_received_date", "RHS"."other_details" AS "other_details_other" FROM "grants" AS "LHS" INNER JOIN (SELECT "LHS"."document_type_code" AS "document_type_code", "LHS"."document_description" AS "document_description", "RHS"."document_id" AS "document_id", "RHS"."grant_id" AS "grant_id", "RHS"."sent_date" AS "sent_date", "RHS"."response_received_date" AS "response_received_date", "RHS"."other_details" AS "other_details" FROM "document_types" AS "LHS" INNER JOIN "documents" AS "RHS" ON ("LHS"."document_type_code" = "RHS"."document_type_code")) AS "RHS" ON ("LHS"."grant_id" = "RHS"."grant_id")) WHERE ("document_description" = 'Regular' OR grant_amount > 100.0) ORDER BY response_received_date, "response_received_date" NULLS LAST;

/*
Gold Result:
('1970-11-19',)
('1991-03-11',)
('1995-07-15',)
*/

-- Prediction Query
SELECT T1.response_received_date FROM Documents AS T1 JOIN Document_Types AS T2 ON T1.document_type_code = T2.document_type_code JOIN Grants AS T3 ON T1.grant_id = T3.grant_id WHERE T2.document_description = 'Regular' OR T3.grant_amount > 100;

/*
Prediction Result:
('1991-03-11',)
('1995-07-15',)
('1970-11-19',)
*/