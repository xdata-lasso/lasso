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
INSERT INTO "Organisation_Types" ("organisation_type", "organisation_type_description") VALUES ('UNI', 'University');
INSERT INTO "Organisations" ("organisation_id", "organisation_type", "organisation_details") VALUES (1, 'UNI', 'Main Research University');
INSERT INTO "Document_Types" ("document_type_code", "document_description") VALUES ('REG', 'Regular');
INSERT INTO "Document_Types" ("document_type_code", "document_description") VALUES ('SPE', 'Special');
INSERT INTO "Document_Types" ("document_type_code", "document_description") VALUES ('Regular', 'Not Regular');
INSERT INTO "Grants" ("grant_id", "organisation_id", "grant_amount", "grant_start_date", "grant_end_date", "other_details") VALUES (1, 1, 150.0, '2022-01-01 00:00:00', '2024-01-01 00:00:00', 'High Grant');
INSERT INTO "Grants" ("grant_id", "organisation_id", "grant_amount", "grant_start_date", "grant_end_date", "other_details") VALUES (2, 1, 100.0, '2022-02-01 00:00:00', '2024-02-01 00:00:00', 'Boundary Grant');
INSERT INTO "Grants" ("grant_id", "organisation_id", "grant_amount", "grant_start_date", "grant_end_date", "other_details") VALUES (3, 1, 50.0, '2022-03-01 00:00:00', '2024-03-01 00:00:00', 'Low Grant');
INSERT INTO "Documents" ("document_id", "grant_id", "document_type_code", "sent_date", "response_received_date", "other_details") VALUES (1, 1, 'REG', '2023-01-01 09:00:00', '2023-04-10 10:00:00', 'Both True');
INSERT INTO "Documents" ("document_id", "grant_id", "document_type_code", "sent_date", "response_received_date", "other_details") VALUES (2, 1, 'SPE', '2023-03-01 09:00:00', '2023-01-15 08:30:00', 'Amount True Only');
INSERT INTO "Documents" ("document_id", "grant_id", "document_type_code", "sent_date", "response_received_date", "other_details") VALUES (3, 2, 'REG', '2023-02-01 09:00:00', '2023-03-20 14:00:00', 'Description True At Boundary');
INSERT INTO "Documents" ("document_id", "grant_id", "document_type_code", "sent_date", "response_received_date", "other_details") VALUES (4, 2, 'SPE', '2023-01-10 09:00:00', '2023-02-10 09:00:00', 'Both False At Boundary 100');
INSERT INTO "Documents" ("document_id", "grant_id", "document_type_code", "sent_date", "response_received_date", "other_details") VALUES (5, 3, 'REG', '2023-04-01 09:00:00', '2023-01-15 08:30:00', 'Description True Only Duplicate Date');
INSERT INTO "Documents" ("document_id", "grant_id", "document_type_code", "sent_date", "response_received_date", "other_details") VALUES (6, 3, 'SPE', '2023-01-05 09:00:00', '2022-12-01 12:00:00', 'Both False');
INSERT INTO "Documents" ("document_id", "grant_id", "document_type_code", "sent_date", "response_received_date", "other_details") VALUES (7, 3, 'Regular', '2023-01-06 09:00:00', '2022-11-11 11:11:11', 'Code Is Regular But Description Is Not');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "response_received_date" FROM (SELECT "LHS"."grant_id" AS "grant_id", "LHS"."organisation_id" AS "organisation_id", "LHS"."grant_amount" AS "grant_amount", "LHS"."grant_start_date" AS "grant_start_date", "LHS"."grant_end_date" AS "grant_end_date", "LHS"."other_details" AS "other_details", "RHS"."document_type_code" AS "document_type_code", "RHS"."document_description" AS "document_description", "RHS"."document_id" AS "document_id", "RHS"."sent_date" AS "sent_date", "RHS"."response_received_date" AS "response_received_date", "RHS"."other_details" AS "other_details_other" FROM "grants" AS "LHS" INNER JOIN (SELECT "LHS"."document_type_code" AS "document_type_code", "LHS"."document_description" AS "document_description", "RHS"."document_id" AS "document_id", "RHS"."grant_id" AS "grant_id", "RHS"."sent_date" AS "sent_date", "RHS"."response_received_date" AS "response_received_date", "RHS"."other_details" AS "other_details" FROM "document_types" AS "LHS" INNER JOIN "documents" AS "RHS" ON ("LHS"."document_type_code" = "RHS"."document_type_code")) AS "RHS" ON ("LHS"."grant_id" = "RHS"."grant_id")) WHERE ("document_description" = 'Regular' OR grant_amount > 100.0) ORDER BY response_received_date, "response_received_date" NULLS LAST;

/*
Gold Result:
('2023-01-15 08:30:00',)
('2023-01-15 08:30:00',)
('2023-03-20 14:00:00',)
('2023-04-10 10:00:00',)
*/

-- Prediction Query
SELECT T1.response_received_date FROM Documents AS T1 JOIN Document_Types AS T2 ON T1.document_type_code = T2.document_type_code JOIN Grants AS T3 ON T1.grant_id = T3.grant_id WHERE T2.document_description = 'Regular' OR T3.grant_amount > 100;

/*
Prediction Result:
('2023-04-10 10:00:00',)
('2023-01-15 08:30:00',)
('2023-03-20 14:00:00',)
('2023-01-15 08:30:00',)
*/