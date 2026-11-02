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
INSERT INTO Organisation_Types (organisation_type, organisation_type_description) VALUES ('OT1', 'University');
INSERT INTO Organisations (organisation_id, organisation_type, organisation_details) VALUES (1, 'OT1', 'Org 1');
INSERT INTO Document_Types (document_type_code, document_description) VALUES ('DT1', 'Regular');
INSERT INTO Document_Types (document_type_code, document_description) VALUES ('DT2', 'Special');
INSERT INTO Document_Types (document_type_code, document_description) VALUES ('DT3', 'regular');
INSERT INTO Grants (grant_id, organisation_id, grant_amount, grant_start_date, grant_end_date, other_details) VALUES (10, 1, 50.0, '2020-01-01', '2020-12-31', 'Less than 100');
INSERT INTO Grants (grant_id, organisation_id, grant_amount, grant_start_date, grant_end_date, other_details) VALUES (20, 1, 100.0, '2020-01-01', '2020-12-31', 'Exact 100 boundary');
INSERT INTO Grants (grant_id, organisation_id, grant_amount, grant_start_date, grant_end_date, other_details) VALUES (30, 1, 100.01, '2020-01-01', '2020-12-31', 'Just above 100');
INSERT INTO Grants (grant_id, organisation_id, grant_amount, grant_start_date, grant_end_date, other_details) VALUES (40, 1, 500.0, '2020-01-01', '2020-12-31', 'Well above 100');
INSERT INTO Documents (document_id, grant_id, document_type_code, sent_date, response_received_date, other_details) VALUES (1, 10, 'DT1', '2020-01-01', '2021-03-01', 'True, False -> Include');
INSERT INTO Documents (document_id, grant_id, document_type_code, sent_date, response_received_date, other_details) VALUES (2, 20, 'DT2', '2020-01-02', '2021-01-01', 'False, False (Boundary 100.0) -> Exclude');
INSERT INTO Documents (document_id, grant_id, document_type_code, sent_date, response_received_date, other_details) VALUES (3, 30, 'DT2', '2020-01-03', '2021-02-01', 'False, True (100.01) -> Include');
INSERT INTO Documents (document_id, grant_id, document_type_code, sent_date, response_received_date, other_details) VALUES (4, 40, 'DT1', '2020-01-04', '2021-04-01', 'True, True -> Include');
INSERT INTO Documents (document_id, grant_id, document_type_code, sent_date, response_received_date, other_details) VALUES (5, 20, 'DT3', '2020-01-05', '2021-05-01', 'Case sensitivity test -> Exclude');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "response_received_date" FROM (SELECT "LHS"."grant_id" AS "grant_id", "LHS"."organisation_id" AS "organisation_id", "LHS"."grant_amount" AS "grant_amount", "LHS"."grant_start_date" AS "grant_start_date", "LHS"."grant_end_date" AS "grant_end_date", "LHS"."other_details" AS "other_details", "RHS"."document_type_code" AS "document_type_code", "RHS"."document_description" AS "document_description", "RHS"."document_id" AS "document_id", "RHS"."sent_date" AS "sent_date", "RHS"."response_received_date" AS "response_received_date", "RHS"."other_details" AS "other_details_other" FROM "grants" AS "LHS" INNER JOIN (SELECT "LHS"."document_type_code" AS "document_type_code", "LHS"."document_description" AS "document_description", "RHS"."document_id" AS "document_id", "RHS"."grant_id" AS "grant_id", "RHS"."sent_date" AS "sent_date", "RHS"."response_received_date" AS "response_received_date", "RHS"."other_details" AS "other_details" FROM "document_types" AS "LHS" INNER JOIN "documents" AS "RHS" ON ("LHS"."document_type_code" = "RHS"."document_type_code")) AS "RHS" ON ("LHS"."grant_id" = "RHS"."grant_id")) WHERE ("document_description" = 'Regular' OR grant_amount > 100.0) ORDER BY response_received_date, "response_received_date" NULLS LAST;

/*
Gold Result:
('2021-02-01',)
('2021-03-01',)
('2021-04-01',)
*/

-- Prediction Query
SELECT T1.response_received_date FROM Documents AS T1 JOIN Document_Types AS T2 ON T1.document_type_code = T2.document_type_code JOIN Grants AS T3 ON T1.grant_id = T3.grant_id WHERE T2.document_description = 'Regular' OR T3.grant_amount > 100;

/*
Prediction Result:
('2021-03-01',)
('2021-02-01',)
('2021-04-01',)
*/