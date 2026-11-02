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
-- Tests:
-- 1. Grouping by BOTH grant_id AND other_details (Grant 1 has 4 total documents, but split into counts 2, 1, 1; Grant 2 has 3 total documents, all with the same other_details, so count is 3).
--    Kills mutants that only GROUP BY grant_id (would return Grant 1 with count 4).
-- 2. Grouping by grant_id (Details 'D1' appears 2 times in Grant 1 and 2 times in Grant 3, total 4 times).
--    Kills mutants that only GROUP BY other_details (would return count 4).
-- 3. ORDER BY n DESC vs ASC, and LIMIT 1.
-- 4. Unreferenced Grants (Grant 4 has 0 documents) to kill LEFT JOIN mutants from Grants.
-- 5. Conflicting Grants.other_details vs Documents.other_details to kill mutants joining Grants and grouping by Grants.other_details.
-- 6. NULL values in non-grouped columns (document_type_code, sent_date, response_received_date) on the winning group to kill COUNT(col) mutants.
INSERT INTO Organisation_Types (organisation_type, organisation_type_description) VALUES ('T1', 'Type 1');
INSERT INTO Organisations (organisation_id, organisation_type, organisation_details) VALUES (1, 'T1', 'Org 1');
INSERT INTO Grants (grant_id, organisation_id, grant_amount, grant_start_date, grant_end_date, other_details) VALUES (1, 1, 1000.0, '2020-01-01', '2020-12-31', 'G_Same');
INSERT INTO Grants (grant_id, organisation_id, grant_amount, grant_start_date, grant_end_date, other_details) VALUES (2, 1, 2000.0, '2020-01-01', '2020-12-31', 'G_Diff_2');
INSERT INTO Grants (grant_id, organisation_id, grant_amount, grant_start_date, grant_end_date, other_details) VALUES (3, 1, 3000.0, '2020-01-01', '2020-12-31', 'G_Same');
INSERT INTO Grants (grant_id, organisation_id, grant_amount, grant_start_date, grant_end_date, other_details) VALUES (4, 1, 4000.0, '2020-01-01', '2020-12-31', 'G_Zero');
INSERT INTO Document_Types (document_type_code, document_description) VALUES ('DT1', 'Doc Type 1');
INSERT INTO Document_Types (document_type_code, document_description) VALUES ('DT2', 'Doc Type 2');
-- Grant 1: 4 documents total, max group (1, 'D1') has 2
INSERT INTO Documents (document_id, grant_id, document_type_code, sent_date, response_received_date, other_details) VALUES (1, 1, 'DT1', '2020-02-01', '2020-02-05', 'D1');
INSERT INTO Documents (document_id, grant_id, document_type_code, sent_date, response_received_date, other_details) VALUES (2, 1, 'DT1', '2020-02-02', '2020-02-06', 'D1');
INSERT INTO Documents (document_id, grant_id, document_type_code, sent_date, response_received_date, other_details) VALUES (3, 1, 'DT1', '2020-02-03', '2020-02-07', 'D2');
INSERT INTO Documents (document_id, grant_id, document_type_code, sent_date, response_received_date, other_details) VALUES (4, 1, 'DT1', '2020-02-04', '2020-02-08', 'D3');
-- Grant 2: 3 documents total, all in group (2, 'D4') -> Winner with count = 3
-- Includes NULLs in other columns to test COUNT(*) vs COUNT(column)
INSERT INTO Documents (document_id, grant_id, document_type_code, sent_date, response_received_date, other_details) VALUES (5, 2, NULL, NULL, NULL, 'D4');
INSERT INTO Documents (document_id, grant_id, document_type_code, sent_date, response_received_date, other_details) VALUES (6, 2, 'DT1', NULL, NULL, 'D4');
INSERT INTO Documents (document_id, grant_id, document_type_code, sent_date, response_received_date, other_details) VALUES (7, 2, 'DT2', '2020-03-01', NULL, 'D4');
-- Grant 3: 2 documents in group (3, 'D1'), making 'D1' have 4 documents across Grants 1 and 3
INSERT INTO Documents (document_id, grant_id, document_type_code, sent_date, response_received_date, other_details) VALUES (8, 3, 'DT1', '2020-04-01', '2020-04-05', 'D1');
INSERT INTO Documents (document_id, grant_id, document_type_code, sent_date, response_received_date, other_details) VALUES (9, 3, 'DT2', '2020-04-02', '2020-04-06', 'D1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT grant_id, n AS count___ FROM (SELECT * FROM (SELECT * FROM (SELECT grant_id, other_details, COUNT(*) AS n FROM documents GROUP BY grant_id, other_details) ORDER BY n DESC) LIMIT 1);

/*
Gold Result:
(2, 3)
*/

-- Prediction Query
SELECT grant_id, COUNT(*) FROM Documents GROUP BY grant_id ORDER BY COUNT(*) DESC, grant_id NULLS LAST LIMIT 1;

/*
Prediction Result:
(1, 4)
*/