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
INSERT INTO "Organisation_Types" ("organisation_type", "organisation_type_description") VALUES ('T1', 'Type 1');
INSERT INTO "Organisations" ("organisation_id", "organisation_type", "organisation_details") VALUES (1, 'T1', 'Org 1');
INSERT INTO "Projects" ("project_id", "organisation_id", "project_details") VALUES (1, 1, 'sint');
INSERT INTO "Research_Outcomes" ("outcome_code", "outcome_description") VALUES ('O1', 'B');
INSERT INTO "Research_Outcomes" ("outcome_code", "outcome_description") VALUES ('O2', 'A');
INSERT INTO "Project_Outcomes" ("outcome_code", "project_id", "outcome_details") VALUES ('O1', 1, 'D1');
INSERT INTO "Project_Outcomes" ("outcome_code", "project_id", "outcome_details") VALUES ('O2', 1, 'D2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "outcome_description" FROM (SELECT "LHS"."project_id" AS "project_id", "LHS"."outcome_code" AS "outcome_code", "LHS"."outcome_details" AS "outcome_details", "LHS"."organisation_id" AS "organisation_id", "LHS"."project_details" AS "project_details", "RHS"."outcome_description" AS "outcome_description" FROM (SELECT "LHS"."project_id" AS "project_id", "LHS"."outcome_code" AS "outcome_code", "LHS"."outcome_details" AS "outcome_details", "RHS"."organisation_id" AS "organisation_id", "RHS"."project_details" AS "project_details" FROM "project_outcomes" AS "LHS" INNER JOIN "projects" AS "RHS" ON ("LHS"."project_id" = "RHS"."project_id")) AS "LHS" INNER JOIN "research_outcomes" AS "RHS" ON ("LHS"."outcome_code" = "RHS"."outcome_code")) WHERE ("project_details" = 'sint') ORDER BY outcome_description, "outcome_description" NULLS LAST;

/*
Gold Result:
('A',)
('B',)
*/

-- Prediction Query
SELECT T1.outcome_description FROM Research_outcomes AS T1 JOIN Project_outcomes AS T2 ON T1.outcome_code = T2.outcome_code JOIN Projects AS T3 ON T2.project_id = T3.project_id WHERE T3.project_details = 'sint';

/*
Prediction Result:
('B',)
('A',)
*/