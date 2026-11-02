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
-- 1. Tie for maximum organisation count (returns multiple organisation_types).
-- 2. Ordering of tied results (ORDER BY organisation_type).
-- 3. Mutants that mistakenly INNER JOIN Research_Staff on employer_organisation_id = organisation_id instead of CROSS JOIN (here, all staff belong to TYPE_A, which has the lowest count).
-- 4. Mutants that count grants, projects, or staff instead of organisations.
-- 5. Mutants that omit DISTINCT (multiple organisations and multiple staff cause duplicate rows before DISTINCT).
INSERT INTO "Organisation_Types" ("organisation_type", "organisation_type_description") VALUES ('TYPE_A', 'Small Type');
INSERT INTO "Organisation_Types" ("organisation_type", "organisation_type_description") VALUES ('TYPE_B', 'Max Type 1');
INSERT INTO "Organisation_Types" ("organisation_type", "organisation_type_description") VALUES ('TYPE_C', 'Max Type 2');
INSERT INTO "Organisation_Types" ("organisation_type", "organisation_type_description") VALUES ('TYPE_D', 'Unused Type');
INSERT INTO "Organisations" ("organisation_id", "organisation_type", "organisation_details") VALUES (1, 'TYPE_A', 'Org 1');
INSERT INTO "Organisations" ("organisation_id", "organisation_type", "organisation_details") VALUES (2, 'TYPE_B', 'Org 2');
INSERT INTO "Organisations" ("organisation_id", "organisation_type", "organisation_details") VALUES (3, 'TYPE_B', 'Org 3');
INSERT INTO "Organisations" ("organisation_id", "organisation_type", "organisation_details") VALUES (4, 'TYPE_C', 'Org 4');
INSERT INTO "Organisations" ("organisation_id", "organisation_type", "organisation_details") VALUES (5, 'TYPE_C', 'Org 5');
INSERT INTO "Research_Staff" ("staff_id", "employer_organisation_id", "staff_details") VALUES (101, 1, 'Staff 1 in Type A');
INSERT INTO "Research_Staff" ("staff_id", "employer_organisation_id", "staff_details") VALUES (102, 1, 'Staff 2 in Type A');
INSERT INTO "Research_Staff" ("staff_id", "employer_organisation_id", "staff_details") VALUES (103, 1, 'Staff 3 in Type A');
INSERT INTO "Grants" ("grant_id", "organisation_id", "grant_amount", "grant_start_date", "grant_end_date", "other_details") VALUES (201, 1, 5000.0, '2023-01-01 00:00:00', '2023-12-31 00:00:00', 'Grant 1');
INSERT INTO "Grants" ("grant_id", "organisation_id", "grant_amount", "grant_start_date", "grant_end_date", "other_details") VALUES (202, 1, 6000.0, '2023-01-01 00:00:00', '2023-12-31 00:00:00', 'Grant 2');
INSERT INTO "Grants" ("grant_id", "organisation_id", "grant_amount", "grant_start_date", "grant_end_date", "other_details") VALUES (203, 1, 7000.0, '2023-01-01 00:00:00', '2023-12-31 00:00:00', 'Grant 3');
INSERT INTO "Projects" ("project_id", "organisation_id", "project_details") VALUES (301, 1, 'Proj 1');
INSERT INTO "Projects" ("project_id", "organisation_id", "project_details") VALUES (302, 1, 'Proj 2');
INSERT INTO "Projects" ("project_id", "organisation_id", "project_details") VALUES (303, 1, 'Proj 3');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT organisation_type FROM (SELECT LHS.organisation_id AS organisation_id, LHS.organisation_type AS organisation_type, LHS.organisation_details AS organisation_details, LHS.staff_id AS staff_id, LHS.employer_organisation_id AS employer_organisation_id, LHS.staff_details AS staff_details, LHS.n AS n FROM (SELECT LHS.organisation_id AS organisation_id, LHS.organisation_type AS organisation_type, LHS.organisation_details AS organisation_details, LHS.staff_id AS staff_id, LHS.employer_organisation_id AS employer_organisation_id, LHS.staff_details AS staff_details, RHS.n AS n FROM (SELECT LHS.organisation_id AS organisation_id, LHS.organisation_type AS organisation_type, LHS.organisation_details AS organisation_details, RHS.staff_id AS staff_id, RHS.employer_organisation_id AS employer_organisation_id, RHS.staff_details AS staff_details FROM organisations AS LHS CROSS JOIN research_staff AS RHS) AS LHS INNER JOIN (SELECT organisation_type, COUNT(*) AS n FROM organisations GROUP BY organisation_type) AS RHS ON (LHS.organisation_type = RHS.organisation_type)) AS LHS INNER JOIN (SELECT organisation_type, MAX(n) OVER () AS n FROM (SELECT organisation_type, COUNT(*) AS n FROM organisations GROUP BY organisation_type)) AS RHS ON (LHS.organisation_type = RHS.organisation_type AND LHS.n = RHS.n)) ORDER BY organisation_type;

/*
Gold Result:
('TYPE_B',)
('TYPE_C',)
*/

-- Prediction Query
SELECT T1.organisation_type FROM Organisations AS T1 JOIN Research_Staff AS T2 ON T1.organisation_id = T2.employer_organisation_id GROUP BY T1.organisation_type ORDER BY COUNT(*) DESC, T1.organisation_type NULLS LAST LIMIT 1;

/*
Prediction Result:
('TYPE_A',)
*/