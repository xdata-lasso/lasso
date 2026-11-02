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
INSERT INTO "organisation_types" ("organisation_type", "organisation_type_description") VALUES ('Chavez-Flowers', 'Research_z');
INSERT INTO "organisations" ("organisation_id", "organisation_type", "organisation_details") VALUES (1024, 'Chavez-Flowers', 'Wood and Sons');
INSERT INTO "grants" ("grant_id", "organisation_id", "grant_amount", "grant_start_date", "grant_end_date", "other_details") VALUES (1025, 1024, 1026.5, '1984-04-15', '1985-05-16', 'religious');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT SUM("grant_amount") OVER () AS "sum_grant_amount_" FROM (SELECT "LHS"."grant_id" AS "grant_id", "LHS"."organisation_id" AS "organisation_id", "LHS"."grant_amount" AS "grant_amount", "LHS"."grant_start_date" AS "grant_start_date", "LHS"."grant_end_date" AS "grant_end_date", "LHS"."other_details" AS "other_details", "LHS"."organisation_type" AS "organisation_type", "LHS"."organisation_type_description" AS "organisation_type_description", "RHS"."organisation_details" AS "organisation_details" FROM (SELECT "LHS"."grant_id" AS "grant_id", "LHS"."organisation_id" AS "organisation_id", "LHS"."grant_amount" AS "grant_amount", "LHS"."grant_start_date" AS "grant_start_date", "LHS"."grant_end_date" AS "grant_end_date", "LHS"."other_details" AS "other_details", "RHS"."organisation_type" AS "organisation_type", "RHS"."organisation_type_description" AS "organisation_type_description" FROM "grants" AS "LHS" CROSS JOIN "organisation_types" AS "RHS") AS "LHS" INNER JOIN "organisations" AS "RHS" ON ("LHS"."organisation_id" = "RHS"."organisation_id" AND "LHS"."organisation_type" = "RHS"."organisation_type")) WHERE ("organisation_type_description" = 'Research') ORDER BY sum_grant_amount_;

/*
Gold Result:
*/

-- Prediction Query
SELECT SUM(grant_amount) FROM Grants AS T1 JOIN Organisations AS T2 ON T1.organisation_id = T2.organisation_id JOIN organisation_Types AS T3 ON T2.organisation_type = T3.organisation_type WHERE T3.organisation_type_description = 'Research';

/*
Prediction Result:
(None,)
*/